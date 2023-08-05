#include <DCMotorBot.h>

DCMotorBot bot;

void setup() {

    // initialize bot pins
    bot.setEnablePins(3, 5);
    bot.setControlPins(2, 4, 7, 8);
}

void loop() {
    bot.moveForward();
    delay(2000);
    bot.moveBackward();
    delay(2000);
    bot.turnLeft();
    delay(2000);
    bot.turnRight();
    delay(2000);
}
