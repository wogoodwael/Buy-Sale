import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/business_logic/Cubit/advertisement/advertisment_cubit.dart';
import 'package:shopping/business_logic/Cubit/attrs_categories/attrs_categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/categories/categories_cubit.dart';

import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/business_logic/Cubit/government_cubit/government_cubit.dart';

import 'package:shopping/business_logic/Cubit/my_advertise/my_advertisement_cubit.dart';
import 'package:shopping/business_logic/Cubit/subCategories/sub_categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/sub_cate_create_adv/sub_cate_create_adv_cubit.dart';
import 'package:shopping/core/helper/fav_provider.dart';
import 'package:shopping/core/utils/app_routes.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/firebase_options.dart';
import 'package:shopping/presentation/screens/client/my_advertisement_details.dart';
import 'package:shopping/presentation/screens/client/profile.dart';
import 'package:shopping/presentation/screens/home/home.dart';

import 'package:shopping/presentation/screens/splash.dart';

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
class MyApp extends StatelessWidget {
  MyApp({super.key});
  AppRouter appRouter = AppRouter();
  int? lenght;
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
      ],
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          return Fav();
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
         routerConfig: router,
         
        ),
      ),
    );
  }
}

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (_,__)=>sharedpref.getString("login_token") == null
                ? SplashScreen()
                : HomeScreen(),
                routes: [
                  GoRoute(path: 'my_advertisement_details', builder: (_ , __) => MyAdvertisementDetails()),
                  GoRoute(path: 'profile', builder: (_ , __) => ProfileScreen()),
                ]
                )
],


);
