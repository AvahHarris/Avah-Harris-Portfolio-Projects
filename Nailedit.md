Nailed It : An Interactive Nail Painting Experience

<img width="400" height="500" alt="nailed it design " src="https://github.com/user-attachments/assets/5127fe82-28a7-4259-8327-c67c8bce2cc0" />

## Demo Link
https://youtu.be/WnYVodZXyZk?si=l0xPGLIDC4S3w0eW

As someone who loves to have their nails done, but never likes going through the hassle of
actually painting their nails, I wanted to try and actuate the nail painting experience. I aimed to
create a self painting nail robot that could paint one finger at a time so the user could complete
another task simultaneously, without spending too much time on painting their nails (especially
for those who do not enjoy the process of painting their nails.

The system mainly consists of a servo motor mounted on a base and an ultrasonic sensor
mounted to the base. I created a custom horn attachment that could hold a nail polish brush. To
ake it more universal I decided to not focus on a whole for the cap size but instead the actual
brush as that is more standardized across different brands than the cap shapes. The servo is
activated by the ultrasonic sensor. When the user is within 20cm of the ultrasonic sensor the
brush will begin to rotate from its resting position of 90 degrees to 135 degrees creating a
sweeping motion that resembles the process of painting one's nail.
I received a lot of great feedback while demoing today that would be great extensions to the
project. Professor Ken mentioned the idea of creating a horn attachment with 5 brushes that all
go at the same time for each nail. Other classmates asked about setting the distance to the
perfect finger height, focusing on vertical distance rather than distance away from the brush. I
think it would be fun to include another analog device such as a potentiometer where the user
could switch between two settings 1 being painting and the second being drying with a fan - I
think this would be really cool!

## Circuit Design
[Nailed.It_.Nail.Painting.Experience.pdf](https://github.com/user-attachments/files/33113293/Nailed.It_.Nail.Painting.Experience.pdf)

## 3D Printing Files
<img width="300" height="300" alt="3D printed component" src="https://github.com/user-attachments/assets/9b6c261c-b12e-4f4b-9a42-1b863d449ba4" />

<img width="300" height="300" alt="3D printed component" src="https://github.com/user-attachments/assets/a8b6813b-152f-4f07-910d-42f88ccf6610" />

<img width="300" height="300" alt="Untitled 28" src="https://github.com/user-attachments/assets/dccf9b6a-934d-4d8e-a81f-5a553c63da40" />

## Arduino Code

#include <Servo.h>

const int trigPin = 3;
const int echoPin = 2;
const int servoPin = 9;

Servo myservo;

void setup() {
  Serial.begin(9600);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  myservo.attach(servoPin);
  myservo.write(90);   // start position
}

void loop() {
  unsigned long duration;
  float cm;

  // Trigger ultrasonic sensor
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read echo pulse
  duration = pulseIn(echoPin, HIGH, 30000);

  if (duration == 0) {
    Serial.println("No reading");
  } else {
    cm = duration * 0.0343 / 2.0;

   Serial.print("Distance: ");
   Serial.print(cm);
   Serial.println(" cm");

  // If object is close enough, move servo
    if (cm <= 20) {
      myservo.write(135);   // move servo
      delay(1000);
      myservo.write(90);    // move back
      delay(500);
      myservo.write(135);   // move servo
      delay(1000);
      myservo.write(90);    // move back
      delay(500);
      myservo.write(135);   // move servo
      delay(1000);
      myservo.write(90);    // move back
      delay(500);
    }
  }

  delay(500);
}


