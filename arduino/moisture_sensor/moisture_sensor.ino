#include <VirtualWire.h>


/*
 * Sleep mode with watchdog timer, courtesy of 
 * Donal Morrissey. 
 * 
 * http://donalmorrissey.blogspot.co.uk/2010/04/sleeping-arduino-part-5-wake-up-via.html
 * 
 *
 */
#include <avr/sleep.h>
#include <avr/power.h>
#include <avr/wdt.h>

const int sleepSeconds = 9;
const int readIntervalSeconds = 9;
const int readIntervalSleepCycles = readIntervalSeconds / sleepSeconds;

const int ledPin = 13;
const int moisturePin = 0;



void enterSleep(void)
{
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  sleep_enable();
  
  sleep_mode();
  
  // Woken up
  sleep_disable();
  
  power_all_enable();
}


ISR(WDT_vect){}

void setupWatchdogTimer(){
  /* Clear the reset flag. */
  MCUSR &= ~(1<<WDRF);
  
  /* In order to change WDE or the prescaler, we need to
   * set WDCE (This will allow updates for 4 clock cycles).
   */
  WDTCSR |= (1<<WDCE) | (1<<WDE);

  /* set new watchdog timeout prescaler value */
  WDTCSR = 1<<WDP0 | 1<<WDP3; /* 8.0 seconds */
  
  /* Enable the WD interrupt (note no reset). */
  WDTCSR |= _BV(WDIE);
}

void setup()
{
  Serial.begin(115200);
  pinMode(ledPin,OUTPUT);
  setupWatchdogTimer();
  vw_setup(2000);
} 
 

int sleepsLeftToRead = 0;
void loop()
{
  doReadIfItIsTime();
  enterSleep();
}

void doReadIfItIsTime(){
  if (--sleepsLeftToRead < 1) {
    doReading();
    sleepsLeftToRead = readIntervalSleepCycles;
  }  
}

void doReading() {
  digitalWrite(ledPin, HIGH);
  for(int i = 0; i < 5; i++) {
    transmitReading(analogRead(moisturePin));
  }
  transmitReadingFinished();
  delay(10);
  digitalWrite(ledPin, LOW);
}

void transmitReading(int reading){
  char message[50];
  sprintf(message, "Moisture reading: %d", reading);
  transmit(message);
}

void transmitReadingFinished(){
  transmit("*******");
}

void transmit(char* message) {
  Serial.println(message);
  vw_send((uint8_t *)message, strlen(message));
  vw_wait_tx(); 
}




