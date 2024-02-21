import 'package:flutter/material.dart';
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
    ); 
  }
}
