import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style{

  static textStyleRegular({double lineHeight = 18.0,double fontSize = 10.0,Color color = Colors.black,}){
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.normal,
      height: lineHeight/fontSize,
    );
  }

  static textStyleSemiBold({double lineHeight = 18.0,double fontSize = 10.0,Color color = Colors.black,}){
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.w600,
      height: lineHeight/fontSize,
    );
  }

  static textStyleBold({double lineHeight = 18.0,double fontSize = 10.0,Color color = Colors.black,}){
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.bold,
      height: lineHeight/fontSize,
    );
  }


}