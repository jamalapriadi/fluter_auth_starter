import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../helpers/cache_const.dart';
import '../helpers/cache_storage.dart';
import '../helpers/http_request.dart';
import '../models/login/login_request.dart';
import '../models/login/login_response.dart';
import '../models/otp/verifikasi_otp_request.dart';
import '../models/otp/verifikasi_otp_response.dart';
import '../models/password/password_request.dart';
import '../models/password/password_response.dart';
import '../models/profile/update_password_request.dart';
import '../models/profile/update_password_response.dart';
import '../models/profile/update_profile_request.dart';
import '../models/profile/update_profile_response.dart';
import '../models/register/register_request.dart';
import '../models/register/register_response.dart';
import '../models/user/profile_response.dart';

class GuestRepository {
  final network = Network();
  final env = dotenv.load(fileName: ".env");

  Future<LoginSuccessResponse> login(LoginRequest request) async {
    var url = "/login";

    final response =
        await network.postRequestWithoutToken(url, request.toJson());

    return loginSuccessResponseFromJson(response.body);
  }

  Future<PasswordResponse> forgot(PasswordRequest request) async {
    var url = "/password/forgot";

    final response =
        await network.postRequestWithoutToken(url, request.toJson());

    return passwordResponseFromJson(response.body);
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    var url = "/registrasi";

    final response =
        await network.postRequestWithoutToken(url, request.toJson());

    return registerResponseFromJson(response.body);
  }

  Future<VerifikasiOtpResponse> konfirmasiOtp(
      VerifikasiOtpRequest request) async {
    var url = "/verifikasi-otp";

    final response =
        await network.postRequestWithoutToken(url, request.toJson());

    return verifikasiOtpResponseFromJson(response.body);
  }

  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest request) async {
    var url = "/auth/update-info";

    final response = await network.postRequestForm(url, request.toJson());

    return updateProfileResponse(response.body);
  }

  Future<UpdatePasswordResponse> updatePassword(
      UpdatePasswordRequest request) async {
    var url = "/auth/change-password";

    final response = await network.postRequestForm(url, request.toJson());

    return updatePasswordResponse(response.body);
  }

  Future<ProfileResponse> me() async {
    var url = "/auth/me";

    final response = await network.getRequest(url);

    if (response.statusCode == 200) {
      return profileResponseFromJson(response.body);
    } else {
      return profileResponseFromJsonFailed(response.body);
    }
  }

  Future<bool> checkLoginStatus(bool successStatus) async {
    return await Cache.setCacheBool(key: 'isLogin', data: successStatus);
  }

  Future<bool> updateLoggedInStatus(String accessToken) async {
    return await Cache.setCache(key: cacheTokenId, data: accessToken);
  }

  Future<bool> updateName(String name) async {
    return await Cache.setCache(key: cacheName, data: name);
  }

  Future<bool> updateEmail(String email) async {
    return await Cache.setCache(key: cacheEmail, data: email);
  }

  Future<String> getUpdateName() async {
    return await Cache.getCache(key: cacheName);
  }

  Future<dynamic> isSignedIn() async {
    return await Cache.getCacheBool(key: 'isLogin') == null
        ? false
        : Cache.getCacheBool(key: 'isLogin');
  }

  Future<bool> signOut() async {
    await Cache.setCache(key: cacheTokenId, data: '');
    await Cache.setCacheBool(key: 'isLogin', data: false);
    return await Cache.removeCache(key: cacheTokenId);
  }

  Future<bool> cekIsLogin() async {
    if (await Cache.getCacheBool(key: 'isLogin') == null) {
      return false;
    } else {
      return await Cache.getCacheBool(key: 'isLogin');
    }
  }
}
