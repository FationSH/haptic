// Includes
#if (ARDUINO >= 100)
  #include <Arduino.h>
#else
  #include <WProgram.h>
#endif

// motor variables
const int PWM_B =11;
const int DIR_B = 13;
const int BRAKE_B = 8;
const int SNS_B = A1;  // measure the current (voltage)

// encoder variables
const int encoder0PinA = 2;
const int encoder0PinB = 3;
int8_t tmpdata;
int last = 0;
int counter = 0;   //this variable will be changed by encoder input 
// result variables
int force = 0;
int output = 0;

void setup() {
  
  // Setup motor pins
  pinMode(PWM_B, OUTPUT);
  pinMode(SNS_B, INPUT);
  // Configure the A output
  pinMode(BRAKE_B, OUTPUT);  // Brake pin on channel A
  pinMode(DIR_B, OUTPUT);    // Direction pin on channel A

  // Setup encoder pins
  pinMode(encoder0PinA, INPUT);
  pinMode(encoder0PinB, INPUT);
  digitalWrite(encoder0PinA, HIGH); //turn pullup resistor on
  digitalWrite(encoder0PinB, HIGH); //turn pullup resistor on
  
  attachInterrupt(0, updateEncoder, CHANGE);
  attachInterrupt(1, updateEncoder, CHANGE);
  
  // Open Serial communication
  Serial.begin (115200);
  Serial.println("Start");
}

void loop(){
  // 1. Compute position in counts  ------------------------------------------------------------------
  // By interupts
  // Velocity == counter
  // 11 points => 360/11 = 32.72 deg per point
  
  if (last){
    // Askei dunamh meta tis 33 moires
    if (counter >= 2 || counter <= -2) {
      // Afkshsh/meiwsh dunamhs me omalo ru8mo
      for (int i = 1; i < 10; i++) {
        
        // 2. Assign a motor output force  ---------------------------------------------------------------
        force += i*tmpdata;
        
        output = abs(force);
        // Make sure the force is between 0 and 255
        if (output > 255) {
          output = 255;
        } else if (output < 0) { 
          output = 0;
        }  
        
        // 3. Force output  ------------------------------------------------------------------------------
        // Determine correct direction for motor torque
        if(counter < 0) { 
          digitalWrite(DIR_B, HIGH);
        } else {
          digitalWrite(DIR_B, LOW);
        }
        
        if (output == 0){
          digitalWrite(BRAKE_B, HIGH);  // raise the brake
          break;
        } else {
          digitalWrite(BRAKE_B, LOW);   // setting the brake LOW to disable motor brake
          analogWrite(PWM_B,output);    // output the signal
        }
      }
    } else {
      digitalWrite(BRAKE_B, HIGH);  // raise the brake
    }
    last = 0;
  }
}

void updateEncoder(){
  tmpdata = read_encoder();
  counter += tmpdata;
  last = 1;
}

/* returns change in encoder state (-1,0,1) */
int8_t read_encoder(){
  int8_t enc_states[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
  static uint8_t old_AB = 0;
  /**/
  old_AB <<= 2;                   //remember previous state
  old_AB |= ((digitalRead (encoder0PinB) << 1) | digitalRead (encoder0PinA));  //add current state
  return ( enc_states[( old_AB & 0x0f )]);
}
