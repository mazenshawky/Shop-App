import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    // return BlocConsumer<ShopCubit, ShopStates>(
    //     listener: (context, state) {},
    //     builder: (context, state)
    //     {
    //       return ConditionalBuilder(
    //         condition: ShopCubit.get(context).homeModel != null,
    //         builder: (context) => productsBuilder(),
    //         fallback: (context) => Center(child: CircularProgressIndicator(),),
    //       );
    //     },
    // );
    return Center(
      child: Text(
        'Home Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget productsBuilder() => Column(
    children: [],
  );
}
