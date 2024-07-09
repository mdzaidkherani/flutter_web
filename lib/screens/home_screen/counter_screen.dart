import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import '../../bloc/counter/counter_bloc.dart';
import '../../bloc/counter/counter_event.dart';
import '../../bloc/counter/counter_state.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int _counter = FlavorConfig.instance.variables["counter"];
    for(var i = 0; i<_counter;i++){
      context.read<CounterBloc>().add(IncrementCounter());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state){
              return Center(
                child: Text(state.counter.toString(),
                  style: TextStyle(fontSize: 60),
                ),
              );
            },
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: (){
                  context.read<CounterBloc>().add(IncrementCounter());
                },
                child: Text('Increment'),
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                onPressed: (){
                  context.read<CounterBloc>().add(DecrementCounter());
                },
                child: Text('Decrement'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
