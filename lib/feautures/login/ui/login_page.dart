import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshflow_test/app/app_keys.dart';
import 'package:freshflow_test/app/navigation/page_navigation_keys.dart';
import 'package:freshflow_test/app/resources/colors.dart';
import 'package:freshflow_test/feautures/login/data/login_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _loginForm = GlobalKey<FormBuilderState>();

  bool _isPasswordVisible = false;

  Future<void> submitForm() async {
    String email = _loginForm.currentState!.value['email'];
    String password = _loginForm.currentState!.value['password'];

    BlocProvider.of<LoginCubit>(context).signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      key: const Key(LoginPageKey.loginPage),
      body: BlocConsumer<LoginCubit, LoginBlocState>(
        listener: (context, state) {
          if (state.isLoggedIn) {
            Navigator.of(context)
                .pushReplacementNamed(PageNavigationKeys.cartRoute);
          }
          if (state.hasError) {
            final snackbar = SnackBar(
              content: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'login failed',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              backgroundColor: theme.colorScheme.onError,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        builder: (context, state) => Container(
          height: double.infinity,
          padding: const EdgeInsets.all(24),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  FormBuilder(
                    key: _loginForm,
                    child: Column(
                      children: <Widget>[
                        FormBuilderField(
                          key: const Key(LoginPageKey.email),
                          name: 'email',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context)
                          ]),
                          builder: (FormFieldState<String?> field) => TextField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.neutral700),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: theme.colorScheme.secondary,
                              ),
                              labelText: 'email',
                              labelStyle:
                                  const TextStyle(color: AppColors.neutral700),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: theme.colorScheme.onError,
                                      width: 2)),
                            ),
                            style: const TextStyle(color: AppColors.neutral700),
                            onChanged: (val) => field.didChange(val),
                          ),
                        ),
                        const SizedBox(height: 24),
                        FormBuilderField(
                            key: const Key(LoginPageKey.password),
                            name: 'password',
                            validator: FormBuilderValidators.required(context),
                            builder: (FormFieldState<String?> field) =>
                                TextField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.neutral700),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.colorScheme.secondary,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.colorScheme.secondary,
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: theme.colorScheme.secondary,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.remove_red_eye
                                            : Icons.visibility_off,
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ),
                                    labelText: 'password',
                                    labelStyle: const TextStyle(
                                        color: AppColors.neutral700),
                                  ),
                                  style: const TextStyle(
                                      color: AppColors.neutral700),
                                  obscureText: !_isPasswordVisible,
                                  onChanged: (val) => field.didChange(val),
                                )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      key: const Key(LoginPageKey.pressLogIn),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5)),
                      height: 64,
                      color: theme.colorScheme.secondary,
                      disabledColor: AppColors.secondary300,
                      onPressed: state.isLoggedIn
                          ? null
                          : () async {
                              if (_loginForm.currentState!.saveAndValidate()) {
                                await submitForm();
                              }
                            },
                      child: !state.isLoggedIn
                          ? const Text(
                              'Login',
                              style: TextStyle(fontSize: 18),
                            )
                          : SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.primaryColor),
                                strokeWidth: 3,
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
