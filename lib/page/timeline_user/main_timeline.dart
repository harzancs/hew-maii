import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

class MainTimeLine extends StatefulWidget {
  @override
  _MainTimeLineState createState() => _MainTimeLineState();
}

class _MainTimeLineState extends State<MainTimeLine> {
  int _currentStep = 0;

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text("Step 1"),
        content: Container(
          child: Column(
            children: <Widget>[Text("ชื่อคนส่ง :")],
          ),
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text("Step 2"),
        content: TextField(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text("Step 3"),
        content: TextField(),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text("Step 4"),
        content: TextField(),
        isActive: _currentStep >= 3,
      )
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 46,
                      ),
                    ),
                    Text(
                      "ดำเนินการ ",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: FontStyles().fontFamily,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.87,
                child: Column(
                  children: <Widget>[
                    Stepper(
                      steps: _mySteps(),
                      currentStep: this._currentStep,
                      onStepTapped: (step) {
                        setState(() {
                          this._currentStep = step;
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
