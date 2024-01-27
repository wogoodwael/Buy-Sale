import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopping/business_logic/Cubit/advertisement/advertisment_cubit.dart';
import 'package:shopping/business_logic/Cubit/categories_cubit/categories_cubit.dart';
import 'package:shopping/business_logic/Cubit/cityCubit/cities_cubit.dart';
import 'package:shopping/business_logic/Cubit/government_cubit/government_cubit.dart';

import 'package:shopping/business_logic/Cubit/my_advertise/my_advertisement_cubit.dart';
import 'package:shopping/business_logic/Cubit/subCategories/sub_categories_cubit.dart';
import 'package:shopping/core/helper/fav_provider.dart';
import 'package:shopping/core/utils/app_routes.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/firebase_options.dart';

import 'package:shopping/presentation/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  AppRouter appRouter = AppRouter();
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
      ],
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          return Fav();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => SplashScreen(),
          },
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: '/',
        ),
      ),
    );
  }
}
