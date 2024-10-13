import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/profile/update_password_cubit.dart';
import '../../cubit/profile/update_password_state.dart';
import '../../helpers/constant.dart';
import '../components/button_widget.dart';
import '../components/loading_widget.dart';
import '../components/password_form_field_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _updatePasswordCubit = UpdatePasswordCubit();

  final formState = GlobalKey<FormState>();

  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  final FocusNode _oldPasswordFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

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
        body: _buildForgotPasswordForm(),
      ),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      centerTitle: true,
      backgroundColor: Warna.kuning,
      title: const Text('PASSWORD', style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),),
    );
  }

  Widget _buildForgotPasswordForm(){
    return BlocProvider<UpdatePasswordCubit>(
      create: (context) => _updatePasswordCubit,
      child: BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
        listener: (context, state){
          if(state is LoadingUpdatePasswordState){
            Container(
              color: Warna.putih,
              height: 400,
              child: const LoadingWidget(),
            );
          }else if(state is SuccessUpdatePasswordState){
            if(state.listPassword.success == true){
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Success'),
                        content: Text(state.listPassword.message.toString()),
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
                      content: Text(state.listPassword.message.toString()),
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
          children: <Widget>[
            SingleChildScrollView(
              child: Form(
                key: formState,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        _buildOldPassword(),
                        const SizedBox(height: 10),
                        _buildPassword(),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildPasswordConfirm(),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildButtonUpdateProfile()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
              builder: (context, state){
                if(state is LoadingUpdatePasswordState){
                  return Container(
                    color: Colors.black.withOpacity(.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }else{
                  return Container();
                }
              } 
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOldPassword() {
    return PasswordFormFieldWdiget(
        obscureText: true,
        hintText: "Old Password",
        focusNode: _oldPasswordFocus,
        textInputType: TextInputType.text,
        controller: _oldPassword,
        functionValidate: commonValidationPassword,
        parametersValidate: "Please enter Old Password",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.remove_red_eye));
  }

  Widget _buildPassword() {
    return PasswordFormFieldWdiget(
        obscureText: true,
        hintText: "New Password",
        focusNode: _passwordFocus,
        textInputType: TextInputType.text,
        controller: _password,
        functionValidate: commonValidationPassword,
        parametersValidate: "Please enter New Password",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.remove_red_eye));
  }

  Widget _buildPasswordConfirm() {
    return PasswordFormFieldWdiget(
        obscureText: true,
        hintText: "Password Confirmation",
        focusNode: _passwordConfirmFocus,
        textInputType: TextInputType.text,
        controller: _passwordConfirm,
        functionValidate: commonValidationPassword,
        parametersValidate: "Please enter Password Confirmation",
        onSubmitField: () {},
        onFieldTab: () {},
        prefixIcon: const Icon(Icons.remove_red_eye));
  }

  Widget _buildButtonUpdateProfile() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: elevatedButton(
          onPresses: () {
            if (formState.currentState!.validate()) {
              var current = _oldPassword.text.trim();
              var password = _password.text.trim();
              var passwordConfirm = _passwordConfirm.text.trim();

              _updatePasswordCubit.updatePassword(current, password, passwordConfirm);
            }
          },
          text: "UPDATE",
          winWidth: 14,
          height: 21,
          textSize: 18,
          color: Warna.kuning),
    );
  }
}