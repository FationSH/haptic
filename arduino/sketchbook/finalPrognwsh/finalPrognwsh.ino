// Includes
#if (ARDUINO >= 100)
  #include <Arduino.h>
#else
  #include <WProgram.h>
#endif

// motor variables
const int PWM_B =11;
const int DIR_B = 13;
// optional
const int BRAKE_B = 8;
const int SNS_B = A1;  // measure the current (voltage)

// encoder variables
const int encoder0PinA = 2;
const int encoder0PinB = 3;
int8_t tmpdata;
int last = 0;
int counter = 0;   //this variable will be changed by encoder input
int encoder0PinALast = LOW;
int encoder0PinBLast = LOW;
int a = LOW;
int b = LOW;

// result variables
int force = 0;
int output = 0;
int deg = 0;

// Problepsh
int pred[5] = {0,0,0,0,0};
int met = 0;
int j = 0;
int sum = 0;
int olddata = 0;

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
  // 11 points => 360/11 = 32.72 deg per point
  
  if (last>0){  // mpainei mono an exei upar3ei allagh apo ton encoder
    // problepsh
    // 8eorw aristerostrofa 0 kai de3iostrofa 1
    // start prediction
    j = met%4;
    if (tmpdata == 1){
      pred[j] = 1;
    } else {
      pred[j] = 0;
    }
    if (met > 3){
      sum = pred[0]+pred[1]+pred[2]+pred[3]+pred[4];
      if (sum >=2 ){  // kinhsh pros de3ia
        tmpdata = 1;
      } else {
        tmpdata = -1;
      }
    }

    // Askei dunamh meta tis 33 moires
    if (counter >= 3 || counter <= -3) {
      // Afkshsh/meiwsh dunamhs me omalo ru8mo
      for (int i = 1; i < 10; i++) {
        
        // 2. Assign a motor output force  ---------------------------------------------------------------
        force += 2*tmpdata;
        
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
    Serial.println(counter);
    last--;
  }
}

void updateEncoder(){
  tmpdata = read_encoder();
  met++;
  counter += tmpdata;
  last++; // au3anei ton metrhth gia thn for
}

/* returns change in encoder state (-1,0,1) */
int8_t read_encoder(){
  int8_t enc_states[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
  static uint8_t old_AB = 0;
  a = digitalRead(encoder0PinA);
  b = digitalRead(encoder0PinB);
  /**/
  old_AB <<= 2;                   //remember previous state
  old_AB |= ((b << 1) | a);  //add current state
  encoder0PinALast = a;
  encoder0PinBLast = b;
  return ( enc_states[( old_AB & 0x0f )]);
}
