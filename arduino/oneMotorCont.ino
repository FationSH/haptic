//--------------------------------------------------------------------------
// Shehaj Fation, University of Ioannina
// Code to test haptik functionality (for z axes)
//--------------------------------------------------------------------------
// We have only one motor with encoder and no FSR to measure the force ==>
// q1 and q2 for x adn y axes are locked at q1=45 and q2=90+45=135 degrees
// q3 is free, forece is locked at 0.2 Newtons for z axe (we need FSR for
// force input), 0 Newton for x-y axes
// 
//**************************************************************************

// Run in terminal ---------------------------------------------------------
//   roscore
// In new terminal
//   rosrun rosserial_python serial_node.py /dev/ttyACM0
// In new terminal
//   rostopic pub /on_off std_msgs/UInt16 1
//**************************************************************************

// Includes  ---------------------------------------------------------------
#if (ARDUINO >= 100)
  #include <Arduino.h>
#else
  #include <WProgram.h>
#endif

#include <math.h>
#include <ros.h>
#include <std_msgs/UInt16.h> // or use <std_msgs/Bool.h>
#include <std_msgs/String.h>


ros::NodeHandle nh;

// Pin declares  -----------------------------------------------------------
const int pwmPin = 3;    // speed control - pulse width modulation (PWM)
const int dirPin = 12;
//int sensorPosPin = A2;
//int fsrPin = A3;

// Position Variables  -----------------------------------------------------
angleq3 = 0; // Starting angle

// Kinematics variables


// Force output Variables  -------------------------------------------------
double F = [0; 0; 0]		// Force in 3 directions
double f = 0;           	// paragontas gwnias
double Tp = [0; 0; 0];      // torque of the motor in 3D
double duty = 0;            // duty cylce (between 0 and 255)
unsigned int output = 0;    // output command to the motor

//--------------------------------------------------------------------------
// Input message  **********************************************************
//--------------------------------------------------------------------------
void message(const std_msgs::UInt16 &msg){
  if(msg.data == 1){        // on
    // Initialize motor 
    analogWrite(pwmPin, 0);     // set to not be spinning (0/255)
    digitalWrite(dirPin, LOW);  // set direction
    
    // Initialize position valiables
    //lastLastRawPos = analogRead(sensorPosPin);
    //lastRawPos = analogRead(sensorPosPin);
  } // else off
}

ros::Subscriber<std_msgs::UInt16> motor_sub("on_off", &message);

//--------------------------------------------------------------------------
// Setup  ******************************************************************
//--------------------------------------------------------------------------
void setup() {
  // Set up serial communication
  Serial.begin(57600);
  
  // Set PWM frequency
  setPwmFrequency(pwmPin,1);
  
  // Input Pins
  //pinMode(sensorPosPin, INPUT);
  //pinMode(fsrPin, INPUT);
  
  // Output Pins
  pinMode(pwmPin, OUTPUT);
  pinMode(dirPin, OUTPUT);
  
  nh.initNode();
  nh.subscribe(motor_sub);
}

//--------------------------------------------------------------------------
// Main Loop  **************************************************************
//--------------------------------------------------------------------------
void loop(){
  
  // 1. Take angles from sensor --------------------------------------------
  // no sensor --> take angles from IF COND
  if(angleq3 > 90){
	angleq3 == 0;
  } else {
	angleq3++;
  }
  
  
  // 2. Compute measured handle force in Newtons ---------------------------
  // force should be in 3 directions => [x; y; z], =>  F = [0; 0; 0.2]
  // here only in z axe
  F = [0; 0; 0.2]; 		// Newtons
  
  
  // 3. Compute the require motor pulley torque (Tp) in Newtons ------------
  // Tp = J*F; -- Tp = 3x1  -  Torque in every direction
  // 	Render a VIRTUAL WALL in z direction	 //
  double q3_wall = 50;		// after 50 degrees feel the force
  if(angleq3 > q3_wall){ 	// bigger diference in angles => bigger torque
	f = -0.006*(angleq3 - q3_wall);
  } else {
    f = 0;
  }
  Tp = f * J*F;    	// Compute the require motor pulley torque (Tp)
  
  
  // 5. Force output -------------------------------------------------------
  // Determine correct direction for motor torque
  if(force < 0) { 
    digitalWrite(dirPin, HIGH);
  } else {
    digitalWrite(dirPin, LOW);
  }

  // Compute the duty cycle required to generate Tp (torque at the motor pulley)
  duty = sqrt(abs(Tp)/0.03);

  // Make sure the duty cycle is between 0 and 100%
  if (duty > 1) {            
    duty = 1;
  } else if (duty < 0) { 
    duty = 0;
  }  
  output = (int)(duty* 255);   // convert duty cycle to output signal
  analogWrite(pwmPin,output);  // output the signal
  
  
  nh.spinOnce();
  delay(500);		// wait 0.5 sec to increas angle again
}


// -------------------------------------------------------------------------
// Function to set PWM Freq -- From internet  ******************************
// -------------------------------------------------------------------------
void setPwmFrequency(int pin, int divisor) {
  byte mode;
  if(pin == 5 || pin == 6 || pin == 9 || pin == 10) {
    switch(divisor) {
      case 1: mode = 0x01; break;
      case 8: mode = 0x02; break;
      case 64: mode = 0x03; break;
      case 256: mode = 0x04; break;
      case 1024: mode = 0x05; break;
      default: return;
    }
    if(pin == 5 || pin == 6) {
      TCCR0B = TCCR0B & 0b11111000 | mode;
    } else {
      TCCR1B = TCCR1B & 0b11111000 | mode;
    }
  } else if(pin == 3 || pin == 11) {
    switch(divisor) {
      case 1: mode = 0x01; break;
      case 8: mode = 0x02; break;
      case 32: mode = 0x03; break;
      case 64: mode = 0x04; break;
      case 128: mode = 0x05; break;
      case 256: mode = 0x06; break;
      case 1024: mode = 0x7; break;
      default: return;
    }
    TCCR2B = TCCR2B & 0b11111000 | mode;
  }
}
