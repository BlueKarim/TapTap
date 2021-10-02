import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 5;
  int tap = 0;
  String textButton = 'Start';
  int score = 0;
  Timer? timer;
  List<bool> timeOut = [true,true,true,true,true];

  void btnTapme(){
    setState(() {
      if(textButton == 'Start')
      {
        _counter=5;
        textButton = 'Tap me!';
        timing();
      }
      else if(textButton=='Tap me!')
      {
        tap++;
        if(tap == 10)
        {
          score++;
          tap = 0;
          _counter = 5;
        }
      }
      else if(textButton=='Continue')
      {
        timer?.cancel();
        textButton='Restart';
      }
      else if(textButton=='Restart')
      {
        restart();
        textButton = 'Start';
      }
    });
  }
  
  void timing(){
    int i =4;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_counter>0)
        {
          _counter--;
        }
        else
        {
          _counter=5;
          tap = 0;
          timeOut[i] = false;
          i--;
          if(i<0)
          {
            _counter =0;
            textButton='Continue';
            timer.cancel();
          }
        }
      });
     });
  }
  
  void restart(){
    score =0;
    _counter = 5;
    timeOut = [true,true,true,true,true];
  }
  @override
  void initState(){
    _counter = 5;
    tap = 0;
    score=0;
    timeOut=[true,true,true,true,true];
    super.initState();
  }
  Widget build(BuildContext context) {
    Widget timeAndTap = Container(
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Time : ",
              style: TextStyle(
                fontSize: 32,
              ),),
              Text(_counter.toString(),
              style: TextStyle(
                fontSize: 32,
              ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Tap : ",
              style: TextStyle(
                fontSize: 32,
                color: Colors.purple,
              ),),
              Text(tap.toString(),
              style: TextStyle(
                fontSize: 32,
                color: Colors.purple,
              ),),
            ],
          )
      ] 
      ),
    );
    Widget life = Container(
    padding: const EdgeInsets.all(20),
    child: 
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for(int i =0;i<timeOut.length;i++)
        Icon(
          timeOut[i]? Icons.favorite : Icons.favorite_border,
          color: timeOut[i]? Colors.red: null,
          size: 64,
        ),
      ],
    ),
  );
    Widget Diem = Container(
    padding: const EdgeInsets.all(20) ,
    child: 
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Score :",
          style: TextStyle(
            fontSize: 64,
            color: Colors.red,
          ),
        ),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: 64,
            color: Colors.red,
          ),
        ),
      ],
    ),
  );
    return MaterialApp(
      title: "TapTap",
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("TapTap"),
          backgroundColor: Colors.blue[600],
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Diem,
                  life,
                ],   
              ),
              timeAndTap,
              ElevatedButton(
                onPressed: btnTapme,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[300], //background color of button
                  side: BorderSide(width:3, color:Colors.brown), //border width and color
                  minimumSize: Size(40, 50),
                  elevation: 3, //elevation of button
                  shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.all(20) //content padding inside button
                ),
                child: Text(textButton), 
              )
            ],
          ),
        ),
      ),
    );
  }
}