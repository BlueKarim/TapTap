import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // a material app is the root of any Flutter app
      title: 'Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stopwatch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textButton = 'Start';
  int score = 0;
  int _counter = 10;
  int tap =0;
  List<bool> timeOut = [true,true,true,true,true];
  Timer? _timer; // the timer that controls to increment the counter once a second
  int _countedSeconds = 0; // how many seconds have been counted so far, initialises to zero
  Duration timedDuration = Duration.zero; // the duration of the timer so far, initialises to zero
  bool _timerRunning = false; // the state of whether the timer is running or not
  // final lapTimes = <Duration>[]; // can you figure out how to add a lap timer?
  void btnTapme(){
    setState(() {
      if(textButton == 'Start')
      {
        _counter=10;
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
          _counter = 10;
        }
      }
      else if(textButton=='Continue')
      {
        _timer?.cancel();
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_counter>0)
        {
          _counter--;
          timedDuration = Duration(seconds: _counter);
        }
        else
        {
          _counter=10;
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
    _counter = 10;
    timeOut = [true,true,true,true,true];
  }
  @override
  void initState() {
    score = 0;
    _counter = 10;
    timeOut = [true,true,true,true,true];
    tap =0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: 
                  AspectRatio(
                    child: CircularProgressIndicator(
                      // backgroundColor: Colors.black,
                      strokeWidth: 20,
                      // Below, we work out the progress for the circular progress indicator
                      // We do so by getting the total amount of seconds so far, and then
                      // we use the .remainder function to get only the seconds component of the
                      // current minute being counted. We then divide it by 60 to work out how far
                      // through the progress should be (so, 30 would be 0.5, or 50% of a minute)
                      value: _counter.remainder(10) / 10,
                    ),
                    aspectRatio: 1,
                  ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
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
                Row(
                  children: [
                    for(int i =0;i<timeOut.length;i++)
                    Icon(
                      timeOut[i]? Icons.favorite : Icons.favorite_border,
                      color: timeOut[i]? Colors.red: null,
                      size: 32,
                    ),
                  ],
                ), 
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timedDuration.inSeconds.remainder(60).toString().padLeft(2, '0'),
                  style: Theme.of(context).textTheme.headline1,
                ),
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
          ],
        ),
      ),
    );
  }
}
