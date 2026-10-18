import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const MyApp(),
    )
  );
}

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 0){
      _count--;
      notifyListeners();
    }
  }

  void reset(){
    _count = 0;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Provider Example",
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final count = context.watch<CounterModel>().count;

    return Scaffold(
      body: Center(

        child: Column(
          mainAxisAlignment: .center,
          children: [
            Row(
              mainAxisAlignment: .center,
              children: [
                ElevatedButton(
                  onPressed: context.read<CounterModel>().decrement,
                  child: Icon(Icons.remove)
                ),
                SizedBox(width: 20,),
                Text(
                  "Count: $count"
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: context.read<CounterModel>().increment, 
                  child: Icon(Icons.add))
              ],
            ),
            SizedBox(width: 28,),
            ElevatedButton(
              onPressed: context.read<CounterModel>().reset, 
              child: Text("Reset"))
          ],
        )
      ),
    );
  }
}