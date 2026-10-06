#include <Servo.h>

Servo myservo;
int servoPin = 3;
int leftAngle = 60;
int rightAngle = 150;
int servoPos = 60;
int servoDirection = 1;
unsigned long lastServoMove = 0;
int servoDelay = 8;
bool songPlaying = false;
int slowBPM = 94;
int regularBPM = 111;
int fastBPM = 125;
int slowButton = 13;
int normalButton = 12;
int fastButton = 11;
int vibrator1 = 10;
int led1 = 9;
int vibrator2 = 6;
int led2 = 5;

String incoming = "";

void setup() {

  Serial.begin(9600);

  myservo.attach(servoPin);

  // resting position
  myservo.write(90);
  pinMode(slowButton, INPUT_PULLUP);
  pinMode(normalButton, INPUT_PULLUP);
  pinMode(fastButton, INPUT_PULLUP);
  pinMode(vibrator1, OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(vibrator2, OUTPUT);
  pinMode(led2, OUTPUT);
  setBPM(regularBPM);
  allOff();
}

void loop() {

  if (songPlaying) {
    updateServo();
  }

  if (digitalRead(slowButton) == LOW) {
    Serial.println("SLOW");
    setBPM(slowBPM);
    delay(300);
  }

  if (digitalRead(normalButton) == LOW) {
    Serial.println("NORMAL");
    setBPM(regularBPM);
    delay(300);
  }

  if (digitalRead(fastButton) == LOW) {
    Serial.println("FAST");
    setBPM(fastBPM);
    delay(300);
  }


  if (Serial.available()) {
    incoming = Serial.readStringUntil('\n');
    incoming.trim();

    if (incoming == "START") {
      myservo.attach(servoPin);
      songPlaying = true;
    }

    else if (incoming == "P1") {
      songPlaying = true;
      analogWrite(vibrator1, 255);
      analogWrite(led1, 255);
      analogWrite(vibrator2, 0);
      analogWrite(led2, 0);
    }

    else if (incoming == "P2") {
      songPlaying = true;
      analogWrite(vibrator1, 0);
      analogWrite(led1, 0);
      analogWrite(vibrator2, 255);
      analogWrite(led2, 255);
    }

    else if (incoming == "BOTH") {
      songPlaying = true;
      analogWrite(vibrator1, 255);
      analogWrite(led1, 255);
      analogWrite(vibrator2, 255);
      analogWrite(led2, 255);
    }

    else if (incoming == "SILENT") {
      allOff();
    }

    else if (incoming == "OFF") {
      songPlaying = false;
      myservo.write(90);
      allOff();
      delay(300);
      myservo.detach();
    }
  }
}


void setBPM(int bpm) {
  servoDelay = map(bpm, 90, 130, 10, 4);
  servoDelay = constrain(servoDelay, 3, 9);
}

void updateServo() {
  if (millis() - lastServoMove >= servoDelay) {
    lastServoMove = millis();
    servoPos += servoDirection;

    if (servoPos >= rightAngle) {
      servoPos = rightAngle;
      servoDirection = -1;
    }

    if (servoPos <= leftAngle) {
      servoPos = leftAngle;
      servoDirection = 1;
    }
    myservo.write(servoPos);
  }
}

void allOff() {

  analogWrite(vibrator1, 0);
  analogWrite(led1, 0);

  analogWrite(vibrator2, 0);
  analogWrite(led2, 0);
}
