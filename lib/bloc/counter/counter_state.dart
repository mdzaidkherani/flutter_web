import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CounterState extends Equatable{

  final int counter;

  CounterState({
    this.counter = 0,
  });

  CounterState copyWith ({int? counter}){
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [counter];

}