import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/home/home_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/custom_loader.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  final String email;
  OtpScreen({super.key, required this.email});
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthVerifiedState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HomePage(),
                ),
                (route) => false);
          }
          if (state is AuthStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PinCodeTextField(
                    controller: otp,
                    appContext: context,
                    length: 5,
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(VerifyOtpEvent(otp: otp.text, email: email));
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
              if (state is AuthStateLoading) const CustomLoader(),
            ],
          );
        },
      ),
    ));
  }
}
