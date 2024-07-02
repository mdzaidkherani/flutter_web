import 'package:bloc_test/bloc/posts/posts_bloc.dart';
import 'package:bloc_test/bloc/posts/posts_events.dart';
import 'package:bloc_test/bloc/posts/posts_states.dart';
import 'package:bloc_test/bloc/users/users_bloc.dart';
import 'package:bloc_test/bloc/users/users_event.dart';
import 'package:bloc_test/bloc/users/users_state.dart';
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
    context.read<UsersBloc>().add(UsersFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc,UsersStates>(
        builder: (context,userState){
          return BlocBuilder<PostsBloc,PostsStates>(
            builder: (context,state){
              // print(state.postList.length);
              if(state.apiStatus == ApiStatus.Loading || userState.apiStatus == ApiStatus.Loading){
                return const Center(child: CircularProgressIndicator());
              }else{
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(state.apiStatus == ApiStatus.Failed)Text(state.message)
                          else Flexible(
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: (){
                                            context.read<PostsBloc>().add(PostRefresh());
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
                                ),
                                if(state.apiStatus == ApiStatus.Refresh)SizedBox(height: MediaQuery.of(context).size.height/2,child: Center(child: CircularProgressIndicator(),))
                              ],
                            ),
                          ),
                          if(userState.apiStatus == ApiStatus.Failed)Text(userState.message)
                          else Flexible(
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: (){
                                            context.read<UsersBloc>().add(UsersRefresh());
                                          },
                                          icon: Icon(Icons.refresh),
                                        ),
                                        Text('${userState.timeTaken} sec')
                                      ],
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: userState.postList.length,
                                      itemBuilder: (context,index){
                                        final item = userState.postList[index];
                                        return ListTile(
                                          title: Text(item.email.toString()),
                                          subtitle: Text(item.name.toString()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                if(userState.apiStatus == ApiStatus.Refresh)SizedBox(height: MediaQuery.of(context).size.height/2,child: Center(child: CircularProgressIndicator(),))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      ),
    );
  }
}
