import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc/counter/counter_event.dart';
import 'package:bloc_test/bloc/counter/counter_state.dart';
import 'package:flutter/material.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState>{

  CounterBloc(): super(CounterState()){
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
  }

  void _increment(IncrementCounter event, Emitter<CounterState> emit){
    emit(state.copyWith(counter: state.counter + 1));
  }
  void _decrement(DecrementCounter event, Emitter<CounterState> emit){
    if(state.counter > 0){
      emit(state.copyWith(counter: state.counter - 1));
    }

  }

}