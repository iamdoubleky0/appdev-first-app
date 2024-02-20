import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(ThemeData.light()),
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tally',
      home: LoginScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
