
import 'package:e_commerce/utills/routes.dart';
import 'package:e_commerce/view/screens/home_page.dart';
import 'package:e_commerce/view/screens/product_detail_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const E_CommerceApp(),
  );
}

class E_CommerceApp extends StatelessWidget {
  const E_CommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        GlobalRoutes.home_page : (context) => const HomePage(),
        GlobalRoutes.detail_page : (context) => const ProductDetailPage(),
      },
    );
  }
}
