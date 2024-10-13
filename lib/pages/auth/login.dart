import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pages/auth/otp_register.dart';

import '../../cubit/login/login_cubit.dart';
import '../../cubit/login/login_state.dart';
import '../../helpers/constant.dart';
import '../home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final loginCubit = LoginCubit();

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

  Widget _buildTextFieldEmail() {
    return TextFormField(
      controller: controllerUsername,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Email",
        labelText: "Email",
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: const Icon(Icons.email),
          onPressed: () {},
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return TextFormField(
      obscureText: _isObscure,
      controller: controllerPassword,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buildButtonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Warna.putih),
              backgroundColor: WidgetStateProperty.all<Color>(Warna.kuning),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Warna.kuning)))),
          onPressed: () {
            if (formState.currentState!.validate()) {
              var username = controllerUsername.text.trim();
              var password = controllerPassword.text.trim();

              loginCubit.login(username, password);
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content: const Text(
                            'Silahkan isi username dan password anda'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }
          },
          child:
              Text("Login".toUpperCase(), style: const TextStyle(fontSize: 14))),
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          "Forgot Passoword?",
          style: TextStyle(color: Warna.hitam),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/password");
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
        backgroundColor: Warna.putih,
        body: BlocProvider<LoginCubit>(
          create: (context) => loginCubit,
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is FailureLoginState) {
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
              } else if (state is SuccessLoginState) {
                var lhasil = state;
                var lstatus = lhasil.status.toString();
                var lemail = controllerUsername.text.trim();

                if (lstatus == '0') {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OtpRegister(email: lemail.toString())));

                  
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                }
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
                            height: 48.0,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 48.0,
                            child: Image.asset("assets/img/logo.png"),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          _buildTextFieldEmail(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          _buildTextFieldPassword(),
                          _buildForgotPassword(),
                          _buildButtonLogin(),
                          const SizedBox(
                            height: 30.0,
                          ),
                          _buildSignupLabel()
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoadingLoginState) {
                      return Container(
                        color: Colors.black.withOpacity(.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        )),
        onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Pop Screen Disabled. You cannot go to previous screen.'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      },
    );
  }

  Widget _buildSignupLabel() {
    return Column(
      children: <Widget>[
        Text(
          "Don't Have Account?",
          textAlign: TextAlign.center,
          style: TextStyle(color: Warna.hitam, fontSize: 14),
        ),
        TextButton(
          child: Text(
            "Signup",
            style: TextStyle(
                color: Warna.kuning, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/register");
          },
        )
      ],
    );
  }
}
