import processing.video.*;
import processing.serial.*;

Movie regularVideo;
Movie fastVideo;
Movie slowVideo;
Movie currentVideo;

Serial arduino;

String screen = "START";
String mode = "NONE";
String currentLyric = "";

float cueOffset = 0.20;

boolean songEnded = false;
boolean silentSent = false;

void setup() {

  size(1000, 650);

  regularVideo = new Movie(this, "regular_speed_song.mp4");
  fastVideo = new Movie(this, "fast_speed_song.mp4");
  slowVideo = new Movie(this, "slow_speed_song_2.mp4");

  regularVideo.play();
  regularVideo.pause();

  fastVideo.play();
  fastVideo.pause();

  slowVideo.play();
  slowVideo.pause();

  printArray(Serial.list());

  arduino = new Serial(this, "/dev/cu.usbmodem1101", 9600);
  arduino.bufferUntil('\n');

  textAlign(CENTER, CENTER);
  rectMode(CENTER);
}

void draw() {

  background(0);
  
//starting screen 
  if (screen.equals("START")) {
    fill(255);
    textSize(55);
    text("HAPTIC HARMONY", width/2, height/2 - 70);
    textSize(24);
    text("Press any physical button to start", width/2, height/2 + 20);
  }

  else if (screen.equals("PICK_SPEED")) {
   fill(255);
  textSize(42);
  text("Pick Your Song Speed", width/2, height/2 - 100);  
  textSize(36);  
  text("SLOW", width/2 - 260, height/2); 
  text("|", width/2 - 120, height/2);
  text("NORMAL", width/2, height/2);
  text("|", width/2 + 140, height/2);
  text("FAST", width/2 + 260, height/2);
  }

  else if (screen.equals("PLAYING")) {
    if (currentVideo != null) {
      image(currentVideo, 0, 0, width, height);
      if (currentVideo.time() >= currentVideo.duration()) {
        resetToStart();
        return;
      }

      float t = currentVideo.time() + cueOffset;
      if (mode.equals("SLOW")) {
        slowSpeed(t);
      } 
      else if (mode.equals("NORMAL")) {
        normalSpeed(t);
      } 
      else if (mode.equals("FAST")) {
        fastSpeed(t);
      }
      drawLyrics();
    }
  }
}


void serialEvent(Serial arduino) {
  String message = arduino.readStringUntil('\n');
  if (message == null) return;
  message = trim(message);
  println("Received: " + message);
  if (screen.equals("START")) {
    screen = "PICK_SPEED";
    return;
  }

  if (screen.equals("PICK_SPEED")) {
    if (message.equals("SLOW")) {
      startSong("SLOW");
    } 
    else if (message.equals("NORMAL")) {
      startSong("NORMAL");
    } 
    else if (message.equals("FAST")) {
      startSong("FAST");
    }
  }
}

//plays song 

void startSong(String selectedMode) {

  mode = selectedMode;
  songEnded = false;
  silentSent = false;
  currentLyric = "";
  arduino.write("OFF\n");
  regularVideo.stop();
  fastVideo.stop();
  slowVideo.stop();

  // SELECT VIDEO
  if (mode.equals("SLOW")) {
    currentVideo = slowVideo;
    arduino.write("SLOW\n");
  }
  else if (mode.equals("NORMAL")) {
    currentVideo = regularVideo;
    arduino.write("NORMAL\n");
  }
  else if (mode.equals("FAST")) {
    currentVideo = fastVideo;
    arduino.write("FAST\n");
  }
  currentVideo.jump(0);
  currentVideo.play();

  delay(100);

  arduino.write("START\n");

  screen = "PLAYING";
}

// this resets the system back to the starting screen
void resetToStart() {
  arduino.write("OFF\n");
  if (currentVideo != null) {
    currentVideo.stop();
    currentVideo = null;
  }

  mode = "NONE";
  currentLyric = "";
  songEnded = false;
  silentSent = false;
  delay(500);
  screen = "START"; 
}

//timestamps for normal speed indicating when it's each players turn.  
void normalSpeed(float t) {

  if (t < 8.8) {

    silent();
  } 
  else if (t >= 8.8 && t < 13) {

    player1("Summer lovin', had me a blast");
  } 
  else if (t >= 13 && t < 13.3) {

    silent();
  }
  else if (t >= 13.3 && t < 16.5) {
    player2("Summer loving happened so fast");
  } 
  else if (t >= 16.5 && t < 21) {
    player1("I met a girl crazy for me");
  } 
  else if (t >= 21 && t < 24) {
    player2("Met a boy cute as can be");
  } 
  else if (t >= 24 && t < 25) {
    silent();
  }
  else if (t >= 25 && t < 32) {
    both("Summer days drifting away...");
  } 
  else {
    resetToStart();
  }
}

//timestamps for slow pace indicating when its each players turn at that speed. 
void slowSpeed(float t) {

  if (t < 12) {
    silent();
  } 
  else if (t >= 12 && t < 17.5) {
    player1("Summer lovin', had me a blast");
  } 
  else if (t >= 17.5 && t < 22) {
    player2("Summer loving happened so fast");
  } 
  else if (t >= 22 && t < 28) {
    player1("I met a girl crazy for me");
  } 
  else if (t >= 28 && t < 32) {
    player2("Met a boy cute as can be");
  } 
  else if (t >= 32 && t < 33) {
    silent();
  }
  else if (t >= 33 && t < 42) {
    both("Summer days drifting away...");
  } 
  else {
    resetToStart();
  }
}


//timestamps for the fastest pace of the song, indiating when it's each players turn.
void fastSpeed(float t) {

  if (t < 5) {
    silent();
  } 
  else if (t >= 5 && t < 6.2) {
    player1("Summer lovin', had me a blast");
  } 
  else if (t >= 6.2 && t < 8.1) {
    player2("Summer loving happened so fast");
  } 
  else if (t >= 8.1 && t < 10.2) {
    player1("I met a girl crazy for me");
  } 
  else if (t >= 10.2 && t < 12.2) {
    player2("Met a boy cute as can be");
  } 
  else if (t >= 12.2 && t < 16) {
    both("Summer days drifting away...");
  } 
  else {
    resetToStart();
  }
}
//communicates with arduino to activate vibrarion motors and leds when its player 1's turn. 
void player1(String lyric) {

  currentLyric = lyric;

  arduino.write("P1\n");

  silentSent = false;
}
// communicates with arduino to activate vibration motors and leds when it's player 2's turn.
void player2(String lyric) {

  currentLyric = lyric;

  arduino.write("P2\n");

  silentSent = false;
}
//activate when its both players turns 
void both(String lyric) {

  currentLyric = lyric;

  arduino.write("BOTH\n");

  silentSent = false;
}
//portions of no time 
void silent() {
  currentLyric = "";
  if (!silentSent) {
    arduino.write("SILENT\n");
    silentSent = true;
  }
}

void drawLyrics() {
  fill(0, 170);
  rect(width/2, height - 65, width, 130);
  textSize(34);
  fill(255);
  text(currentLyric, width/2, height - 65);
}


void movieEvent(Movie m) {
  m.read();
}

void exit() {
  arduino.write("OFF\n");
  delay(100);
  super.exit();
}
