# Flutter Project Documentation
This documentation provides detailed information on how to run and customize the Flutter project that uses a Node.js backend. Please follow the instructions below to set up and run the project successfully.

Requirements
Before proceeding, make sure you have the following installed on your machine:

Flutter SDK (along with Dart)
Node.js
Android Studio / Xcode (for emulators or physical devices)
Setup
Clone the project repository from the remote repository.

```Bash
    git clone https://github.com/younesjarhbou/TodoList-Flutter.git
```
 
 
- Open the terminal and navigate to the project folder.
```Bash
    $ cd flutter_project
``` 

- Install project dependencies by running the following command:


```Bash
    flutter pub get
```

- Update config.dart file located at lib/config/config.dart to customize the API URL and token variable.
```dart
    class Config {
  static const String api_url = '<your_api_url>';
  static const String token = '<your_token>';
}
``` 
- Running the Project
On Emulator / Simulator
Start an emulator or simulator using Android Studio or Xcode.

Run the following command in the terminal to launch the application.

```Bash
     flutter run
``` 
- On Physical Device
Connect your physical device to the computer.

Enable USB debugging on your device.

Run the following command in the terminal to install and launch the application on the connected device.

```Bash
     flutter run
``` 

Running Driver Tests
The project includes driver tests to ensure the functionality of various features. To run the driver tests, follow the steps below:

Ensure that the project dependencies are installed (as mentioned in the Setup section).

Open the terminal and navigate to the project folder.

Run the following command to execute the driver tests.

```Bash
    $ flutter drive --target=test_driver/app.dart
``` 




### Conclusion

This documentation provides you with the necessary steps to set up, run, and customize the Flutter project that uses a Node.js backend. Make sure to update the API URL and token variable in the config.dart file to match your specific environment.

If you have any further questions or need additional assistance, please feel free to ask. Happy coding!
 






## Usage/Examples

```javascript
import Component from 'my-project'

function App() {
  return <Component />
}
```

