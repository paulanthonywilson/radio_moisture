#include <VirtualWire.h>

byte message[VW_MAX_MESSAGE_LEN]; // a buffer to store the incoming messages
char messageChr[VW_MAX_MESSAGE_LEN + 1];


void setup() {
  Serial.begin(115200);
 
  vw_setup(2000);
  vw_rx_start();
  Serial.println("Ready");

}

void loop() {
  readRf();
}

void readRf(){ 
  byte messageLength = VW_MAX_MESSAGE_LEN; // the size of the message
  if (vw_get_message(message, &messageLength)) {
    for (int i = 0; i < messageLength; i++) {
      messageChr[i] = message[i];
    }
    messageChr[messageLength] = 0;
    Serial.print(millis());
    Serial.print("\t");
    Serial.println(messageChr);
  } 
}

