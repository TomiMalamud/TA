#include <dht.h>

#define PIN_RELE 4;
#define PIN_SENSOR 11;
DHT dht(DHT_PIN, DHT22)

void accionDeControl(unsigned long intervalo) {
    static unsigned long previousMillis = millis();
    if(millis() - previousMillis > intervalo){
        previousMillis = millis();
        float Tref = 25.0;
        float emax = 2.0;
        float T = dht.readTemperature();
        float error = abs(Tref - T);
        // Ley de control
        if(error > emax){
            error > 0 ? accion = 0: accion = 1;
        }        
        digitalWrite(PIN_RELE, accion);
        Serial.printf("%.2f, %.2f, %.2f %d\n")
    }
}

void setup(){
    Serial.begin(115200);
    Serial.
    pinMode(PIN_RELE, OUTPUT);
    dht.init(PIN_SENSOR);
}

void loop(){
    float Tref = 25.0;
    float T = dht.readTemperature();
    float error = Tref - T;
    // Ley de control
    error > 0 ? digitalWrite(PIN_RELE, false) : digitalWrite(PIN_RELE, true);
}