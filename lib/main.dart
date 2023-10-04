import 'dart:developer';

import 'package:ecommerce_app_bloc/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:ecommerce_app_bloc/bloc/add_to_product_bloc/add_to_product_bloc.dart';
import 'package:ecommerce_app_bloc/screeens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var status = await Permission.storage.request();

  if (status.isGranted) {
    runApp(const MyApp());
  } else {
    log('Storage permission denied.');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PrdBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        title: "Ecommerce App",
        initialRoute: '/',
        routes: {'/': (context) => const ProductListScreen()},
      ),
    );
  }
}
