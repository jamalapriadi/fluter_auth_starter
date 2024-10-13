import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pages/auth/login.dart';
import '../../pages/components/loading_widget.dart';
import '../../pages/home.dart';

import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  final loginCubit = LoginCubit();

  @override
  void initState() {
    loginCubit.checkIfLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => loginCubit,
      child: BlocListener<LoginCubit, LoginState>(listener: (context, state) {
        if (state is FailureLoginState) {
        } else if (state is SuccessLoginState) {}
      }, child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is FailureLoginState) {
            return const Login();
          } else if (state is CekLoginStatusState) {
            return const LoadingWidget();
          } else if (state is AvailableAuthState) {
            return const Home();
          } else {
            return const Login();
          }
        },
      )),
    );
  }
}
