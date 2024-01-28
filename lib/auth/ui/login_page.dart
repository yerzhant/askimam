import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc bloc;

  const LoginPage(this.bloc, {Key? key}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _login = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _login.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        backgroundColor: primaryLightColor,
        body: Form(
          key: _form,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(basePadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.asset(
                        'assets/images/logo.png',
                        color: primaryColor,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 70),
                    TextFormField(
                      controller: _login,
                      decoration: const InputDecoration(
                        labelText: 'Логин',
                        prefixIcon: Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите логин';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: interElementMargin),
                    TextFormField(
                      controller: _password,
                      decoration: const InputDecoration(
                        labelText: 'Пароль',
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: primaryColor,
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите пароль';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: interElementMargin * 2),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        switch (state) {
                          case AuthStateAuthenticated():
                            Modular.to.pop();

                          case AuthStateError(rejection: final rejection):
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(rejection.message)),
                            );

                          default:
                        }
                      },
                      builder: (context, state) {
                        return WideButton(
                          'ВОЙТИ',
                          () {
                            if (_form.currentState!.validate()) {
                              widget.bloc.add(AuthEventLogin(
                                _login.text,
                                _password.text,
                              ));
                            }
                          },
                          isInProgress: switch (state) {
                            AuthStateInProgress() => true,
                            _ => false,
                          },
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () =>
                              launchUrlString('https://azan.kz/signup'),
                          child: const Text('Регистрация'),
                        ),
                        const Text(
                          '|',
                          style: TextStyle(color: primaryColor),
                        ),
                        TextButton(
                          onPressed: () => launchUrlString(
                              'https://azan.kz/site/request-password-reset'),
                          child: const Text('Забыли пароль?'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
