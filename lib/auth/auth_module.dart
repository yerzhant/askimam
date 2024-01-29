import 'package:askimam/auth/ui/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/login', child: (_) => LoginPage(Modular.get()));
  }
}
