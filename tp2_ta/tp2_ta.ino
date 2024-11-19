#include <WiFi.h>
#include <ThingSpeak.h>
#include <DHT.h>
#include <DHT_U.h>
#include <splash.h>
#include <Arduino.h>

// Pines
const int pinPote = 32;
const int DHT_PIN = 33;
const int pinPulsador = 19;

// Definir el sensor DHT22
DHT dht(DHT_PIN, DHT22);

// Configuración de la red Wi-Fi
const char *SSID = "Fibertel WiFi122 2.4GHz";
const char *PASS = "menXuz-terre1-dantib"; 

//Definición de parámetros para ThingSpeak
unsigned long nroCanalPrivado = numero;
const char * WriteAPIKey = "";
const char * ReadAPIKey = "";
unsigned int nroCampoTemperatura= 1;
unsigned int nroCampoHumedad= 2;
unsigned int nroCampoPotenciometro= 3;

WiFiClient client;

// VARIABLES
float temp; // Variable usada para temperatura sensada por DHT
float hum; // Variable usada para humedad sensada por DHT
int estadoPote; // Variable que contendrá valor actual de potenciómetro
int estadoBoton = HIGH; // Estado del pulsador
int ultimoEstado = HIGH; // Estado anterior del pulsador   
unsigned long ultimoRebote = 0; // Último tiempo de rebote del pulsador
int delayRebote = 50; // Tiempo de rebote del pulsador
int contadorPulsador = 0; // Cantidad de pulsaciones de pulsador
unsigned long currentTime = 0;
unsigned long previousTime = 0;
WiFiClient client;
const long timeoutTime = 2000;
WiFiServer server(80);
String header;



void setup() {
  Serial.begin(115200);

  // Inicializar DHT
  dht.begin();

  // Configurar el pin del pulsador
  pinMode(pinPulsador, INPUT_PULLUP);

  // Conectar al Wi-Fi
  WiFi.begin(SSID, PASS);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
Serial.println("Conectado a Wi-Fi!");
Serial.print("IP: ");
Serial.println(WiFi.localIP());

  ThingSpeak.begin(client);  // Inicia ThingSpeak

  // Inicializar el contador de pulsador
  lastUploadTime = millis();
}

void loop() {
    currentTime = millis();
// Connect or reconnect to Wi-Fi
  if(WiFi.status() != WL_CONNECTED){
    Serial.print("Attempting to connect to SSID: ");
    Serial.println(String(SSID));
    while(WiFi.status() != WL_CONNECTED){
      WiFi.begin(SSID, PASS);
      Serial.print(".");
      delay(500);
    }
    Serial.println("\nConnected.");
  }
  // MANEJO DE PULSADOR Y CONTAR PULSADOR
  int lectura = digitalRead(pinPulsador);

  // Si el estado del pulsador ha cambiado, registrar el tiempo de rebote
  if (lectura != ultimoEstado) {
    ultimoRebote = millis();
  }

  // Si ha pasado suficiente tiempo desde el último rebote, actualizar el estado del pulsador
  if ((millis() - ultimoRebote) > delayRebote) {
    // Si el estado del pulsador ha cambiado, actualizar el estado del LED
    if (lectura != estadoBoton) {
      estadoBoton = lectura;

      // Si el pulsador ha sido presionado, cambiar el estado del LED y contar accion en pulsador
      if (estadoBoton == HIGH) {
        contadorPulsador = contadorPulsador + 1;
        Serial.println("Se ha presionado el pulsador");
      }
    }
  }
  // Guardar el último estado del pulsador
  ultimoEstado = lectura;

  // MANEJO DE POTENCIOMETRO
  estadoPote = map(analogRead(pinPote), 0, 4095, 4095, 0);
  ThingSpeak.setField (nroCampoPotenciometro,estadoPote);

  // MANEJO DE SENSOR TEMPERATURA Y HUMEDAD
  temp = dht.readTemperature();
  hum = dht.readHumidity();
  ThingSpeak.setField (nroCampoHumedad,hum);
  ThingSpeak.setField (nroCampoTemperatura,temp);
  ThingSpeak.setStatus ("Cantidad de pulsaciones: " + String(contadorPulsador));
  if ((currentTime - previousTime) >= 20000) {
    previousTime = currentTime;
    ThingSpeak.writeFields(nroCanalPrivado,WriteAPIKey);
    Serial.println("Se realizó escritura en ThingSpeak");
  }

  // Mostrar la página web (Servidor Web)
  WiFiServer server(80);
  WiFiClient client = server.available();
  
  if (client) {
    String currentLine = "";
    
    // Lee la solicitud HTTP
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        currentLine += c;
        if (c == '\n') {
          if (currentLine.length() == 0) {
            // Enviar la respuesta HTTP
            client.println("HTTP/1.1 200 OK");
            client.println("Content-Type: text/html");
            client.println("Connection: close");
            client.println();
            
            // HTML para mostrar los datos
            client.println("<html>");
            client.println("<head><title>Datos de Sensor</title></head>");
            client.println("<body>");
            client.println("<h1>Datos de Sensores y Control</h1>");
            
            client.print("<p><b>Temperatura: </b>");
            client.print(temperature);
            client.println(" &deg;C</p>");
            
            client.print("<p><b>Humedad: </b>");
            client.print(humidity);
            client.println(" %</p>");
            
            client.print("<p><b>Potenciómetro: </b>");
            client.print(potentiometerValue);
            client.println("</p>");
            
            client.print("<p><b>Presiones del Pulsador: </b>");
            client.print(buttonPressCount);
            client.println("</p>");
            
            // Añadir algún canal público de ThingSpeak
            String publicData = ThingSpeak.readString(123457);  // Cambia el Channel ID y el campo que quieras mostrar
            client.print("<p><b>Datos de Canal Público: </b>");
            client.print(publicData);
            client.println("</p>");

            client.println("</body>");
            client.println("</html>");

            break;
          } else {
            currentLine = "";
          }
        }
      }
    }
    client.stop();  // Cerrar la conexión
  }
}
