import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../injection_container.dart';
import '../../../main.dart';
import '../../authentication/services/auth_service.dart';

useStartup() {
  final authService = useMemoized(() => locator<AuthService>(), []);
  final context = useContext();

  useEffect(() {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        if (authService.isLogged()) {
          context.goNamed(Routes.home.name);
        } else {
          context.goNamed(Routes.login.name);
        }
      }
    });

    return null;
  }, [authService, context]);
}
