#define encoder0PinA  2
#define encoder0PinB  3

volatile unsigned int encoder0Pos = 0;

void setup() {


 pinMode(encoder0PinA, INPUT);
 digitalWrite(encoder0PinA, HIGH);       // turn on pullup resistor
 pinMode(encoder0PinB, INPUT);
 digitalWrite(encoder0PinB, HIGH);       // turn on pullup resistor

 attachInterrupt(0, doEncoder, CHANGE);  // encoder pin on interrupt 0 - pin 2
 Serial.begin (9600);
 Serial.println("start");                // a personal quirk

}

void loop(){
// do some stuff here - the joy of interrupts is that they take care of themselves
}

void doEncoder() {
 /* If pinA and pinB are both high or both low, it is spinning
  * forward. If they're different, it's going backward.
  *
  * For more information on speeding up this process, see
  * [Reference/PortManipulation], specifically the PIND register.
  */
 if (digitalRead(encoder0PinA) == digitalRead(encoder0PinB)) {
   encoder0Pos++;
 } else {
   encoder0Pos--;
 }

 Serial.println (encoder0Pos, DEC);
}

/* See this expanded function to get a better understanding of the
* meanings of the four possible (pinA, pinB) value pairs:
*/
void doEncoder_Expanded(){
 if (digitalRead(encoder0PinA) == HIGH) {   // found a low-to-high on channel A
   if (digitalRead(encoder0PinB) == LOW) {  // check channel B to see which way
                                            // encoder is turning
     encoder0Pos = encoder0Pos - 1;         // CCW
   }
   else {
     encoder0Pos = encoder0Pos + 1;         // CW
   }
 }
 else                                        // found a high-to-low on channel A
 {
   if (digitalRead(encoder0PinB) == LOW) {   // check channel B to see which way
                                             // encoder is turning  
     encoder0Pos = encoder0Pos + 1;          // CW
   }
   else {
     encoder0Pos = encoder0Pos - 1;          // CCW
   }

 }
 Serial.println (encoder0Pos);          // debug - remember to comment out
 Serial.println ('/ ');                 // before final program run
 // you don't want serial slowing down your program if not needed
}
