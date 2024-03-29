import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_online_app/modules/auth/login/login_screen.dart';
import 'package:notes_online_app/modules/main/notes_screen.dart';
import 'package:notes_online_app/modules/main/search_screen.dart';
import 'package:notes_online_app/shared/app_organization.dart';
import 'package:notes_online_app/shared/block_observer.dart';
import 'package:notes_online_app/shared/cubit/cubit.dart';
import 'package:notes_online_app/shared/cubit/states.dart';
import 'package:notes_online_app/shared/network/local/cache_helper.dart';
import 'package:notes_online_app/shared/style/colors.dart';
import 'package:notes_online_app/shared/style/theme.dart';
import 'package:notes_online_app/shared/texts/routes.dart';

import 'modules/auth/signup/sign_up_screen.dart';
import 'modules/main/note_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ensure that everything in this function already finished then start application `runApp()`

  Bloc.observer = await MyBlocObserver();

  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {},
          builder: (BuildContext context, state) {
            var cubit = AppCubit.get(context);
            AppOrganization.aoIsDarkMode = cubit.getIsDarkMode();

            // statusBae styles...
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: AppOrganization.aoIsDarkMode
                  ? primaryDarkModeColor
                  : primaryLightModeColor,
              statusBarIconBrightness: AppOrganization.aoIsDarkMode
                  ? Brightness.light
                  : Brightness.dark,
              statusBarBrightness: AppOrganization.aoIsDarkMode
                  ? Brightness.dark
                  : Brightness.light,
            ));

            if (CacheHelper.getInt(key: 'user_id') != -1){
              INITIAL_ROUTE = NOTES_ROUTE;
            }

            // print(CacheHelper.getInt(key: 'user_id'));

            return MaterialApp(
              initialRoute: INITIAL_ROUTE,
              routes: {
                SIGNUP_ROUTE: (context) => const SignUpScreen(),
                LOGIN_ROUTE: (context) => const LoginScreen(),
                NOTES_ROUTE: (context) => const NotesScreen(),
                SEARCH_ROUTE: (context) => const SearchScreen(),
                ADD_NOTE_ROUTE: (context) => const NoteScreen(),
                UPDATE_NOTE_ROUTE: (context) => const NoteScreen(),
              },
              debugShowCheckedModeBanner: false,
              themeMode: AppOrganization.aoIsDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkThem,
              // home: const SignUpScreen(),
            );
          }),
    );
  }
}
