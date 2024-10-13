import '../helpers/http_request.dart';
import '../models/posts/post_response.dart';

class PostRepository {
  final network = Network();

  Future<List<PostResponse>> lists() async{
    var url = "/auth/posts";

    final response = await network.getRequest(url);

    return postResponseFromJson(response.body);
  }

  Future<PostResponse> show(id) async{
    var url = "/auth/post/$id";

    final response = await network.getRequest(url);

    return postSingleResponseFromJson(response.body); 
  }
}