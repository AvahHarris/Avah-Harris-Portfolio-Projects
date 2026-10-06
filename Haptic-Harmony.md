## Haptic Harmony

One of my favorite activities/hobbies is karaoke. When thinking of concepts for this project I thought it would be cool to figure out a way to make karaoke more interactive. I think one of the common issues with karaoke is figuring out how to stay on beat to a new song. I wanted to figure out a way to help people stay on beat and be more aware of their role in a karaoke duet. I thought this fit well within the theme of Actuated Interactive Experience Everyday Matter - Designing Interaction via Form, Motion, and Touch because it incorporates haptic feedback to make karaoke immersive through touching the microphone and motion with an accompanying actuated metronome to visually represent the BPM of the song. 


https://github.com/user-attachments/assets/1964c3f2-7310-48d3-8b49-860fc1d8c9a6

 The system works by using processing to display a portion of the karaoke version of the song titled “Summer Lovin” from the movie Grease. The users first interacts with the system by pressing one of three buttons. Each button represents a different speed of the song (1x, 2x, 0.75x). After selecting the speed of their choice the video will begin to play in processing. I created two circuits for each microphone. Each circuit connects the LED and two haptic motors in parallel to arduino pins. The project was intended for a duet, so ideally there would be two users each holding one microphone each. Then as it there turn to perform their line in the song the haptic vibrator will go off based on the timestamps i predetermined in processing. Each user will feel a vibration and see th e accompanying led light up when it is their turn to sing. Through touching and holding the microphones the users receive haptic feedback that help them physically understand when it is their turn to sing. Additionally, I used a second party application to figure out the BPM’s of the song at different speeds. While the users are singing I created a metronome with a servo that will move to the beat of the song giving the users a visual key to help them stay on beat. The main component of interactivity is through haptic feedback, servo motor mechanism, and the option to adjust and change the speed of the song.  In terms of 3D printing, I printed out two microphones for the users to interact with , a box to display the breadboard so the users could visually see the led, and printed out a servo motor base that was fabricated as a microphone. 


## Circuit Diagram
<img width="1144" height="524" alt="Project 3 - Haptic Harmony" src="https://github.com/user-attachments/assets/c7721f8a-d207-43f2-948b-fa7169dd9ba6" />


## 3D Printing Files

<img width="300" height="300" alt="Untitled 28" src="https://github.com/user-attachments/assets/758b21d2-f816-4114-aee6-61d5b9a54cc8" />

<img width="300" height="300" alt="Untitled 28" src="https://github.com/user-attachments/assets/12e4402a-325f-436d-bc08-da28213f10ba" />

<img width="300" height="300" alt="Untitled 28" src="https://github.com/user-attachments/assets/2107374c-968b-42ec-b437-649cce7daa48" />

<img width="300" height="300" alt="Untitled 28" src="https://github.com/user-attachments/assets/1e287889-f70c-4e9c-8a5a-f9fd9c2501b4" />





