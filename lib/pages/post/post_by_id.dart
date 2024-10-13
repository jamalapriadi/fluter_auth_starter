import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../cubit/post/post_cubit.dart';
import '../../cubit/post/post_state.dart';
import '../../helpers/constant.dart';
import '../../models/posts/post_response.dart';

// ignore: must_be_immutable
class PostById extends StatefulWidget {
  String? postId;

  PostById({super.key, this.postId});

  @override
  State<PostById> createState() => _PostByIdState();
}

Widget _buildAppBar(){
  return AppBar(
    centerTitle: true,
    backgroundColor: Warna.kuning,
    title: Text('NEWS', style: TextStyle(
      color: Warna.hitam,
      fontWeight: FontWeight.bold,
      fontSize: 24
    ),),
  );
}

class _PostByIdState extends State<PostById> {
  final postCubit = PostCubit();

  @override
  void initState(){
    postCubit.show(widget.postId.toString());

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Warna.kuning,
          automaticallyImplyLeading: false,
          flexibleSpace: _buildAppBar(),
        ),
        body: Container(
          color: Warna.putih,
          child: _buildSinglePost(),
        ),
      ),
    );
  }

  Widget _buildSinglePost(){
    return BlocProvider<PostCubit>(
      create: (context) => postCubit,
      child: BlocListener<PostCubit, PostState>(
        listener: (context, state){

        },
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state){
            if(state is LoadingPostState){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container( // placeholder layout
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else if(state is SuccessSinglePostState){
              PostResponse post = state.list;

              return _buildPost(post);
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPost(PostResponse post){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.network(post.featuredImage.toString(),
              fit: BoxFit.cover,
              loadingBuilder: (context, imageProvider, loadingProgress) {
                if (loadingProgress == null) return imageProvider;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, trace) {
                return const Center(child: Icon(Icons.image));
              },
            
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20,left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    post.title.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(post.createdAtHuman.toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),),
                ),

                const SizedBox(height: 15,),
                Align(
                  alignment: Alignment.topLeft,
                  child: HtmlWidget(post.description.toString()),
                ),

                const SizedBox(height: 50,),
              ],
            ),
          )
        ],
      ),
    );
  }
}