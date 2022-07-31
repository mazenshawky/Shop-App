// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';

import '../../models/home_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  late HomeModel homeModel;

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      //printFullText(homeModel.data!.banners.toString());
     // print(homeModel!.status);
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}