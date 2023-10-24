import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  List<String> tasks = [
    'Go for a run',
    'Write a poem',
    'Read a book',
    'Do yoga',
    'Call a friend',
  ];

  group('Todo List App Tests', () {
    late FlutterDriver driver;

    // Connect to the Flutter app before running the tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the Flutter app after the tests.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

      test('Add Task', () async {
      // Wait for the app to load
      await driver.waitFor(find.text('Todo List'));

      for (String task in tasks) {
        // Find the floating action button and tap on it to add a new task
        await driver.tap(find.byTooltip('Add Item'));
        await Future.delayed(Duration(milliseconds: 200));
        // Enter the task text in the dialog
        await driver.tap(find.byType("TextField"));
        await driver.enterText(task);
        await Future.delayed(Duration(milliseconds: 200));
        // Tap on the "Add" button in the dialog
        await driver.tap(find.text('Add'));

        // Wait for the new task to be added
        await driver.waitFor(find.text(task));

        // Delay for 500ms before adding the next task
        await Future.delayed(Duration(milliseconds: 100));
      }
    });

    //long press on widget
    test('Delete using Long press item', () async {
      // Identify the item using a Finder object

      for (String task in tasks) {
        final itemFinder = find.text(task);

        // Perform the tap action on the item
        await driver.scroll(itemFinder, 0, 0, Duration(milliseconds: 600));
        await driver.waitFor(find.text("Delete Item"));

        final delete = find.byValueKey('delete_task');
        driver.tap(delete);
        // Simulate a long press by adding a delay
        await Future.delayed(Duration(milliseconds: 100));
        // Add assertions or further actions if needed
      }
    });

    test('Add Task for second time', () async {
      // Wait for the app to load
      await driver.waitFor(find.text('Todo List'));

      for (String task in tasks) {
        // Find the floating action button and tap on it to add a new task
        await driver.tap(find.byTooltip('Add Item'));
        await Future.delayed(Duration(milliseconds: 200));
        // Enter the task text in the dialog
        await driver.tap(find.byType("TextField"));
        await driver.enterText(task);
        await Future.delayed(Duration(milliseconds: 200));
        // Tap on the "Add" button in the dialog
        await driver.tap(find.text('Add'));

        // Wait for the new task to be added
        await driver.waitFor(find.text(task));

        // Delay for 500ms before adding the next task
        await Future.delayed(Duration(milliseconds: 100));
      }
    });

    test('Mark Tasks as finished', () async {
      // Identify the item using a Finder object

      for (String task in tasks) {
        final containerFinder = find.byValueKey("todo_container");
        final itemFinder = find.ancestor(
          of: find.text(task),
          matching: containerFinder,
        );
        final checkboxFinder = find.descendant(
          of: itemFinder,
          matching: find.byValueKey("checkbox_todo"),
        );

        await driver.tap(checkboxFinder);
        //sleep for 500 ms
        await Future.delayed(Duration(milliseconds: 500));
      }

      //switch to completed task
      final navigationBarFinder = find.byValueKey('bottom_navigation_bar');
      final completedTasksItemFinder = find.byTooltip('Completed Tasks');
      final currentTasksItemFinder = find.byTooltip('Current Tasks');

      //await driver.waitFor(navigationBarFinder);
      await driver.tap(completedTasksItemFinder);

      for (String task in tasks) {
        final completedTaskWidget = find.text(task);
        await driver.waitFor(completedTaskWidget);
        await Future.delayed(Duration(milliseconds: 200));
      }
      //sleep 1 second
      /* await Future.delayed(Duration(seconds: 1));
      await driver.waitFor(navigationBarFinder);
      await driver.tap(currentTasksItemFinder);
      await Future.delayed(Duration(seconds: 10));*/
    }, timeout: Timeout(Duration(seconds: 120)));

    test('Delete completed tasks using Long press item', () async {
      // Identify the item using a Finder object

      for (String task in tasks) {
        final itemFinder = find.text(task);

        // Perform the tap action on the item
        await driver.scroll(itemFinder, 0, 0, Duration(milliseconds: 600));
        await driver.waitFor(find.text("Delete Item"));

        final delete = find.byValueKey('delete_task');
        driver.tap(delete);
        // Simulate a long press by adding a delay
        await Future.delayed(Duration(milliseconds: 100));
        // Add assertions or further actions if needed
      }
    });

    /*   test('Mark Task as Completed', () async {
      // Wait for the app to load
      await driver.waitFor(find.text('Todo List'));

      // Find the checkbox of the first task and tap on it to mark it as completed
      await driver.tap(find.byValueKey('checkbox_task_1'));

      // Wait for the task to be marked as completed
      await driver.waitFor(find.byValueKey('task_completed_1'));
    });
    */
  });
}
