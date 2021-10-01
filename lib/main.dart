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
  int i =4;
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
        restart();
        timer?.cancel;
        textButton='Restart';
      }
      else if(textButton=='Restart')
      {
        textButton = 'Start';
      }
    });
  }
  
  void timing(){
    
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
            textButton='Continue';
          }
        }
      });
     });
  }
  
  void restart(){
    score =0;
    _counter = 5;
    timeOut = [true,true,true,true,true];
    textButton='Continue';
    i=4;
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
    
    Widget life = Container(
    child: 
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tab(
          icon: timeOut[0]? const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_border,color: null,),),
        Tab(
          icon: timeOut[1]? const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_border,color: null,),),
        Tab(
          icon: timeOut[2]? const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_border,color: null,),),
        Tab(
          icon: timeOut[3]? const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_border,color: null,),),
        Tab(
          icon: timeOut[4]? const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_border,color: null,),),
      ],
    ),
  );
    Widget Diem = Container(
    child: 
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Score :",
          style: TextStyle(
            fontSize: 32,
            color: Colors.red,
          ),
        ),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: 32,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Diem,
              life,
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