import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ropstem_task/blocs/bloc.dart';
import 'package:ropstem_task/configs/config.dart';
import 'package:ropstem_task/utils/utils.dart';
import 'package:ropstem_task/widgets/widget.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _textEmailController = TextEditingController();
  final _textPassController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPass = FocusNode();

  bool _showPassword = false;
  String? _errorEmail;
  String? _errorPass;

  @override
  void initState() {
    // _textEmailController.text  = 'zohaib2@gmail.com';
    // _textPassController.text  = '12345';
    super.initState();
  }

  @override
  void dispose() {
    _textEmailController.dispose();
    _textPassController.dispose();
    _focusEmail.dispose();
    _focusPass.dispose();
    super.dispose();
  }

  ///On navigate sign up
  void _signUp() {
    Navigator.pushNamed(context, Routes.signUp);
  }

  ///On login
  void _login() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _errorEmail = UtilValidator.validate(_textEmailController.text,type: ValidateType.email);
      _errorPass = UtilValidator.validate(_textPassController.text);
    });
    if (_errorEmail == null && _errorPass == null) {
      AppBloc.loginCubit.onLogin(
        username: _textEmailController.text,
        password: _textPassController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, login) {
          if (login == LoginState.success) {
           Navigator.pushReplacementNamed(context, Routes.dashboard);
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ///Email
                  AppTextInput(
                    hintText: 'email',
                    errorText: _errorEmail,
                    controller: _textEmailController,
                    focusNode: _focusEmail,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      setState(() {
                        _errorEmail = UtilValidator.validate(
                          _textEmailController.text,
                          type: ValidateType.email,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(context, _focusEmail, _focusPass);
                    },
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _textEmailController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ///Password
                  AppTextInput(
                    hintText: 'password',
                    errorText: _errorPass,
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {
                      setState(() {
                        _errorPass = UtilValidator.validate(
                          _textPassController.text,
                        );
                      });
                    },
                    onSubmitted: (text) {
                      _login();
                    },
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    obscureText: !_showPassword,
                    controller: _textPassController,
                    focusNode: _focusPass,
                  ),
                  const SizedBox(height: 16),
                  ///Button
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, login) {
                      return AppButton(
                       'LogIn',
                        mainAxisSize: MainAxisSize.max,
                        onPressed: _login,
                        loading: login == LoginState.loading,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  ///SignUp
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Don\'t have an account yet?',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.bold,color: Colors.grey),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: AppButton(
                      'Sign Up',
                      onPressed: _signUp,
                      type: ButtonType.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
