import 'package:bloc_test/bloc/posts/posts_bloc.dart';
import 'package:bloc_test/bloc/posts/posts_events.dart';
import 'package:bloc_test/bloc/posts/posts_states.dart';
import 'package:bloc_test/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostsBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostsBloc,PostsStates>(
        builder: (context,state){
          // print(state.postList.length);
          switch(state.apiStatus){
            case ApiStatus.Loading:
              return Center(child: CircularProgressIndicator());
            case ApiStatus.Failed:
              return Text(state.message);
            default:
              return ListView(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          context.read<PostsBloc>().add(PostFetched());
                        },
                        icon: Icon(Icons.refresh),
                      ),
                      Text('${state.timeTaken} sec')
                    ],
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.postList.length,
                    itemBuilder: (context,index){
                      final item = state.postList[index];
                      return ListTile(
                        title: Text(item.email.toString()),
                        subtitle: Text(item.body.toString()),
                      );
                    },
                  ),
                ],
              );

          }

        },
      ),
    );
  }
}
