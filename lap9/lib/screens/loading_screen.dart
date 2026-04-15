import 'package:flutter/material.dart';
import 'package:lap9/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lap9/services/weather.dart';
import 'package:lap9/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  String _statusText = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
    getLocationData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getLocationData() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (mounted) setState(() => _statusText = 'Loading weather data...');

    var weatherData = await WeatherModel().getLocationWeather();

    if (mounted) {
      Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                LocationScreen(locationWeather: weatherData),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: Duration(milliseconds: 600),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: kBackgroundGradient),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing weather icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kAccentGradient,
                    boxShadow: [
                      BoxShadow(
                        color: kAccentCyan.withOpacity(0.4),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.cloud_rounded,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                // App title
                Text(
                  'Clima',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w200,
                    color: kTextWhite,
                    letterSpacing: 8,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'WEATHER FORECAST',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: kTextMuted,
                    letterSpacing: 4,
                  ),
                ),
                SizedBox(height: 50),
                // Spinner
                SpinKitRipple(
                  color: kAccentCyan,
                  size: 60.0,
                ),
                SizedBox(height: 20),
                Text(
                  _statusText,
                  style: TextStyle(
                    fontSize: 14,
                    color: kTextMuted,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
