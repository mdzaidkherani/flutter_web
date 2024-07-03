import 'package:bloc_test/ui/couchdb_home/couchdb_home.dart';
import 'package:bloc_test/ui/flavor/flavor_home_screen.dart';
import 'package:bloc_test/ui/home_screen/counter_screen.dart';
import 'package:bloc_test/ui/home_screen/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter_bloc.dart';
import 'bloc/posts/posts_bloc.dart';
import 'bloc/users/users_bloc.dart';

class MyApp extends StatelessWidget {
  final String flavor;

  MyApp({required this.flavor});

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
        home: CouchDb_Example(),//FlavorExample(flavor: flavor,),
      ),
    );
  }
}
