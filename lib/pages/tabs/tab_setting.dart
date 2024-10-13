import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/profile/profile_cubit.dart';
import '../../cubit/profile/profile_state.dart';
import '../../helpers/constant.dart';
import '../../models/user/profile_response.dart';
import '../../repositories/guest_repository.dart';
import '../profile/change_password.dart';
import '../profile/change_profile.dart';

class TabSetting extends StatefulWidget {
  const TabSetting({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabSettingState createState() => _TabSettingState();
}

class _TabSettingState extends State<TabSetting> {
  final profileCubit = ProfileCubit();

  late ProfileResponse detailProfile = ProfileResponse();
  GuestRepository guestRepository = GuestRepository();

  @override
  void initState() {
    profileCubit.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.kuning,
        title: const Center(
              child: Text('PROFILE', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
      ),
      body: BlocProvider<ProfileCubit>(
        create: (context) => profileCubit,
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is FailureProfileState) {
            } else if (state is SuccessProfileState) {}
          },
          child: Column(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is SuccessProfileState) {
                    var lprofile = state.listProfile;
                    detailProfile = state.listProfile;

                    return Column(
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Warna.kuning, Colors.yellow])),
                            child: SizedBox(
                              width: double.infinity,
                              height: 250.0,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 50.0,
                                      backgroundColor: Colors.white,
                                      child: Image(
                                        image: CachedNetworkImageProvider(
                                          lprofile.profilePicture.toString(),
                                        ),
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
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      lprofile.name.toString(),
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      lprofile.email.toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            child: ListTile(
                              trailing: const Icon(Icons.arrow_right),
                              title: const Text("CHANGE PROFILE "),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangeProfile(
                                        me: detailProfile), fullscreenDialog: true,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            child: ListTile(
                              trailing: const Icon(Icons.arrow_right),
                              title: const Text("CHANGE PASSWORD "),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  const ChangePassword(), fullscreenDialog: true));
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is LoadingProfileState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                  style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Warna.hitam),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Warna.kuning),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: Warna.kuning)))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm Logout'),
                          content: const Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); 

                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                guestRepository.signOut();
                                
                                Navigator.pushReplacementNamed(context, "/login");
                                // Perform your desired action here
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('LOGOUT'),
                ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void logout() async {
    // showLoaderDialog(context);
    // var res = await Network().logout('/auth/logout');
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // localStorage.remove('check');
    // localStorage.remove('accessToken');
    // localStorage.remove('tokenType');
    await guestRepository.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/login");
  }
}
