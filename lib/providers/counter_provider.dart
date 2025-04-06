import 'package:flutter/material.dart';

class CounterProvider extends InheritedWidget {

  final CounterState state = CounterState();

  CounterProvider({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.different(state);
  }

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>()!;
  }

}

class CounterState {
  int _counter = 0;

  void increment() => _counter++;
  void decrement() => _counter--;
  int get counter => _counter;
  bool different(CounterState oldState) => oldState.counter != _counter;
}