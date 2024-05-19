import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';

const kCustomGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kBlue3Color,
    kBlue2Color,
    kBlue1Color,
    kBlueColor,
    kDarkGredientColor,
    kLightGradientColor,
    k1stColor,
    k2ndColor
    // kDarkGredientColor,
    // kLightGradientColor,
  ],
);
const klightGreyGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    k2ndColor,
    k1stColor,
  ],
);
final kWhiteGreyGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kWhiteColor,
    kWhiteColor.withOpacity(.8),
    kWhiteColor.withOpacity(.6),
    kWhiteColor.withOpacity(.4),
    kWhiteColor.withOpacity(.2),
  ],
);
const kblueGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kBlueColor,
    // kBlue3Color,
    kBlue1Color,
    // kBlue2Color,
  ],
);
