import 'package:flutter/material.dart';

// ── Color palette ──
const Color kPrimaryDark = Color(0xFF0F0C29);
const Color kPrimaryMid = Color(0xFF302B63);
const Color kPrimaryLight = Color(0xFF24243E);
const Color kAccentCyan = Color(0xFF00D2FF);
const Color kAccentPurple = Color(0xFF7A5FFF);
const Color kSurfaceWhite = Color(0xCCFFFFFF);
const Color kTextWhite = Color(0xFFF5F5F5);
const Color kTextMuted = Color(0xAAFFFFFF);

// ── Gradients ──
const LinearGradient kBackgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kPrimaryDark, kPrimaryMid, kPrimaryLight],
);

const LinearGradient kAccentGradient = LinearGradient(
  colors: [kAccentCyan, kAccentPurple],
);

const LinearGradient kCardGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0x33FFFFFF),
    Color(0x0DFFFFFF),
  ],
);

// ── Text styles ──
const kTempTextStyle = TextStyle(
  fontSize: 96.0,
  fontWeight: FontWeight.w200,
  color: kTextWhite,
  letterSpacing: -4,
  height: 1.0,
);

const kCityTextStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w300,
  color: kTextMuted,
  letterSpacing: 2,
);

const kMessageTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w400,
  color: kTextWhite,
  height: 1.4,
);

const kConditionTextStyle = TextStyle(
  fontSize: 72.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
  color: kTextWhite,
  letterSpacing: 1.2,
);

const kLabelTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: kTextMuted,
  letterSpacing: 1.5,
);

// ── Input decoration ──
final kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white.withOpacity(0.15),
  prefixIcon: Icon(
    Icons.search_rounded,
    color: kAccentCyan,
    size: 24,
  ),
  hintText: 'Search city...',
  hintStyle: TextStyle(
    color: Colors.white.withOpacity(0.4),
    fontSize: 16,
    fontWeight: FontWeight.w300,
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.15), width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    borderSide: BorderSide(color: kAccentCyan, width: 1.5),
  ),
);
