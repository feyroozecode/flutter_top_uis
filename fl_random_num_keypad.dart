import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Random Keyboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const KeyboardView(),
    );
  }
}


class KeyboardView extends StatefulWidget {
  const KeyboardView({super.key});

  @override
  State<KeyboardView> createState() => _KeyboardViewState();
}

class _KeyboardViewState extends State<KeyboardView> {
  List<String> numberKeys = List.generate(10, (index) => index.toString());

  String typedText = "";

  @override
  void initState() {
    super.initState();
    _shuffleKeys();
  }

  // randomize keys
  void _shuffleKeys() {
    setState(() => numberKeys.shuffle(Random()));
  }

  // on key pressed
  void _onKeyPressed(String key) {
    setState(() => typedText += key);
  }

  // clear text
  void _clearText() {
    setState(() => typedText = "");
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Random Keyboard Flutter"),
          actions: [ IconButton(onPressed: _shuffleKeys, icon: const Icon(Icons.refresh)) ],
        ),
        body: Column(
          children: [
            Container(
              color: Colors.grey,
              height: mq.size.height * 0.15,
              child: Center(
                  child: Text(
                typedText,
                style: const TextStyle(fontSize: 28),
              )),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: mq.size.height * 0.85 -
                  (kBottomNavigationBarHeight + kToolbarHeight),
              child: Column(
                children: [
                  /// the keyboard widget
                  Expanded(
                      child: GridView.builder(
                          itemCount: numberKeys.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 7),
                          itemBuilder: (context, index) {
                            final indexKey = numberKeys[index];

                            return ElevatedButton(
                                onPressed: () => _onKeyPressed(indexKey),
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10)),
                                child: Text(
                                  indexKey,
                                  style: const TextStyle(fontSize: 20),
                                ));
                          })),

                  // Clear button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton( onPressed: _clearText, child: const Icon(Icons.clear)),
                  ),
                ],
              ),

            )
          ],
        )
      );
  }
}
