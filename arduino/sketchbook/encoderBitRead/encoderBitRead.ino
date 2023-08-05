// Includes
#if (ARDUINO >= 100)
  #include <Arduino.h>
#else
  #include <WProgram.h>
#endif


int encoder0PinA = 2;
int encoder0PinB = 3;
int lwheel = 0;
int encoder0PinALast = LOW;
int encoder0PinBLast = LOW;
int a = LOW;
int b = LOW;

void setup()
{
  /* Setup encoder pins as inputs */
  pinMode(encoder0PinA, INPUT);
  pinMode(encoder0PinB, INPUT);
  
  digitalWrite(encoder0PinA, HIGH); //turn pullup resistor on
  digitalWrite(encoder0PinB, HIGH); //turn pullup resistor on
  
  attachInterrupt(0, updateEncoder, CHANGE);
  attachInterrupt(1, updateEncoder, CHANGE);
  
  Serial.begin (115200);
  Serial.println("Start");
}
 
void loop() {
  
}

void updateEncoder(){
  a = digitalRead(encoder0PinA);
  b = digitalRead(encoder0PinB);

  //Serial.print (encoder0PinALast);
  //Serial.print (encoder0PinBLast);
  Serial.print (a);
  Serial.println (b);

  encoder0PinALast = a;
  encoder0PinBLast = b;
}
