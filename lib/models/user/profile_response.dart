import 'dart:convert';

class ProfileResponse {
  bool? succes;
  String? id;
  String? name;
  String? email;
  String? identitas;
  String? profilePicture;
  String? desc;
  int? point;
  String? active;
  int? totalItem;

  ProfileResponse(
      {this.succes,
      this.id,
      this.name,
      this.email,
      this.profilePicture,
      this.active,
      this.totalItem});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
          succes: true,
          id: json["data"]["id"],
          name: json["data"]["name"],
          email: json["data"]["email"],
          profilePicture: json["data"]["profile_picture"],
          active: json["data"]["active"],
          totalItem: json["data"]["total_item"]);

  factory ProfileResponse.fromJsonFailed(Map<String, dynamic> json) =>
      ProfileResponse(
          succes: false,
          id: '',
          name: '',
          email: '',
          profilePicture: '',
          active: '',
          totalItem: 0);
}

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

ProfileResponse profileResponseFromJsonFailed(String str) =>
    ProfileResponse.fromJsonFailed(json.decode(str));
