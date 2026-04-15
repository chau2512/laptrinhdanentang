import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lap9/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen>
    with SingleTickerProviderStateMixin {
  String? cityName;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: kBackgroundGradient),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 8),
                  // ── Back button ──
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.08)),
                        ),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: kTextWhite, size: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),

                  // ── Title area ──
                  Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w200,
                      color: kTextWhite,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'FIND WEATHER BY CITY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: kTextMuted,
                      letterSpacing: 4,
                    ),
                  ),
                  SizedBox(height: 40),

                  // ── Search input inside glass card ──
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: kCardGradient,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CITY NAME',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: kAccentCyan,
                                letterSpacing: 3,
                              ),
                            ),
                            SizedBox(height: 12),
                            TextField(
                              autofocus: true,
                              style: TextStyle(
                                color: kTextWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              cursorColor: kAccentCyan,
                              decoration: kTextFieldInputDecoration,
                              onChanged: (value) {
                                cityName = value;
                              },
                              onSubmitted: (_) {
                                if (cityName != null &&
                                    cityName!.isNotEmpty) {
                                  Navigator.pop(context, cityName);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // ── Submit button ──
                  GestureDetector(
                    onTap: () {
                      if (cityName != null && cityName!.isNotEmpty) {
                        Navigator.pop(context, cityName);
                      }
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: kAccentGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: kAccentCyan.withOpacity(0.3),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_rounded,
                                color: Colors.white, size: 22),
                            SizedBox(width: 10),
                            Text(
                              'Get Weather',
                              style: kButtonTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Spacer(),

                  // ── Decorative element ──
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 32),
                      child: Column(
                        children: [
                          Icon(Icons.wb_cloudy_outlined,
                              color: Colors.white.withOpacity(0.08),
                              size: 80),
                          SizedBox(height: 12),
                          Text(
                            'Enter any city worldwide',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.2),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
