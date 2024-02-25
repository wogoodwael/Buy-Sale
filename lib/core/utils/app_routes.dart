import 'package:flutter/material.dart';
import 'package:shopping/core/utils/strings.dart';

import 'package:shopping/presentation/screens/Auth/sign_in.dart';
import 'package:shopping/presentation/screens/Auth/sign_up.dart';
import 'package:shopping/presentation/screens/advertisements/advertise.dart';
import 'package:shopping/presentation/screens/client/profile_edit.dart';
import 'package:shopping/presentation/screens/countries/countries_and_cities.dart';
import 'package:shopping/presentation/screens/home/home.dart';
import 'package:shopping/presentation/screens/categories/categories_screen.dart';
import 'package:shopping/presentation/screens/splash.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
  
      case advertise:
        return MaterialPageRoute(builder: (_) => AdvertiseScreen());
      case countries:
        return MaterialPageRoute(builder: (_) => Countries());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case editProfile:
        return MaterialPageRoute(builder: (_) => ProfileEditScreen());
      case section:
        return MaterialPageRoute(builder: (_) => CategoriesScreen());
    }
    return null;
  }
}
