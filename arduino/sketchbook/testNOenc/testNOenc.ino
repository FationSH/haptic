// Includes
#if (ARDUINO >= 100)
  #include <Arduino.h>
#else
  #include <WProgram.h>
#endif

// motor variables
const int PWM_B = 11;
const int DIR_B = 13;
const int BRAKE_B = 8;
const int SNS_B = A1;  // measure the current (voltage)

// encoder variables
int A[]={1, 1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1};
//      {1  2  3  4   3   2   1   0  -1  -2  -3  -4}
int i=0;
int tmpdata;
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
  digitalWrite(BRAKE_B, LOW);   // setting the brake LOW to disable motor brake
  
  // Open Serial communication
  Serial.begin (115200);
  Serial.println("Start");
}

void loop(){
  while (i < 12){
    tmpdata = A[i];
    counter += tmpdata;
    // Askei dunamh meta tis 33 moires
    if (counter >= 2 || counter <= -2) {
      // Afkshsh/meiwsh dunamhs me omalo ru8mo
      for (int j = 1; j < 10; j++) {
        
        // 2. Assign a motor output force  ---------------------------------------------------------------
        force += j*tmpdata;
        
        output = abs(force);
        Serial.println(force);
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
        delay(200); // slow down the program
      }
    }
    i++;
  }
  digitalWrite(BRAKE_B, HIGH);  // raise the brake 
}

