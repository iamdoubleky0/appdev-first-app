import 'package:flutter/material.dart';
import 'package:notes/login.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

//-------------------SETTINGS SCREEN------------------//
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Calibri',
          ),
        ),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Theme'),
                trailing: DropdownButton<ThemeData>(
                  value: themeProvider.themeData,
                  onChanged: (ThemeData? newValue) {
                    if (newValue != null) {
                      themeProvider.setThemeData(newValue);
                    }
                  },
                  items: <DropdownMenuItem<ThemeData>>[
                    DropdownMenuItem<ThemeData>(
                      value: ThemeData.light(),
                      child: Text('Light'),
                    ),
                    DropdownMenuItem<ThemeData>(
                      value: ThemeData.dark(),
                      child: Text('Dark'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        onPressed: () {
          _showLogoutConfirmation(context);
        },
        child: Icon(Icons.exit_to_app, color: Theme.of(context).floatingActionButtonTheme.foregroundColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

//-------------------LOGOUT BUTTON------------------//
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                // Perform logout action here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
