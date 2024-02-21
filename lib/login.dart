import 'package:flutter/material.dart';
import 'todo.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Task Tally',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Icon(
                Icons.assignment_add,
                size: 100.0,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 60.0),
            Text(
              'Welcome back to Task Tally!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Calibri',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.0),
            Text(
              'Boost productivity with your task ally!',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Calibri',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TodoListScreen()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.0)),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
