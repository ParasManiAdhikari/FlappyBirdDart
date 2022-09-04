// ignore_for_file: prefer_single_quotes

import 'dart:html';
import 'dart:math';
import 'dart:async';
final field = querySelector('#field');
final ball = querySelector('#field .ball');
final gameover = querySelector('#gameover');
final sbutton = querySelector('#sbutton');
var pipeUp = querySelector('#field .pipe_up');
final pipeDown = querySelector('#field .pipe_down');
final points = querySelector('#points');


Symbol gamestate = #on;
bool collision = false;
int pipesPassed = 0;

final fieldwidth = field?.getBoundingClientRect().width.toInt() ?? 0; //700
final fieldheight = field?.getBoundingClientRect().height.toInt() ?? 0; //600
final ballHeight = ball?.getBoundingClientRect().width.toInt() ?? 0; //50
int pipeUpBottom = 0;
int pipeDownTop = 0;

class Field{
  int width;
  int height;
  late Ball myBall;
  late Pipe pipes;
  
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
      var ballTop = newField.myBall.distanceFromTop;
      ball?.style.top = '${newField.myBall.distanceFromTop}px';
      points?.text = 'Points: $pipesPassed';
      
      /*
       COLLISION - for it we need to see if pipes are in the same x axis of the ball 
       and if ball is in the same y axis as pipes 
      */
      var fieldLeft = field?.getBoundingClientRect().left.toInt() ?? 0;
      var pipeUpLeft = (pipeUp?.getBoundingClientRect().left.toInt() ?? 0) - fieldLeft;
      var pipeDownLeft = (pipeDown?.getBoundingClientRect().left.toInt() ?? 0) - fieldLeft;  //subtract fieldLeft because it is different for different screen resolutions
      var ballBottom = ballTop + 50;
      var collision = (ballTop < newField.pipes.pipeUpBottom && pipeUpLeft < 150 && pipeUpLeft > 50) ||
                        (ballBottom > newField.pipes.pipeDownTop && pipeDownLeft < 150 && pipeDownLeft > 50);
    
      //print("${fieldLeft},${pipeUpLeft}, ${ball?.getBoundingClientRect().left.toInt() ?? 0}");
      if(ballTop >= (fieldheight - ballHeight) || collision){
        gamestate = #off;
        ballTop -= - 2;                                 //freeze the ball
        gameover?.style.display = 'inline-block';       //show buttons
        sbutton?.style.display = 'inline-block';
        pipeUp?.style.animation = 'stopped';            //stop pipe animation
        pipeDown?.style.animation = 'stopped';
        pipeUp?.style.left = '${pipeUpLeft}px';         //freeze pipes at collision
        pipeDown?.style.left = '${pipeDownLeft}px';
      }
   }
}

void main() {
  var newField = Field(fieldwidth, fieldheight);
  var view = View(newField);
  
  pipeUp?.on['animationiteration'].listen((_) {                    //runs before new animation
    var pipeUpTop = Random().nextInt(400) * -1;                    //random pipe_up top from 0 to -400
    pipeUp?.style.top = '${pipeUpTop}px';              
    pipeDown?.style.top = '${pipeUpTop + 600}px';                  //pipe_down top is pipe_up top + pipe_up height + gap (200)
    
    /*Saving important dimensions of the new pipe for later collision testing*/
    pipeUpBottom = pipeUpTop + 400;
    pipeDownTop = pipeUpTop + 600;
    newField.pipes.storeValues(pipeUpBottom, pipeDownTop);
    pipesPassed += 1;
  });
  
  gameover?.style.display = 'none';
  
  sbutton?.onClick.listen((_) async {                               //if start clicked run the main loop
      gamestate = #on;
      gameover?.style.display = "none";                             //hide gameover text
      sbutton?.style.display = "none";                              //hide button
      pipeUp?.style.display = "inline-block";                       //show pipes & points tally
      pipeDown?.style.display = "inline-block";
      points?.style.display = "inline-block";
      pipesPassed = 0;                                              //reset point count
      newField.myBall.distanceFromTop = 0;                          //reset ball position
      pipeUp?.style.animation = "pipeanim 3s infinite linear";      //resume pipe animation
      pipeDown?.style.animation = "pipeanim 3s infinite linear";
      
      while(gamestate == #on){
        newField.myBall.ballDownwards();
        view.update();
        await Future.delayed(const Duration(milliseconds : 50));
      }
   });
  
   window.onKeyUp.listen((_) {
          if(gamestate == #on){
            newField.myBall.ballUpwards();
            view.update();
          }
   });
}