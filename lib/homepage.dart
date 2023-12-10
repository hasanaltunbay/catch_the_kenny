import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List <images> imageList = List.generate(9, (index) => images());

  Timer? countDown;
  Timer? changer;
  int second= 0;
  int miliseconds=0;

  void countDownTimer(){
    countDown = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        second--;
      });
      if(second==0){
        timer.cancel();
      }
    });
  }

  void changeImage(){
    changer = Timer.periodic(Duration(milliseconds: miliseconds), (timer) {
      imageList.clear();
      imageList = List.generate(9, (index) => images());
    setState(() {
      imageList[Random().nextInt(9)].visibility = true;
    });
    if(second==0){
      timer.cancel();
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catch The Kenny",style: TextStyle(color: Colors.orange,fontSize: 25),),
      ),
      body: Column(
        children: [
           Expanded(
              flex: 1,
              child: Center(child: Text("Second: $second",style: Theme.of(context).textTheme.headlineMedium,),
              )
          ),

          Expanded(
            flex:5,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
               itemCount: 9,
              itemBuilder: (context, index) {
                return imageList[index] ;
              },
          ),
          ),
          Expanded(flex:1,
              child: Center(child: Text("Score: ${incrementScore.score}",style: Theme.of(context).textTheme.headlineMedium,),)
          ),
          Visibility(visible: second==0,child: Text("Play a Game",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold))),
          playGame(),
        ],
      ),
    );
  }

  Widget playGame() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5,top: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Visibility(visible: second==0,
                child: ElevatedButton(onPressed: (){
                  setState(() {
                    second=10;
                    miliseconds=800;
                    incrementScore.score=0;
                    countDownTimer();
                    changeImage();
                  });


                }, child: Text("Easy",style: TextStyle(fontSize: 23,color: Colors.grey.shade300)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.all(8),
                        )),
              ),
              Visibility(visible: second==0,
                child: ElevatedButton(onPressed: (){

                  setState(() {
                    second=10;
                    miliseconds=600;
                    incrementScore.score=0;
                    countDownTimer();
                    changeImage();
                  });


                }, child: Text("Normal",style: TextStyle(fontSize: 23,color: Colors.grey.shade300)),style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent)),
              ),
              Visibility(visible: second==0,
                child: ElevatedButton(onPressed: (){

                  setState(() {
                    second=10;
                    miliseconds=400;
                    incrementScore.score=0;
                    countDownTimer();
                    changeImage();
                  });


                }, child: Text("Hard",style: TextStyle(fontSize: 23,color: Colors.grey.shade300)),style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),),
              )
            ],
          ),
    );
  }
}

class images extends StatefulWidget {
  bool visibility;
   images({
     this.visibility=false,
    super.key,
  });

  @override
  State<images> createState() => _imagesState();
}

class _imagesState extends State<images> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
     if(widget.visibility){
       incrementScore().addScore();
     }
    }, child: Visibility(
      visible:widget.visibility,
      child: Image.asset("assets/image.png"),),
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0),
    );
  }
}

class incrementScore{
 static int score =0;

  void addScore(){
    score++;
  }
}
