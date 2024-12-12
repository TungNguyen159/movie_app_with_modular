import 'package:flutter/material.dart';

class Gap {
  // Spacing values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double sM = 12.0;
  static const double md = 16.0;
  static const double mL = 20.0;
  static const double lg = 24.0;
  static const double lX = 28.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Reusable SizedBox widgets for vertical spacing
  static const Widget xsHeight = SizedBox(height: xs);
  static const Widget smHeight = SizedBox(height: sm);
  static const Widget sMHeight = SizedBox(height: sM);
  static const Widget mdHeight = SizedBox(height: md);
  static const Widget mLHeight = SizedBox(height: mL);
  static const Widget lgHeight = SizedBox(height: lg);
  static const Widget lXHeight = SizedBox(height: lX);
  static const Widget xlHeight = SizedBox(height: xl);
  static const Widget xxlHeight = SizedBox(height: xxl);
  static const Widget xxxlHeight = SizedBox(height: xxxl);

  // Reusable SizedBox widgets for horizontal spacing
  static const Widget xsWidth = SizedBox(width: xs);
  static const Widget smWidth = SizedBox(width: sm);
  static const Widget sMWidth = SizedBox(width: sM);
  static const Widget mdWidth = SizedBox(width: md);
  static const Widget mLWidth = SizedBox(width: mL);
  static const Widget lgWidth = SizedBox(width: lg);
  static const Widget lXWidth = SizedBox(width: lX);
  static const Widget xlWidth = SizedBox(width: xl);
  static const Widget xxlWidth = SizedBox(width: xxl);
  static const Widget xxxlWidth = SizedBox(width: xxxl);
}
