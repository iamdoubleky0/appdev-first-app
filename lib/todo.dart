import 'package:flutter/material.dart';
import 'settings.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todos = [];
  TextEditingController _textEditingController = TextEditingController();
  List<bool> checked = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Tally",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Calibri',
                  fontSize: 26,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello there, ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Calibri',
                    ),
                  ),
                  Text(
                    "Let's get organized and productive!",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Calibri',
                    ),
                  ),
                ],
              ),
            ),
            //-------------------TOTAL AND REMAINING TASK CONTAINER------------------//
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildInfoBox('Total Tasks', '${todos.length}'),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: _buildInfoBox(
                      'Remaining Tasks',
                      '${todos.length - checked.where((element) => element).length}',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: todos.isEmpty
                  ? Container()
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Column(
                          children: [
                            Divider(),
                            ListTile(
                              leading: Checkbox(
                                value: checked[index],
                                onChanged: (value) {
                                  setState(() {
                                    checked[index] = value!;
                                  });
                                },
                              ),
                              title: Text(todo, style: TextStyle(fontFamily: 'Calibri')),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _showEditTodoDialog(context, index);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        todos.removeAt(index);
                                        checked.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Calibri',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Calibri',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Task',
            style: TextStyle(fontFamily: 'Calibri', fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: 'Enter your task'),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Calibri',
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  fontFamily: 'Calibri',
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                String task = _textEditingController.text.trim();
                if (task.isNotEmpty) {
                  setState(() {
                    todos.add(task);
                    checked.add(false);
                    _textEditingController.clear();
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Task cannot be empty!'),
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }
  void _showEditTodoDialog(BuildContext context, int index) {
    _textEditingController.text = todos[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task',
              style: TextStyle(
                  fontFamily: 'Calibri', fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: 'Enter your task'),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('Cancel',
                  style: TextStyle(
                    fontFamily: 'Calibri',
                    color: Colors.white,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'Calibri',
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  todos[index] = _textEditingController.text;
                  _textEditingController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
