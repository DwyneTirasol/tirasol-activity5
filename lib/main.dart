import 'package:flutter/material.dart';
import 'package:tirasol_act5/my_page.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.lime
    ),
    title: "Tirasol-Activity5",
    home: const MyPage(),
  ));
}