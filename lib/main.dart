import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/bloc/ecommerce/ecommerce_cubit.dart';
import 'package:flutter_ecommerce/bloc/ecommerce/ecommerce_repository.dart';

import 'bloc/ecommerce/ecommerce_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<EcommerceCubit>(
        create: (context) => EcommerceCubit(
          repository: EcommerceRepository(),
        ),
        child: ProductPage(),
      ),
    );
  }
}
