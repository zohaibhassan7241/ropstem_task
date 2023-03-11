import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ropstem_task/blocs/bloc.dart';
import 'package:ropstem_task/models/model.dart';
import 'package:ropstem_task/services/car_database.dart';
import 'package:ropstem_task/utils/utils.dart';
import 'package:ropstem_task/widgets/widget.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _textNameController = TextEditingController();
  final _textPassController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _focusName = FocusNode();
  final _focusPass = FocusNode();
  final _focusEmail = FocusNode();

  bool _showPassword = false;
  String? _errorID;
  String? _errorPass;
  String? _errorEmail;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textNameController.dispose();
    _textPassController.dispose();
    _textEmailController.dispose();
    _focusName.dispose();
    _focusPass.dispose();
    _focusEmail.dispose();
    super.dispose();
  }

  ///On sign up
  void _signUp() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _errorID = UtilValidator.validate(_textNameController.text);
      _errorPass = UtilValidator.validate(_textPassController.text);
      _errorEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
    });
    if (_errorID == null && _errorPass == null && _errorEmail == null) {
      final result = await AppBloc.userCubit.onRegister(
        userModel: UserModel(id: uuid.v1(),
            name: _textNameController.text, email: _textEmailController.text, password: _textPassController.text),
      );
      if (result) {
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }
  ///On navigate Login
  void _login() {
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 40),
                ///Username
                Text(
                  'UserName',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: 'Enter your username',
                  errorText: _errorID,
                  controller: _textNameController,
                  focusNode: _focusName,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorID = UtilValidator.validate(_textNameController.text);
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(context, _focusName, _focusPass);
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textNameController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                ),
                const SizedBox(height: 16),
                ///Email
                Text(
                  'Email',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: 'Enter your email',
                  errorText: _errorEmail,
                  focusNode: _focusEmail,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textEmailController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusEmail,
                      _focusPass,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorEmail = UtilValidator.validate(
                        _textEmailController.text,
                        type: ValidateType.email,
                      );
                    });
                  },
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                ///Password
                Text(
                  'Password',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText:
                  'Enter your password',
                  errorText: _errorPass,
                  onChanged: (text) {
                    setState(() {
                      _errorPass = UtilValidator.validate(
                        _textPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    _signUp();
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
                ///Button SignUp
                AppButton(
                  'Sign Up',
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _signUp,
                ),
                const SizedBox(height: 30),
                ///Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.bold,color: Colors.grey),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: AppButton(
                        'Login',
                        onPressed: _login,
                        type: ButtonType.text,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
