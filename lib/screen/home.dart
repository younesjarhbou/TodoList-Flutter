import 'package:flutter/material.dart';
import 'package:todolist/config.dart';
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
                  final Map<String, dynamic> requestBody = {
                    'text': text,
                    'completed': false,
                  };
                  functionLibrary.makePostRequest(requestBody).then((_) {
                    print("jarhbou then post request successful " +
                        config.insertedtodo.toString());
                    setState(()
                    {
                      widget.itemList.add(config.insertedtodo);
                    });
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

  //delete item from widget.itemList where id = given id
  void deleteItem(String id) {
    widget.itemList.removeWhere((item) => item['_id'] == id);
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
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onLongPress: () {
                      showDeleteDialog(item['_id']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
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
                      ),
                    ),
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: getCompletedTasks().length,
              itemBuilder: (context, index) {
                final item = getCompletedTasks()[index];
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onLongPress: () {
                      showDeleteDialog(item['_id']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(item['text']),
                        subtitle: Text(item['created_at']),
                        trailing: Icon(Icons.done),
                      ),
                    ),
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

  void showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                functionLibrary.deleteTodoById(id);
                setState(() {
                  deleteItem(id);
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
