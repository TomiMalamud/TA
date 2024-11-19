#include <WiFi.h>
#include <ThingSpeak.h>
#include <DHT.h>
#include <DHT_U.h>
#include <splash.h>
#include <Arduino.h>

// Pines
const int pinPote = 32;          // Pin analógico para el potenciómetro
const int DHT_PIN = 33;           // Pin digital para el sensor DHT22
const int pinPulsador = 19;       // Pin digital para el pulsador

// Definir el sensor DHT22
DHT dht(DHT_PIN, DHT22);           // Inicializa el sensor DHT22 con el pin especificado

// Configuración de la red Wi-Fi
const char *SSID = "Fibertel WiFi122 2.4GHz";  // Nombre de la red Wi-Fi
const char *PASS = "menXuz-terre1-dantib";      // Contraseña de la red Wi-Fi

// Definición de parámetros para ThingSpeak
unsigned long nroCanalPrivado = 1234567; // Reemplazar con tu número de canal privado en ThingSpeak
const char * WriteAPIKey = "";            // Clave de escritura de ThingSpeak (a completar)
const char * ReadAPIKey = "";             // Clave de lectura de ThingSpeak (a completar)
unsigned int nroCampoTemperatura= 1;      // Número del campo para la temperatura en ThingSpeak
unsigned int nroCampoHumedad= 2;          // Número del campo para la humedad en ThingSpeak
unsigned int nroCampoPotenciometro= 3;    // Número del campo para el potenciómetro en ThingSpeak

// VARIABLES
float temp;                     // Variable para almacenar la temperatura leída del DHT22
float hum;                      // Variable para almacenar la humedad leída del DHT22
int estadoPote;                // Variable para almacenar el valor actual del potenciómetro
int estadoBoton = HIGH;        // Estado actual del pulsador (inicialmente HIGH)
int ultimoEstado = HIGH;        // Último estado registrado del pulsador
unsigned long ultimoRebote = 0; // Tiempo del último rebote del pulsador
int delayRebote = 50;           // Tiempo de rebote en milisegundos
int contadorPulsador = 0;       // Contador de pulsaciones del pulsador
unsigned long currentTime = 0;   // Tiempo actual en milisegundos
unsigned long previousTime = 0;  // Tiempo de la última subida a ThingSpeak
unsigned long lastUploadTime = 0; // Tiempo de la última subida (inicializado)
const long timeoutTime = 2000;    // Tiempo de espera para la conexión Wi-Fi
WiFiClient client;                // Cliente Wi-Fi para ThingSpeak
WiFiServer server(80);            // Servidor web en el puerto 80
String header;                    // Variable para almacenar la cabecera HTTP

void setup() {
  Serial.begin(115200);          // Inicia la comunicación serial a 115200 baudios

  // Inicializar DHT
  dht.begin();                    // Inicia el sensor DHT22

  // Configurar el pin del pulsador
  pinMode(pinPulsador, INPUT_PULLUP); // Configura el pin del pulsador como entrada con resistencia pull-up

  // Conectar al Wi-Fi
  WiFi.begin(SSID, PASS);              // Inicia la conexión Wi-Fi con el SSID y la contraseña proporcionados
  while (WiFi.status() != WL_CONNECTED) { // Espera hasta que la conexión Wi-Fi se establezca
    delay(500);
    Serial.print(".");                   // Indica en el monitor serial que está intentando conectarse
  }
  Serial.println("\nConectado a Wi-Fi!"); // Confirma que la conexión Wi-Fi fue exitosa
  Serial.print("\nIP: ");
  Serial.println(WiFi.localIP());        // Imprime la dirección IP asignada al ESP32

  ThingSpeak.begin(client);  // Inicia la comunicación con ThingSpeak

  // Inicializar el contador de pulsador
  lastUploadTime = millis(); // Guarda el tiempo actual para la primera subida a ThingSpeak
}

void loop() {
  currentTime = millis(); // Actualiza el tiempo actual

  // Conectar o reconectar al Wi-Fi si está desconectado
  if(WiFi.status() != WL_CONNECTED){
    Serial.print("\nIntentando conectarse a: ");
    Serial.println(String(SSID));
    while(WiFi.status() != WL_CONNECTED){
      WiFi.begin(SSID, PASS); // Intenta reconectar al Wi-Fi
      Serial.print(".");        // Indica en el monitor serial que está intentando reconectar
      delay(500);
    }
    Serial.println("\nConectado."); // Confirma que la reconexión fue exitosa
  }

  // MANEJO DE PULSADOR Y CONTAR PULSADOR
  int lectura = digitalRead(pinPulsador); // Lee el estado actual del pulsador

  // Si el estado del pulsador ha cambiado, registrar el tiempo de rebote
  if (lectura != ultimoEstado) {
    ultimoRebote = millis(); // Actualiza el tiempo del último rebote
  }

  // Si ha pasado suficiente tiempo desde el último rebote, actualizar el estado del pulsador
  if ((millis() - ultimoRebote) > delayRebote) {
    // Si el estado del pulsador ha cambiado, actualizar el estado del botón
    if (lectura != estadoBoton) {
      estadoBoton = lectura; // Actualiza el estado del botón

      // Si el pulsador ha sido presionado, incrementar el contador y notificar por serial
      if (estadoBoton == HIGH) {
        contadorPulsador = contadorPulsador + 1; // Incrementa el contador de pulsaciones
        Serial.println("Se ha presionado el pulsador"); // Notifica la pulsación en el monitor serial
      }
    }
  }
  // Guardar el último estado del pulsador
  ultimoEstado = lectura; // Actualiza el último estado registrado del pulsador

  // MANEJO DE POTENCIOMETRO
  estadoPote = map(analogRead(pinPote), 0, 4095, 4095, 0); // Lee y mapea el valor del potenciómetro
  ThingSpeak.setField(nroCampoPotenciometro, estadoPote);   // Asigna el valor del potenciómetro al campo correspondiente en ThingSpeak

  // MANEJO DE SENSOR TEMPERATURA Y HUMEDAD
  temp = dht.readTemperature(); // Lee la temperatura del sensor DHT22
  hum = dht.readHumidity();     // Lee la humedad del sensor DHT22
  ThingSpeak.setField(nroCampoHumedad, hum);           // Asigna el valor de humedad al campo correspondiente en ThingSpeak
  ThingSpeak.setField(nroCampoTemperatura, temp);      // Asigna el valor de temperatura al campo correspondiente en ThingSpeak
  ThingSpeak.setStatus("Cantidad de pulsaciones: " + String(contadorPulsador)); // Actualiza el estado con el contador de pulsaciones
  
  // Verifica si han pasado 20 segundos para subir los datos a ThingSpeak
  if ((currentTime - previousTime) >= 20000) {
    previousTime = currentTime; // Actualiza el tiempo de la última subida
    if (ThingSpeak.writeFields(nroCanalPrivado, WriteAPIKey) == 200) { // Intenta escribir los campos en ThingSpeak
      Serial.println("Se realizó escritura en ThingSpeak"); // Notifica éxito en el monitor serial
    } else {
      Serial.println("Error al escribir en ThingSpeak"); // Notifica error en el monitor serial
    }
  }

  // Mostrar la página web (Servidor Web)
  WiFiClient client = server.available(); // Espera a que un cliente se conecte al servidor

  if (client) { // Si hay un cliente conectado
    String currentLine = ""; // Variable para almacenar la línea actual de la solicitud HTTP

    // Lee la solicitud HTTP
    while (client.connected()) {
      if (client.available()) { // Si hay datos disponibles para leer
        char c = client.read(); // Lee un carácter
        currentLine += c;       // Añade el carácter a la línea actual
        if (c == '\n') {        // Si el carácter es un salto de línea
          if (currentLine.length() == 0) { // Si la línea está vacía, indica el final de la solicitud
            // Enviar la respuesta HTTP
            client.println("HTTP/1.1 200 OK");                    // Línea de estado HTTP
            client.println("Content-Type: text/html");            // Tipo de contenido
            client.println("Connection: close");                  // Indica que la conexión se cierra después de la respuesta
            client.println();                                     // Línea en blanco para finalizar las cabeceras

            // HTML para mostrar los datos
            client.println("<html>");
            client.println("<head><title>Datos de Sensor</title></head>");
            client.println("<body>");
            client.println("<h1>Datos de Sensores y Control</h1>");

            // Mostrar la temperatura
            client.print("<p><b>Temperatura: </b>");
            client.print(temp);                                      // Muestra la temperatura leída
            client.println(" &deg;C</p>");

            // Mostrar la humedad
            client.print("<p><b>Humedad: </b>");
            client.print(hum);                                       // Muestra la humedad leída
            client.println(" %</p>");

            // Mostrar el valor del potenciómetro
            client.print("<p><b>Potenciómetro: </b>");
            client.print(estadoPote);                               // Muestra el valor del potenciómetro
            client.println("</p>");

            // Mostrar el contador de pulsaciones
            client.print("<p><b>Presiones del Pulsador: </b>");
            client.print(contadorPulsador);                         // Muestra el número de pulsaciones
            client.println("</p>");

            // Añadir datos de un canal público de ThingSpeak
            String publicData = ThingSpeak.readStringField(123457, 1, ReadAPIKey);  // Lee datos de un canal público (cambiar Channel ID y campo según sea necesario)
            client.print("<p><b>Datos de Canal Público: </b>");
            client.print(publicData);                                // Muestra los datos del canal público
            client.println("</p>");

            client.println("</body>");
            client.println("</html>");

            break; // Sale del bucle una vez enviada la respuesta
          } else {
            currentLine = ""; // Resetea la línea actual si no es el final de la solicitud
          }
        }
      }
    }
    client.stop(); // Cierra la conexión con el cliente
  }
}
