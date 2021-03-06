import 'package:flutter/material.dart';

import './home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      //showSemanticsDebugger: true,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.cyan[600],
        errorColor: Colors.grey,

        fontFamily: 'Exo',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'Exo',
            fontWeight: FontWeight.bold,
            fontSize: 18,
         ),
         button: TextStyle(color: Colors.white),
        ),

        appBarTheme: AppBarTheme(
          color: Colors.cyan[200],
          elevation: 2.5,
          textTheme: ThemeData.light()
              .textTheme
              .copyWith(
                title: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
              ),
        ),
      ),
      home: HomePage(),
    );
  }
}
