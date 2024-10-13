

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/post/post_state.dart';

import '../../repositories/post_repository.dart';

class PostCubit extends Cubit<PostState>{
  PostCubit() : super(InitialPostState());

  PostRepository postRepository = PostRepository();

  void getData() async{
    emit(LoadingPostState());

    postRepository.lists()
      .then((resp){
        emit(SuccessPostState(resp));
      });
  }

  void show(String id) async{
    emit(LoadingPostState());

    postRepository.show(id)
      .then((resp){
        emit(SuccessSinglePostState(resp));
      });
  }
}