import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamraka_admin/screens/categories/cubit/categories_cubit.dart';
import 'package:gamraka_admin/screens/countries/cubit/countries_cubit.dart';
import 'package:gamraka_admin/screens/orders/cubit/orders_cubit.dart';
import 'package:gamraka_admin/screens/routes/cubit/routes_cubit.dart';

import 'firebase_options.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/shared_helper.dart';
import 'screens/admins/cubit/admins_cubit.dart';
import 'screens/asks/cubit/asks_cubit.dart';
import 'screens/login/cubit/login_cubit.dart';
import 'screens/sliders/cubit/sliders_cubit.dart';
import 'screens/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/users/cubit/users_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedHelper.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AdminsCubit()),
        BlocProvider(create: (context) => UsersCubit()),
        BlocProvider(create: (context) => SlidersCubit()),
        BlocProvider(create: (context) => AsksCubit()),
        BlocProvider(create: (context) => CountriesCubit()),
        BlocProvider(create: (context) => RoutesCubit()),
        BlocProvider(create: (context) => CategoriesCubit()),
        BlocProvider(create: (context) => OrdersCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primary,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
