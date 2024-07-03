import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class CouchDb_Example extends StatefulWidget {
  const CouchDb_Example({super.key});

  @override
  State<CouchDb_Example> createState() => _CouchDb_ExampleState();
}

class _CouchDb_ExampleState extends State<CouchDb_Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: ()async{
              var body = {
                'event':'click',
                'type':'button',
                'page':'dashboard',
                'widget': 'account information',
                'button label': 'submit',
                'account number': '100011010345'
              };
              var response = await http.post(Uri.parse('http://localhost:8080/couchdb'),body: body,);
              var res = response.body;
              print(res);
            },
            child: Text('Submit'),
          ),
          ElevatedButton(
            onPressed: ()async{
              var body = {
                'event':'click',
                'type':'button',
                'page':'dashboard',
                'widget': 'user information',
                'button label': 'click here'
              };
              var response = await http.post(Uri.parse('http://localhost:8080/couchdb'),body: body);
              var res = response.body;
              print(res);
            },
            child: Text('Click Here'),
          ),
          ElevatedButton(
            onPressed: ()async{
              var body = {
                'event':'click',
                'type':'navigation',
                'from_page':'dashboard',
                'to_page':'homescreen',
                'widget': 'customer information',
                'button label': 'Go to another screen'
              };
              var response = await http.post(Uri.parse('http://localhost:8080/couchdb'),body: body);
              var res = response.body;
              print(res);
            },
            child: Text('Go to another screen'),
          ),
        ],
      ),
    );
  }
}
