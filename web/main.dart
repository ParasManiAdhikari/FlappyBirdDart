// ignore_for_file: omit_local_variable_types, prefer_single_quotes

import 'dart:html';
import 'dart:math';
import 'dart:async';
final field = querySelector("#field");
final ball = querySelector("#field .ball");
final gameover = querySelector("#gameover");
final sbutton = querySelector("#sbutton");
var pipeUp = querySelector("#field .pipe_up");
final pipeDown = querySelector("#field .pipe_down");
final points = querySelector("#points");


final fieldwidth = field?.getBoundingClientRect().width.toInt() ?? 0; //700
final fieldheight = field?.getBoundingClientRect().height.toInt() ?? 0; //600
final ballHeight = ball?.getBoundingClientRect().height.toInt() ?? 0; //50

class Field{
  int width;
  int height;
  late Ball myBall;
  late Pipe pipes;
  Symbol running = #on;
  int pipesPassed = 0;
  
  Field(this.width, this.height){
    myBall = Ball(this, ballHeight);
    pipes = Pipe(this);
  }
}

class Pipe{
  int pipeUpBottom = 350;
  int pipeDownTop = 550;
  Field field;
  
  Pipe(this.field);
  
  void storeValues(int pipeUpBottom, int pipeDownTop){
    this.pipeUpBottom = pipeUpBottom;
    this.pipeDownTop = pipeDownTop;
  }
  
}

class Ball{
  int ballHeight;
  Field field;
  int distanceFromTop = 10;
  
  Ball(this.field, this.ballHeight);
  
  void ballDownwards(){
    distanceFromTop = distanceFromTop + 10;           //ball down
    
    
  }
  
  void ballUpwards(){ 
    distanceFromTop -= 50;
  }
}

class View{
  Field newField;
  View(this.newField);
  
  void update() {
      
      //UPDATE BALL POSITION & POINTS
      ball?.style.top = '${newField.myBall.distanceFromTop}px';
      points?.text = 'Points: ${newField.pipesPassed}';
      
      //VALUES NEEDED FOR COLLISION
      int ballTop = newField.myBall.distanceFromTop;
      var ballBottom = ballTop + 35; // 35 ball height
      var fieldLeft = field?.getBoundingClientRect().left.toInt() ?? 0;
      var pipeUpLeft = (pipeUp?.getBoundingClientRect().left.toInt() ?? 0) - fieldLeft;
      //subtract fieldLeft because it is different for different screens
      var pipeDownLeft = (pipeDown?.getBoundingClientRect().left.toInt() ?? 0) - fieldLeft;  
    
      /*
       collision happens when 
       pipes are in the same x axis ↔️ of the bird 
       && if bird is in the same y axis ↕️ as pipes 
      */
      bool collision = (ballTop < newField.pipes.pipeUpBottom && pipeUpLeft < 150 && pipeUpLeft > 50) ||
                        (ballBottom > newField.pipes.pipeDownTop && pipeDownLeft < 150 && pipeDownLeft > 50);
    
      //print("${fieldLeft},${pipeUpLeft}");
    
      //IF BIRD TOUCHES GROUND || COLLISION
      if(ballTop >= (fieldheight - ballHeight) || collision){
        newField.running = #off;
        ballTop -= - 2;                                 //freeze the ball
        gameover?.style.display = "inline-block";       //show buttons
        sbutton?.style.display = "inline-block";
        pipeUp?.style.animation = "stopped";            //stop pipe animation
        pipeDown?.style.animation = "stopped";
        pipeUp?.style.left = "${pipeUpLeft}px";         //freeze pipes at collision
        pipeDown?.style.left = "${pipeDownLeft}px";
      }
   }
}

class Controller{
  Field field;
  View view;
  
  Controller(this.field, this.view);
}

void main() {
  Field newField = Field(fieldwidth, fieldheight);
  View view = View(newField);
  Controller control = Controller(newField, view);
  
  //GAME START
  sbutton?.onClick.listen((_) async {                               //if start clicked run the main loop
      newField.running = #on;
      gameover?.style.display = "none";                             //hide gameover text
      sbutton?.style.display = "none";                              //hide button
      pipeUp?.style.display = "inline-block";                       //show pipes & points tally
      pipeDown?.style.display = "inline-block";
      points?.style.display = "inline-block";
      newField.pipesPassed = 0;                                              //reset point count
      newField.myBall.distanceFromTop = 0;                          //reset ball position
      pipeUp?.style.animation = "pipeanim 3s infinite linear";      //resume pipe animation
      pipeDown?.style.animation = "pipeanim 3s infinite linear";
      
      //MAIN LOOP
      Timer.periodic(Duration(milliseconds: 50), (timer){
        newField.myBall.ballDownwards();
        view.update();
        if(newField.running == #off) timer.cancel();
      });
   });
    
   //KEY PRESS EVENTLISTENER 
  window.onKeyUp.listen((_) {
    if(newField.running == #on){
      newField.myBall.ballUpwards();
      view.update();
    }
  });
  
  //NEW ANIMATION EVENTLISTENER
  pipeUp?.on['animationiteration'].listen((_) {                    //runs before new animation
    int pipeUpTop = Random().nextInt(400) * -1;                    //random pipe_up top from 0 to -400
    pipeUp?.style.top = "${pipeUpTop}px";              
    pipeDown?.style.top = "${pipeUpTop + 600}px";                  //pipe_down top is pipe_up top + pipe_up height + gap (200)
    
    //SAVE PIPE DIMENSIONS FOR COLLISION TEST
    int pipeUpBottom = pipeUpTop + 400;
    int pipeDownTop = pipeUpTop + 600;
    newField.pipes.storeValues(pipeUpBottom, pipeDownTop);
    newField.pipesPassed += 1;
  });
}