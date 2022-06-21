import 'package:flutter/material.dart';
import 'package:flutter_nodejs_crud_operations/product_add_edit.dart';
import 'package:flutter_nodejs_crud_operations/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter NodeJS CRUD App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => const ProductList(),
        '/add-product': (context) => const ProductAddEdit(),
        '/edit-product': (context) => const ProductAddEdit(),
      },
    );
  }
}
