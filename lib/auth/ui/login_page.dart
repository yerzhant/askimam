import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication_request.dart';
import 'package:askimam/common/ui/widget/wide_button.dart';
import 'package:flutter/material.dart';
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
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  controller: _login,
                  decoration: const InputDecoration(
                    labelText: 'Логин',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите логин';
                    }
                  },
                ),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите пароль';
                    }
                  },
                ),
                TextButton(
                  onPressed: () => launch('https://azan.kz/signup'),
                  child: const Text('Регистрация'),
                ),
                TextButton(
                  onPressed: () =>
                      launch('https://azan.kz/site/request-password-reset'),
                  child: const Text('Забыли пароль?'),
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      authenticated: (_) => Modular.to.navigate('/'),
                      error: (rejection) {
                        return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(rejection.reason)),
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
                            AuthenticationRequest(_login.text, _password.text),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
