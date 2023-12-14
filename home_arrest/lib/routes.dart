import 'package:flutter/material.dart';
import 'view/add_signature/add_signature_screen.dart';
import 'view/alert/alert_detail_screen.dart';
import 'view/client/add_offender/add_offender_screen.dart';
import 'view/client/client_dashboard/client_dashboard.dart';
import 'view/client/client_history/client_history_screen.dart';
import 'view/client/client_history/history_detail_screen.dart';
import 'view/client/client_location/client_location.dart';
import 'view/client/client_locations/client_locations_screen.dart';
import 'view/profile/edit_profile_screen.dart';
import 'view/client/ping_current_location/ping_current_location_screen.dart';
import 'view/client/request_check_in/request_check_in_screen.dart';
import 'view/client/search_client/search_client_screen.dart';
import 'view/dashboard/dashboard_screen.dart';
import 'view/onboarding/change_password/change_password_screen.dart';
import 'view/onboarding/sign_in/sign_in_screen.dart';
import 'view/onboarding/sign_up/sign_up_screen.dart';
import 'view/onboarding/splash/splash_screen.dart';
import 'view/profile/profile_screen.dart';

class Routes {
  Routes._();

  routes() => <String, WidgetBuilder>{};

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AddOffenderScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AddOffenderScreen());
      case ClientDashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientDashboardScreen());
      case ClientHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientHistoryScreen());
      case ClientLocationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientLocationScreen());
      case EditProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case DashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case HistoryDetailScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HistoryDetailScreen());
      case ClientLocationsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientLocationsScreen());
      case AlertDetailScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AlertDetailScreen());
      case SearchClientScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SearchClientScreen());
      case PingCurrentLocationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const PingCurrentLocationScreen());
      case RequestCheckInScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RequestCheckInScreen());
      case ChangePasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case AddSignatureScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AddSignatureScreen());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
    }
  }
}
