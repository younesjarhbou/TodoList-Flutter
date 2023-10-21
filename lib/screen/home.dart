import 'package:flutter/material.dart';
import 'package:todolist/functionLibrary.dart';

class Home extends StatefulWidget {
  final List<Map<String, dynamic>> itemList;

  Home(this.itemList);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final TextEditingController _textEditingController = TextEditingController();

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: 'Enter todo item'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                final String text = _textEditingController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    final Map<String, dynamic> requestBody = {
                      'text': text,
                      'completed': false,
                    };
                    widget.itemList.add({
                      'text': text,
                      'created_at': DateTime.now().toString(),
                      'completed': false,
                    });
                    functionLibrary.makePostRequest(requestBody);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> getCompletedTasks() {
    return widget.itemList.where((item) => item['completed']).toList();
  }

  List<Map<String, dynamic>> getCurrentTasks() {
    return widget.itemList.where((item) => !item['completed']).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _currentIndex == 0
          ? ListView.builder(
              itemCount: getCurrentTasks().length,
              itemBuilder: (context, index) {
                final item = getCurrentTasks()[index];
                return ListTile(
                  title: Text(item['text']),
                  subtitle: Text(item['created_at']),
                  trailing: Checkbox(
                    value: item['completed'],
                    onChanged: (value) {
                      setState(() {
                        functionLibrary.sendPutRequest(item['_id']);
                        item['completed'] = value;
                        
                      });
                    },
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: getCompletedTasks().length,
              itemBuilder: (context, index) {
                final item = getCompletedTasks()[index];
                return ListTile(
                  title: Text(item['text']),
                  subtitle: Text(item['created_at']),
                  trailing: Icon(Icons.done),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: 'Current Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completed Tasks',
          ),
        ],
      ),
    );
  }
}
