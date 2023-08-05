#define ENC_A 2
#define ENC_B 3
#define ENC_PORT PINC

void setup()
{
 /* Setup encoder pins as inputs */
 pinMode(ENC_A, INPUT);
 digitalWrite(ENC_A, HIGH);
 pinMode(ENC_B, INPUT);
 digitalWrite(ENC_B, HIGH);
 Serial.begin (115200);
 Serial.println("Start");
}

void loop()
{
static int counter = 0;      //this variable will be changed by encoder input      
int8_t tmpdata;
/**/
 tmpdata = read_encoder();
 if( tmpdata ) {
   Serial.print("Counter value: ");
   Serial.println(counter, DEC);
   counter += tmpdata;
 }
}

/* returns change in encoder state (-1,0,1) */
int8_t read_encoder()
{
 int8_t enc_states[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
 static uint8_t old_AB = 0;
 /**/
 old_AB <<= 2;                   //remember previous state
 old_AB |= ((digitalRead (ENC_B) << 1) | digitalRead (ENC_A));  //add current state
 return ( enc_states[( old_AB & 0x0f )]);  
}
