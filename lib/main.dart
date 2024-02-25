import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/advertisement/advertisment_cubit.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/categories/categories_cubit.dart';

import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/business_logic/Cubit/filter_category_cubit/filter_category_cubit.dart';
import 'package:shopping/business_logic/Cubit/government_cubit/government_cubit.dart';

import 'package:shopping/business_logic/Cubit/my_advertise/my_advertisement_cubit.dart';
import 'package:shopping/business_logic/Cubit/subCategories/sub_categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/sub_cate_create_adv/sub_cate_create_adv_cubit.dart';
import 'package:shopping/core/helper/fav_provider.dart';
import 'package:shopping/core/utils/app_routes.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/firebase_options.dart';
import 'package:shopping/presentation/screens/Auth/sign_up.dart';

import 'package:shopping/presentation/screens/home/home.dart';

import 'package:shopping/presentation/screens/splash.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedpref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouter appRouter = AppRouter();
Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
bool _initialUriIsHandled = false;
  StreamSubscription? _sub;
  int? lenght;
@override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
    
  }
 
void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        print('got uri: $uri');
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }
   Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GovernmentCubit(ApiServices())),
        BlocProvider(create: (context) => CategoriesCubit(ApiServices())),
        BlocProvider(create: (context) => SubCategoriesCubit(ApiServices())),
        BlocProvider(create: (context) => CitiesCubit(ApiServices())),
        BlocProvider(create: (context) => MyAdvertisementCubit(ApiServices())),
        BlocProvider(create: (context) => AdvertismentCubit(ApiServices())),
        BlocProvider(
            create: (context) => SubCateCreateAdvCubit(ApiServices(), lenght)),
        BlocProvider(create: (context) => AttrsCategoriesCubit(ApiServices())),
        BlocProvider(create: (context)=>FilterCategoryCubit(ApiServices()))
      ],
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          return Fav();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
         routes: {
"/":(context) => sharedpref.getString("login_token") == null
                ? const SplashScreen()
                : HomeScreen(),
                "/signup" : (context) => SignUpScreen(),
                
         },

         
           onGenerateRoute: appRouter.generateRoute,
         initialRoute: '/',
         
        ),
      ),
    );
  }
}

// final router = GoRouter(routes: [
//   GoRoute(path: '/', builder: (_,__)=>sharedpref.getString("login_token") == null
//                 ? SplashScreen()
//                 : HomeScreen(),
//                 routes: [
//                   GoRoute(path: 'my_advertisement_details', builder: (_ , __) => MyAdvertisementDetails()),
//                   GoRoute(path: 'profile', builder: (_ , __) => ProfileScreen()),
//                 ]
//                 )
// ],


// );
