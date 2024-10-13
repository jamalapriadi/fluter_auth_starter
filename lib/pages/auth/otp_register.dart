import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../cubit/otp/verifikasi_otp_cubit.dart';
import '../../cubit/otp/verifikasi_otp_state.dart';
import '../../helpers/constant.dart';

// ignore: must_be_immutable
class OtpRegister extends StatefulWidget {
  // const OtpRegister({Key? key}) : super(key: key);

  String email;
  OtpRegister({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _OtpRegisterState createState() => _OtpRegisterState();
}

class _OtpRegisterState extends State<OtpRegister> {
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();

  final verifikasiOtpCubit = VerifikasiOtpCubit();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldState,
      resizeToAvoidBottomInset: false,
      backgroundColor: Warna.putih,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider<VerifikasiOtpCubit>(
        create: (context) => verifikasiOtpCubit,
        child: BlocListener<VerifikasiOtpCubit, VerifikasiOtpState>(
          listener: (context, state) {
            if (state is FailureVerifikasiOtpState) {
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
            } else if (state is SuccessVerifikasiOtpState) {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Success'),
                        content:
                            const Text('Selamat, Registrasi anda berhasil'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, "/login"),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 68.0,
                      ),
                      const Text(
                        'Verification OTP',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          'Silahkan masukkan kode OTP',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Yang sudah dikirim melalui Email anda!',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PinCodeTextField(
                            appContext: context,
                            backgroundColor: Colors.white,
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 3) {
                                return "Silahkan lengkapi kode OTP";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    verifikasiOtpCubit.verifikasi(
                                        widget.email.toString(),
                                        v.toString());
                                    return Container();

                                  });
                            },
                            onChanged: (value) {
                              debugPrint(value);
                              
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        child: Text(
                          "Signin",
                          style: TextStyle(
                              color: Warna.kuning,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                      )
                    ],
                  ),
                ),
              ),
              BlocBuilder<VerifikasiOtpCubit, VerifikasiOtpState>(
                builder: (context, state) {
                  if (state is LoadingVerifikasiOtpState) {
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
      ),
      ),
    ));
  }
}
