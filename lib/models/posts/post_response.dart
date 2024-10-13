
import 'dart:convert';

// import 'package:ortan_parent/models/media/media_response.dart';

class PostResponse {
  String? id;
  String? slug;
  String? title;
  String? teaser;
  String? description;
  String? featuredImage;
  String? postType;
  String? createdAtHuman;
  String? updatedAtHuman;
  // MediaResponse? media;

  PostResponse({
    this.id,
    this.slug,
    this.title,
    this.teaser,
    this.description,
    this.featuredImage,
    this.postType,
    this.createdAtHuman,
    this.updatedAtHuman,
  });

  factory PostResponse.fromJson(Map<String,dynamic> json) => 
    PostResponse(
      id: json["id"],
      slug: json["slug"],
      title: json["title"],
      teaser: json["teaser"],
      description: json["description"],
      featuredImage: json["featured_image"],
      postType: json["post_type"],
      createdAtHuman: json["created_at_human"],
      updatedAtHuman: json["updated_at_human"],
    );
}

List<PostResponse> postResponseFromJson(String str){
  final data = json.decode(str);

  return List<PostResponse>.from(
    data["data"].map((item) => PostResponse.fromJson(item))
  );
}

PostResponse postSingleResponseFromJson(String str){
  final data = json.decode(str);

  return PostResponse.fromJson(data["data"]);
}