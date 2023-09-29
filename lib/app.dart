import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:calc_imc_2/pages/main_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal, textTheme: GoogleFonts.robotoTextTheme()),
      //home: const LoginPage(),
      home: const MyHomePage(title: '',)
      
    );
  }
}
