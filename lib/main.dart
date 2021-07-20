import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/authState.dart';
import 'package:flutter_ecommerce/src/config/route.dart';
import 'package:flutter_ecommerce/src/pages/mainPage.dart';
import 'package:flutter_ecommerce/src/pages/product_detail.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce ',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // routes: Routes.getRoute(),
      // onGenerateRoute: (RouteSettings settings) {
      //   if (settings.name!.contains('detail')) {
      //     return MaterialPageRoute<bool>(
      //         builder: (BuildContext context) => ProductDetailPage());
      //   } else {
      //     return MaterialPageRoute<bool>(
      //         builder: (BuildContext context) => AuthStateWidget());
      //   }
      // },
      home: AuthStateWidget(),
      // initialRoute: "MainPage",
    );
  }
}
