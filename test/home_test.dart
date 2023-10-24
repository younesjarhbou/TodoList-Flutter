// Import the required packages
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/config.dart';
import 'package:todolist/functionLibrary.dart';
import 'package:todolist/screen/home.dart';

void main() {
  // Create a mock list of items for testing
  List<Map<String, dynamic>> itemList = [
    {'_id': '1', 'text': 'Task 1', 'created_at': '2022-01-01', 'completed': false},
    {'_id': '2', 'text': 'Task 2', 'created_at': '2022-01-02', 'completed': true},
    // Add more test data if needed
  ];

  testWidgets('Todo List App Tests', (WidgetTester tester) async {
    // Mount the app
    //await tester.pumpWidget(MaterialApp(home: Home(itemList)));

    // Test: Renders AppBar with title
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Todo List'), findsOneWidget);

    // Test: Renders FloatingActionButton
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Test: Renders BottomNavigationBar
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.check_box_outline_blank), findsOneWidget);
    expect(find.byIcon(Icons.done_all), findsOneWidget);

    /*// Test: Switches between current and completed tasks
    // Initial state should show current tasks
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsNothing);

    // Tap on the bottom navigation bar to switch to completed tasks
    await tester.tap(find.byIcon(Icons.done_all));
    await tester.pump();

    expect(find.text('Task 1'), findsNothing);
    expect(find.text('Task 2'), findsOneWidget);

    // Tap again to switch back to current tasks
    await tester.tap(find.byIcon(Icons.check_box_outline_blank));
    await tester.pump();

    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsNothing);

    // Test: Adds a new todo item
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(itemList.length, 3);
    expect(itemList[2]['text'], 'New Task');
    expect(find.text('New Task'), findsOneWidget);

    // Test: Deletes a todo item
    expect(find.byType(AlertDialog), findsNothing);

    await tester.longPress(find.text('Task 1'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Delete Item'), findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(itemList.length, 1);
    expect(itemList[0]['text'], 'Task 2');
    expect(find.text('Task 1'), findsNothing);

    // Test: Updates the completed status of a task
    expect(itemList[0]['completed'], false);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.text('Task 1'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(itemList[0]['completed'], true);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.text('Task 1'), findsOneWidget);*/
  });
}
