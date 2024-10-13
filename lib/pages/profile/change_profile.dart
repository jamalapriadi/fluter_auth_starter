import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/profile/update_profile_cubit.dart';
import '../../cubit/profile/update_profile_state.dart';
import '../../helpers/constant.dart';
import '../../models/profile/update_profile_request.dart';
import '../../models/user/profile_response.dart';
import '../components/button_widget.dart';
import '../components/text_form_default_widget.dart';
import '../components/text_form_field_widget.dart';

// ignore: must_be_immutable
class ChangeProfile extends StatefulWidget {
  ProfileResponse me;

  ChangeProfile({super.key, required this.me});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

Widget _buildAppBar(){
  return AppBar(
    centerTitle: true,
    backgroundColor: Warna.kuning,
    title: const Text('UPDATE PROFILE', style: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 24
    ),),
  );
}

class _ChangeProfileState extends State<ChangeProfile> {
  final formState = GlobalKey<FormState>();
  final _profileCubit = UpdateProfileCubit();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    _email.text = widget.me.email.toString();
    _name.text = widget.me.name.toString();
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
        body: BlocProvider<UpdateProfileCubit>(
          create: (context) => _profileCubit,
          child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
            listener: (context, state){
              if(state is SuccessUpdateProfileState){
                if(state.listProfile.success == true){
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Success'),
                        content: Text(state.listProfile.message.toString()),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }else{
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Warning'),
                      content: Text(state.listProfile.message.toString()),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ));
            }
              }
            },
            child: Stack(
              children: [
                Form(
                    key: formState,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            _buildEmail(),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildName(),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildButtonChangeProfile()
                          ],
                        ),
                      ),
                    ),
                  ),
                BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                  builder: (context, state){
                    if(state is LoadingUpdateProfileState){
                      return Container(
                        color: Colors.black.withOpacity(.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }else{
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormFieldWdiget(
        hintText: "Email",
        focusNode: _emailFocus,
        textInputType: TextInputType.text,
        controller: _email,
        functionValidate: commonValidation,
        parametersValidate: "Please enter Email",
        onSubmitField: () {
          changeFocus(context, _emailFocus, _nameFocus);
        },
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.email));
  }

  Widget _buildName() {
    return TextFormDefaultWidget(
      hintText: "Name",
      focusNode: _nameFocus,
      textInputType: TextInputType.text,
      controller: _name,
      functionValidate: commonValidation,
      parametersValidate: "Please enter Full Name",
      onSubmitField: () {},
      onFieldTab: () {},
    );
  }

  Widget _buildButtonChangeProfile() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            if (formState.currentState!.validate()) {
              var email = _email.text.trim();
              var name = _name.text.trim();

              UpdateProfileRequest request =
                  UpdateProfileRequest(name: name, email: email);

              _profileCubit.updateProfile(request);
            }
          },
          text: "Update Profile",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.kuning),
    );
  }
}