import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/password/password_cubit.dart';
import '../../cubit/password/password_state.dart';
import '../../helpers/constant.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();

  final TextEditingController _fullname = TextEditingController();

  final passwordCubit = PasswordCubit();

  Widget _buildLogo() {
    return Center(
        child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset("assets/img/logo.png"),
    ));
  }

  Widget _buildFullName() {
    return TextFormField(
        controller: _fullname,
        keyboardType: TextInputType.text,
        autofocus: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email harus diisi';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Masukkan Email",
          labelText: "Masukkan Email",
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          fillColor: Colors.white,
        ));
  }

  Widget _buildButtonSendLink() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Warna.hitam),
              backgroundColor: WidgetStateProperty.all<Color>(Warna.kuning),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Warna.kuning)))),
          onPressed: () {
            if (formState.currentState!.validate()) {
              var username = _fullname.text.trim();

              passwordCubit.forgotPassword(username);
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content:
                            const Text('Silahkan isi username atau email anda'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }
          },
          child: Text("Reset Password".toUpperCase(),
              style: const TextStyle(fontSize: 14))),
    );
  }

  Widget _buildSigninLabel() {
    return Column(
      children: <Widget>[
        Text(
          "Already have an account?",
          textAlign: TextAlign.center,
          style: TextStyle(color: Warna.hitam, fontSize: 14),
        ),
        TextButton(
          child: Text(
            "Signin",
            style: TextStyle(
                color: Warna.kuning, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/login");
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
        backgroundColor: Warna.putih,
        body: BlocProvider<PasswordCubit>(
          create: (context) => passwordCubit,
          child: BlocListener<PasswordCubit, PasswordState>(
            listener: (context, state) {
              if (state is FailurePasswordState) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Warning'),
                          content: Text(state.errorMessage),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              } else if (state is SuccessPasswordState) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text(
                              'Password anda telah berhasil dikirim ke email anda, silahkan cek!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              }
            },
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Form(
                    key: formState,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 90),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 48,
                          ),
                          _buildLogo(),
                          const SizedBox(
                            height: 40,
                          ),
                          _buildFullName(),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildButtonSendLink(),
                          const SizedBox(
                            height: 90,
                          ),
                          _buildSigninLabel()
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<PasswordCubit, PasswordState>(
                    builder: (context, state) {
                  if (state is LoadingPasswordState) {
                    return Container(
                      color: Colors.black.withOpacity(.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
