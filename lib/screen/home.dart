import 'package:flutter/material.dart';
import 'package:todolist/functionLibrary.dart';

class Home extends StatefulWidget {
  final List<Map<String, dynamic>> itemList;

  Home(this.itemList);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: widget.itemList.length,
        itemBuilder: (context, index) {
          final item = widget.itemList[index];
          return ListTile(
            title: Text(item['text']),
            subtitle: Text(item['created_at']),
            trailing: Checkbox(
              value: item['completed'],
              onChanged: (value) {
                // Handle checkbox onChanged event if needed
                setState(() {
                  item['completed'] = value;
                  functionLibrary.sendPutRequest(item['_id']);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
