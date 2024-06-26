import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;

class CustomWebView extends StatefulWidget {
  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {

  String _htmlContent = '<p>Loading...</p>';
  List data = [];
  bool loading = true;
  double timeTaken = 0;
  double timeTaken2 = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchData2();
  }

  Future<void> _fetchData() async {

    final url = 'http://localhost:8080/users';
    try {
      final startTime = DateTime.now();
      final response = await http.get(Uri.parse(url));
      final endTime = DateTime.now();
      final duration = (endTime.difference(startTime).inMilliseconds)/1000;
      print(duration);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          _htmlContent = response.body;
          loading = false;
          timeTaken = duration;
        });
      } else {
        setState(() {
          _htmlContent = 'Failed to load content';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _htmlContent = 'Error: $e';
        loading = false;
      });
    }
  }

  Future<void> _fetchData2() async {

    final url = 'https://jsonplaceholder.typicode.com/users';
    try {
      final startTime = DateTime.now();
      final response = await http.get(Uri.parse(url));
      final endTime = DateTime.now();
      final duration = (endTime.difference(startTime).inMilliseconds)/1000;
      print(duration);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body);
          loading = false;
          timeTaken2 = duration;
        });
      } else {
        setState(() {
          _htmlContent = 'Failed to load content';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _htmlContent = 'Error: $e';
        loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Render HTML Example'),
      ),
      body: loading
      ? Center(child: CircularProgressIndicator(),)
      : ListView(
        children: [
          Text(timeTaken.toString()),
          HtmlWidget(_htmlContent,renderMode: RenderMode.column,),
          SizedBox(height: 50,),
          Text(timeTaken2.toString()),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${data[index]['name']}'),
                      Text('${data[index]['username']}'),
                      Text('${data[index]['email']}'),
                    ],
                  ),
                  leading: Text('${data[index]['id']}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}