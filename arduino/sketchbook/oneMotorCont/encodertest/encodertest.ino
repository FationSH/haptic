// Includes
#if (ARDUINO >= 100)
  #include <Arduino.h>
#else
  #include <WProgram.h>
#endif


int val;
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
  encoder0PinALast = encoder0PinA;
  encoder0PinBLast = encoder0PinB;
  Serial.begin (9600);
  Serial.println("Start");
}
 
void loop() {
   a = digitalRead(encoder0PinA);
   b = digitalRead(encoder0PinB);
   //if ((encoder0PinALast == LOW) && (a == LOW) || (encoder0PinALast == HIGH) && (a == HIGH)) {
   //  if ((encoder0PinBLast == LOW) && (b == LOW) || (encoder0PinBLast == HIGH) && (b == HIGH)) {
       // no movement
   //  }
   if ((encoder0PinBLast == LOW) && (b == LOW)) {
     if ((encoder0PinALast == LOW) && (a == HIGH)) {
       lwheel--;
     }
     if ((encoder0PinALast == HIGH) && (a == LOW)) {
       lwheel++;
     }
   }
   if ((encoder0PinALast == LOW) && (a == LOW)) {
     if ((encoder0PinBLast == LOW) && (b == HIGH)) {
       lwheel++;
     }
     if ((encoder0PinBLast == HIGH) && (b == LOW)) {
       lwheel--;
     }
   }
   if ((encoder0PinALast == HIGH) && (a == HIGH)) {
     if ((encoder0PinBLast == LOW) && (b == HIGH)) {
       lwheel--;
     }
     if ((encoder0PinBLast == HIGH) && (b == LOW)) {
       lwheel++;
     }
   }
   if ((encoder0PinBLast == HIGH) && (b == HIGH)) {
     if ((encoder0PinALast == LOW) && (a == HIGH)) {
       lwheel++;
     }
     if ((encoder0PinALast == HIGH) && (a == LOW)) {
       lwheel--;
     }
   }
   // --------------------------------------------------------------------------------
   if ((encoder0PinALast == LOW) && (a == HIGH)) {
     lwheel = lwheel-2;
   }
   if ((encoder0PinALast == HIGH) && (a == LOW)) {
     lwheel = lwheel+2;
   }
   
   Serial.println (lwheel);
   encoder0PinALast = a;
   encoder0PinBLast = b;
}
