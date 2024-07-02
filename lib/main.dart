import 'dart:io';
import 'package:bloc_test/bloc/counter/counter_bloc.dart';
import 'package:bloc_test/bloc/posts/posts_bloc.dart';
import 'package:bloc_test/bloc/users/users_bloc.dart';
import 'package:bloc_test/ui/home_screen/home_screen_ui/counter_screen.dart';
import 'package:bloc_test/ui/home_screen/home_screen_ui/post_screen.dart';
import 'package:bloc_test/ui/home_screen/home_screen_ui/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PostsBloc()),
        BlocProvider(create: (_) => UsersBloc()),
        BlocProvider(create: (_) => CounterBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PostScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}