import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/register/register_cubit.dart';
import '../../cubit/register/register_state.dart';
import '../../helpers/constant.dart';
import 'otp_register.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscurePassword = true;
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  // TextEditingController _username = new TextEditingController();
  final TextEditingController _identitas = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordconfirm = TextEditingController();

  final registerCubit = RegisterCubit();

  void clearText() {
    _fullname.clear();
    _email.clear();
    _identitas.clear();
    _phone.clear();
    _password.clear();
    _passwordconfirm.clear();
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
            return 'Nama harus diisi';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Full Name",
          labelText: "Full Name",
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          fillColor: Colors.white,
        ));
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Email Address",
          labelText: "Email Address",
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: const Icon(Icons.email),
            onPressed: () {},
          )),
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      controller: _phone,
      keyboardType: TextInputType.phone,
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone harus diisi';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Phone",
          labelText: "Phone",
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
          )),
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _password,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isObscurePassword,
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password harus diisi';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscurePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscurePassword = !_isObscurePassword;
            });
          },
        ),
      ),
    );
  }

  
  Widget _buildButtonRegister() {
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
              var name = _fullname.text.trim();
              var email = _email.text.trim();
              var password = _password.text.trim();
              var phone = _phone.text.trim();

              registerCubit.register(name, email, password,
                  phone);
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning'),
                        content: const Text(
                            'Silahkan Lengkapi data terlebih dahulu'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }
          },
          child: Text("Sign Up".toUpperCase(),
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
      body: BlocProvider<RegisterCubit>(
        create: (context) => registerCubit,
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is FailureRegisterState) {
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
            } else if (state is SuccessRegisterState) {
              var email = _email.text.trim();

              clearText();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpRegister(email: email.toString()),
                ),
              );
              // showDialog<String>(
              //     context: context,
              //     builder: (BuildContext context) => AlertDialog(
              //           title: const Text('Success'),
              //           content:
              //               const Text('Selamat, Registrasi anda berhasil'),
              //           actions: <Widget>[
              //             TextButton(
              //               onPressed: () => Navigator.pop(context, 'OK'),
              //               child: const Text('OK'),
              //             ),
              //           ],
              //         ));
            }
          },
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Form(
                  key: formState,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 48.0,
                          ),
                          _buildLogo(),
                          const SizedBox(
                            height: 30,
                          ),
                          _buildFullName(),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildEmail(),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildPhone(),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildPassword(),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildButtonRegister(),
                          const SizedBox(
                            height: 40,
                          ),
                          _buildSigninLabel()
                        ],
                      )),
                ),
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                if (state is LoadingRegisterState) {
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
    ));
  }
}
