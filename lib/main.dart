import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter_voice_assistant/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(
          title: 'FLUTTER VOICE ASSISTANT',
        ),
        initialRoute: '/',
        routes: {
          '/second': (context) => const SecondPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "forward":
        Navigator.pushNamed(context, '/second');
        break;
      case "back":
        Navigator.pop(context);
        break;
      default:
        debugPrint("Unknown command");
    }
  }

  _MyHomePageState() {
    /// Init Alan Button with project key from Alan AI Studio
    AlanVoice.addButton(
        "b4f1c94c2f26b4671bf53fd5db3b3ca92e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Handle commands from Alan AI Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
      _handleCommand(command.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child:
            Text("Please click the button below to start the voice assistant"),
      ),
    );
  }
}
