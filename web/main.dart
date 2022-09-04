// ignore_for_file: omit_local_variable_types, prefer_single_quotes

import 'dart:html';
import 'dart:math';
import 'dart:async';

final field = querySelector("#field");
final bird = querySelector("#field .bird");
final gameover = querySelector("#gameover");
final sbutton = querySelector("#sbutton");
var pipeUp = querySelector("#field .pipe_up");
final pipeDown = querySelector("#field .pipe_down");
final points = querySelector("#points");

final fieldwidth = field?.getBoundingClientRect().width.toInt() ?? 0;   //700
final fieldheight = field?.getBoundingClientRect().height.toInt() ?? 0; //600
final birdHeight = bird?.getBoundingClientRect().height.toInt() ?? 0;   //35

/* Model */
class Field {
  int width;
  int height;
  late Bird myBird;
  late Pipe pipes;
  Symbol gamestate = #on;
  int pipesPassed = 0;

  Field(this.width, this.height) {
    myBird = Bird(this, birdHeight);
    pipes = Pipe(this);
  }
}

class Pipe {
  int pipeUpTop = -50;                                             //first pipes values
  int pipeUpBottom = 350;
  int pipeDownTop = 470;                                           //GAP = 120px
  Field field;

  Pipe(this.field);

  void storeValues(int pipeUpTop, int pipeUpBottom, int pipeDownTop) {
    this.pipeUpTop = pipeUpTop;
    this.pipeUpBottom = pipeUpBottom;
    this.pipeDownTop = pipeDownTop;
  }
}

class Bird {
  int birdHeight;
  Field field;
  int distanceFromTop = 10;

  Bird(this.field, this.birdHeight);

  void birdDownwards() {
    distanceFromTop = distanceFromTop + 10;                        //bird down
  }

  void birdUpwards() {
    distanceFromTop -= 50;
  }
}

/*VIEW*/
class View {
  Field newField;
  View(this.newField);

  void update() {
    //UPDATE BIRD POSITION & POINTS
    bird?.style.top = '${newField.myBird.distanceFromTop}px';
    points?.text = 'Points: ${newField.pipesPassed}';
    pipeUp?.style.top = "${newField.pipes.pipeUpTop}px";
    pipeDown?.style.top ="${newField.pipes.pipeDownTop}px";       //pipe_down top is pipe_up top + pipe_up height + gap (200)

    //VALUES NEEDED FOR COLLISION
    var birdTop = newField.myBird.distanceFromTop;
    var birdBottom = birdTop + 35;                                // 35 bird height
    var fieldLeft = field?.getBoundingClientRect().left.toInt() ?? 0;
    var pipeUpLeft =
        (pipeUp?.getBoundingClientRect().left.toInt() ?? 0) - fieldLeft;
    //subtract fieldLeft because it is different for different screens
    var pipeDownLeft =
        (pipeDown?.getBoundingClientRect().left.toInt() ?? 0) - fieldLeft;

    /*
       Collision happens when 
       pipes are in the same x axis ↔️ of the bird 
       && if pipes are in the same y axis ↕️ as the bird 
      */
    bool collision = (birdTop < newField.pipes.pipeUpBottom &&
            pipeUpLeft < 150 &&
            pipeUpLeft > 50) ||
        (birdBottom > newField.pipes.pipeDownTop &&
            pipeDownLeft < 150 &&
            pipeDownLeft > 50);

    //print("${fieldLeft},${pipeUpLeft}");

    //IF BIRD TOUCHES GROUND || COLLISION
    if (birdTop >= (fieldheight - birdHeight) || collision) {
      newField.gamestate = #off;
      field?.style.backgroundImage = "url('img/static.jpg')";     //pause bg
      birdTop -= -2;                                              //freeze the bird
      gameover?.style.display = "inline-block";                   //show buttons
      sbutton?.style.display = "inline-block";
      pipeUp?.style.animation = "stopped";                        //stop pipe animation
      pipeDown?.style.animation = "stopped";
      pipeUp?.style.left = "${pipeUpLeft}px";                     //freeze pipes at collision
      pipeDown?.style.left = "${pipeDownLeft}px";
    }
  }
}

/*Controller not really required for this project*/
class Controller {
  Field field;
  View view;
  Controller(this.field, this.view);
}

void main() {
  Field newField = Field(fieldwidth, fieldheight);
  View view = View(newField);
  //Controller control = Controller(newField, view);

  //GAME START
  sbutton?.onClick.listen((_) async {
    newField.gamestate = #on;
    gameover?.style.display = "none";                             //hide gameover text
    sbutton?.style.display = "none";                              //hide button
    pipeUp?.style.display = "inline-block";                       //show pipes & points tally
    pipeDown?.style.display = "inline-block";
    points?.style.display = "inline-block";
    newField.pipesPassed = 0;                                     //reset point count
    newField.myBird.distanceFromTop = 0;                          //reset bird position
    pipeUp?.style.animation =
        "pipeanim 3s infinite linear";                            //resume pipe animation
    pipeDown?.style.animation = "pipeanim 3s infinite linear";
    field?.style.backgroundImage = "url('img/background.gif')";   //resume bg

    //MAIN LOOP
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      newField.myBird.birdDownwards();
      view.update();
      if (newField.gamestate == #off) timer.cancel();
    });
  });

  //KEY PRESS EVENTLISTENER
  window.onKeyUp.listen((_) {
    if (newField.gamestate == #on) {
      newField.myBird.birdUpwards();
      view.update();
    }
  });

  //NEW ANIMATION EVENTLISTENER
  pipeUp?.on['animationiteration'].listen((_) {

    //SAVE PIPE DIMENSIONS FOR COLLISION TEST
    int pipeUpTop = Random().nextInt(400) * -1;                   //random pipe_up top from 0 to -400
    int pipeUpBottom = pipeUpTop + 400;
    int pipeDownTop = pipeUpTop + 520;                            //GAP = 120px
    newField.pipes.storeValues(pipeUpTop, pipeUpBottom, pipeDownTop);
    newField.pipesPassed += 1;
    view.update();
  });
}
