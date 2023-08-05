// Includes
#if (ARDUINO >= 100)
  #include <Arduino.h>
#else
  #include <WProgram.h>
#endif

#include <math.h>
//#include <ros.h>
//#include <std_msgs/UInt16.h>
#include <AFMotor.h>


AF_DCMotor motor(2, MOTOR12_64KHZ);
  
void setup() {
  Serial.begin(9600);           // set up Serial library at 9600 bps
  Serial.println("Motor test!");

  // turn on motor
  motor.setSpeed(100);
 
  motor.run(RELEASE);
}

void loop() {
  uint8_t i;
  
  Serial.print("tick");
  
  motor.run(FORWARD);
  for (i=0; i<127; i++) {
    motor.setSpeed(i);  
    delay(10);
  }
  
  motor.run(RELEASE);
}
