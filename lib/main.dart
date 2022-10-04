import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main()
{
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      DioHelper.init();

      await CacheHelper.init();

      bool? isDark = CacheHelper.getData(key: 'isDark');

      Widget widget;

      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      token = CacheHelper.getData(key: 'token');

      print(token);

      if(onBoarding != null)
      {
        if(token != null)
          widget = ShopLayout();
        else
          widget = ShopLoginScreen();
      }
      else
        widget = OnBoardingScreen();

      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget? startWidget;

  MyApp({Key? key,
    this.isDark,
    this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(
            fromShared: isDark,
          ),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            //themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}