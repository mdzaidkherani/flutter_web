import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc_test/model/postmodel/post_model.dart';
import 'package:dio/dio.dart';

class PostRepository{
  
  Future<Map<String,dynamic>> fetchPost() async {

    try{
      final startTime = DateTime.now();
      final response = await Dio().get('https://jsonplaceholder.typicode.com/comments');
      final endTime = DateTime.now();
      final duration = (endTime.difference(startTime).inMilliseconds)/1000;
      print(duration);
      if(response.statusCode == 200){
        List<PostModel> data = [];
        final List body = response.data;
        // print(body);
        body.forEach((e){
          data.add(
            PostModel(
              postId: e['postId'],
              name: e['name'],
              id: e['id'],
              email: e['email'],
              body: e['body'],
            )
          );
        });
        return
        {
          'data': data,
          'timeTaken': duration,
        };

      }
    }
    on SocketException{
      print('aa');
      throw Exception('Error while fetching data');
    }
    on TimeoutException{
      print('bb');
      throw Exception('Error while fetching data');
    }
    print('cc');
    throw Exception('Error while fetching data');
  }

  Future<Map<String,dynamic>> fetchWebView() async {

    try{
      final startTime = DateTime.now();
      final response = await Dio().get('http://localhost:8080/todo');
      final endTime = DateTime.now();
      final duration = (endTime.difference(startTime).inMilliseconds)/1000;
      print(duration);
      if(response.statusCode == 200){
        final String htmlString = response.data;

        return
          {
            'data': htmlString,
            'timeTaken': duration,
          };

      }
    }
    on SocketException{
      print('aa');
      throw Exception('Error while fetching data');
    }
    on TimeoutException{
      print('bb');
      throw Exception('Error while fetching data');
    }
    print('cc');
    throw Exception('Error while fetching data');
  }



}