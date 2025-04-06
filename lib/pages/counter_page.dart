import 'package:flutter/material.dart';

import '../providers/counter_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final CounterState counterState = CounterProvider.of(context).state;

    return Scaffold(
      appBar: AppBar(title: const Text('Counter Page')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  counterState.decrement();
                });
              },
              icon: Icon(Icons.exposure_minus_1),
            ),
            SizedBox(width: 20),
            Text(counterState.counter.toString(), style: TextStyle(fontSize: 40)),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {
                setState(() {
                  counterState.increment();
                });
              },
              icon: Icon(Icons.exposure_plus_1),
            ),
          ],
        ),
      ),
    );
  }
}
