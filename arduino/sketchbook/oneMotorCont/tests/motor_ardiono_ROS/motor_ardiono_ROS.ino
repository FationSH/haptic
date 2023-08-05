#include <ros.h>
#include <std_msgs/Int8.h>

const int feedbackThreshold= 1;

const int fl_mot_out_pin=13;
const int fr_mot_out_pin=14;
const int bl_mot_out_pin=15;
const int br_mot_out_pin=16;
const int st_mot_out_pin=17;

ros::NodeHandle nh;

std_msgs::Int8 fl_motor_fb;
std_msgs::Int8 fr_motor_fb;
std_msgs::Int8 bl_motor_fb;
std_msgs::Int8 br_motor_fb;
std_msgs::Int8 st_motor_fb;

void fl_mot_Cb(const std_msgs::Int8& power){
  digitalWrite(fl_mot_out_pin, power.data);
}
void fr_mot_Cb(const std_msgs::Int8& power){
  digitalWrite(fr_mot_out_pin, power.data);
}
void bl_mot_Cb(const std_msgs::Int8& power){
  digitalWrite(bl_mot_out_pin, power.data);
}
void br_mot_Cb(const std_msgs::Int8& power){
  digitalWrite(br_mot_out_pin, power.data);
}
void st_mot_Cb(const std_msgs::Int8& power){
  digitalWrite(st_mot_out_pin, power.data);
}

ros::Subscriber<std_msgs::Int8> fl_mot_sub("front_left_motor_power", &fl_mot_Cb);
ros::Subscriber<std_msgs::Int8> fr_mot_sub("front_right_motor_power", &fr_mot_Cb);
ros::Subscriber<std_msgs::Int8> bl_mot_sub("back_left_motor_power", &bl_mot_Cb);
ros::Subscriber<std_msgs::Int8> br_mot_sub("back_right_motor_power", &br_mot_Cb);
ros::Subscriber<std_msgs::Int8> st_mot_sub("strafe_motor_power", &st_mot_Cb);

ros::Publisher fl_mot_fb_pub("front_left_motor_feedback", &fl_motor_fb);
ros::Publisher fr_mot_fb_pub("front_right_motor_feedback", &fr_motor_fb);
ros::Publisher bl_mot_fb_pub("back_left_motor_feedback", &bl_motor_fb);
ros::Publisher br_mot_fb_pub("back_right_motor_feedback", &br_motor_fb);
ros::Publisher st_mot_fb_pub("strafe_motor_feedback", &st_motor_fb);

void setup(){
  pinMode(fl_mot_out_pin, OUTPUT);
  
  nh.initNode();
  
  nh.advertise(fl_mot_fb_pub);
  nh.advertise(fr_mot_fb_pub);
  nh.advertise(bl_mot_fb_pub);
  nh.advertise(br_mot_fb_pub);
  nh.advertise(st_mot_fb_pub);
  
  nh.subscribe(fl_mot_sub);
  nh.subscribe(fr_mot_sub);
  nh.subscribe(bl_mot_sub);
  nh.subscribe(br_mot_sub);
  nh.subscribe(st_mot_sub);
  
  fl_motor_fb.data=0;
  fr_motor_fb.data=0;
  bl_motor_fb.data=0;
  br_motor_fb.data=0;
  st_motor_fb.data=0;
}

void loop(){
  byte oldData_fl=fl_motor_fb.data;
  byte oldData_fr=fr_motor_fb.data;
  byte oldData_bl=bl_motor_fb.data;
  byte oldData_br=br_motor_fb.data;
  byte oldData_st=st_motor_fb.data;

  fl_motor_fb.data=0;
  fr_motor_fb.data=0;
  bl_motor_fb.data=0;
  br_motor_fb.data=0;
  st_motor_fb.data=0;
  
  if(abs(fl_motor_fb.data - oldData_fl) > feedbackThreshold)
    fl_mot_fb_pub.publish(&fl_motor_fb);
  if(abs(fr_motor_fb.data - oldData_fr) > feedbackThreshold)
    fr_mot_fb_pub.publish(&fr_motor_fb);
  if(abs(bl_motor_fb.data - oldData_bl) > feedbackThreshold)
    bl_mot_fb_pub.publish(&bl_motor_fb);
  if(abs(br_motor_fb.data - oldData_br) > feedbackThreshold)
    br_mot_fb_pub.publish(&br_motor_fb);
  if(abs(st_motor_fb.data - oldData_st) > feedbackThreshold)
    st_mot_fb_pub.publish(&st_motor_fb);
  
  nh.spinOnce();
  delay(1);
}
