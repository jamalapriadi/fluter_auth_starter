
import 'package:equatable/equatable.dart';
import '../../models/default_response.dart';

import '../../models/posts/post_response.dart';

abstract class PostState extends Equatable{
  @override
  List<Object> get props=>[];
}

class InitialPostState extends PostState{}

class LoadingPostState extends PostState{}

class FailurePostState extends PostState{
  final DefaultResponse resp;

  FailurePostState(this.resp);

  @override
  List<Object> get props => [resp];

  @override
  String toString(){
    return 'FailurePostState{resp:$resp}';
  }
}

class SuccessPostState extends PostState{
  final List<PostResponse> lists;

  SuccessPostState(this.lists);

  @override
  List<Object> get props => [lists];
}

class SuccessSinglePostState extends PostState{
  final PostResponse list;

  SuccessSinglePostState(this.list);

  @override
  List<Object> get props => [list];
}