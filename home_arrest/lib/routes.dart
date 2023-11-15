import 'package:flutter/material.dart';
import 'view/alert/alert_detail_screen.dart';
import 'view/client/client_dashboard/client_dashboard.dart';
import 'view/client/client_details/client_details.dart';
import 'view/client/client_history/client_history_screen.dart';
import 'view/client/client_history/history_detail_screen.dart';
import 'view/client/client_location/client_location.dart';
import 'view/client/client_locations/client_locations_screen.dart';
import 'view/client/client_profile/client_profile_screen.dart';
import 'view/client/search_client/search_client_screen.dart';
import 'view/dashboard/dashboard_screen.dart';
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
      case ClientDetailsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientDetailsScreen());
      case ClientDashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientDashboardScreen());
      case ClientHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientHistoryScreen());
      case ClientLocationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientLocationScreen());
      case ClientProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ClientProfileScreen());
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
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
    }
  }
}
