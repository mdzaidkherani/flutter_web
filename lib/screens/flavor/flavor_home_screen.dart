import 'package:flutter/material.dart';

class FlavorExample extends StatefulWidget {
  final String flavor;

  const FlavorExample({super.key,required this.flavor});

  @override
  State<FlavorExample> createState() => _FlavorExampleState();
}

class _FlavorExampleState extends State<FlavorExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.flavor),),
    );
  }
}
