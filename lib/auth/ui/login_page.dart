import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc bloc;

  const LoginPage(this.bloc, {Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
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
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          onSurface: primaryDarkColor,
                        ),
                    inputDecorationTheme: const InputDecorationTheme(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: primaryDarkColor),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary: primaryDarkColor,
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                    textTheme: Theme.of(context).textTheme.copyWith(
                          subtitle1: const TextStyle(color: primaryDarkColor),
                        ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Image.asset(
                          'assets/images/logo.png',
                          color: primaryDarkColor,
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
                            color: primaryDarkColor,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите логин';
                          }
                        },
                      ),
                      const SizedBox(height: interElementMargin),
                      TextFormField(
                        controller: _password,
                        decoration: const InputDecoration(
                          labelText: 'Пароль',
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: primaryDarkColor,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                        },
                      ),
                      const SizedBox(height: interElementMargin * 2),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            authenticated: (_) => Modular.to.pop(),
                            error: (rejection) {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(rejection.message)),
                              );
                            },
                            orElse: () {},
                          );
                        },
                        builder: (context, state) {
                          return WideButton(
                            'ВОЙТИ',
                            Icons.login,
                            () {
                              if (_form.currentState!.validate()) {
                                widget.bloc.add(AuthEvent.login(
                                  _login.text,
                                  _password.text,
                                ));
                              }
                            },
                            isInProgress: state.maybeWhen(
                              inProgress: () => true,
                              orElse: () => false,
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => launch('https://azan.kz/signup'),
                            child: const Text('Регистрация'),
                          ),
                          const Text(
                            '|',
                            style: TextStyle(color: primaryColor),
                          ),
                          TextButton(
                            onPressed: () => launch(
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
      ),
    );
  }
}
