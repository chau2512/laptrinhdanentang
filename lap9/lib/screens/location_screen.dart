import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lap9/utilities/constants.dart';
import 'package:lap9/services/weather.dart';
import 'package:lap9/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with SingleTickerProviderStateMixin {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String weatherMessage = '';
  int condition = 800;
  bool _isLoading = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    updateUI(widget.locationWeather);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '❌';
        weatherMessage = 'Unable to get weather data';
        cityName = 'Unknown';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  List<Color> _getBackgroundColors() {
    if (condition < 300) return [Color(0xFF1a1a2e), Color(0xFF16213e)];
    if (condition < 600) return [Color(0xFF0d1b2a), Color(0xFF1b263b)];
    if (condition < 700) return [Color(0xFF2d3436), Color(0xFF636e72)];
    if (condition < 800) return [Color(0xFF2d3436), Color(0xFF636e72)];
    if (condition == 800) return [Color(0xFF0f0c29), Color(0xFF302b63)];
    return [Color(0xFF141e30), Color(0xFF243b55)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _getBackgroundColors(),
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Top bar ──
                  _buildTopBar(),
                  SizedBox(height: 20),

                  // ── Main weather card ──
                  Expanded(child: _buildWeatherCard()),

                  // ── Info cards row ──
                  _buildInfoRow(),
                  SizedBox(height: 16),

                  // ── Message card ──
                  _buildMessageCard(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconButton(Icons.near_me_rounded, () async {
            setState(() => _isLoading = true);
            var weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
            _animController.reset();
            _animController.forward();
            setState(() => _isLoading = false);
          }),
          Column(
            children: [
              Text(
                cityName.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kTextWhite,
                  letterSpacing: 3,
                ),
              ),
              SizedBox(height: 2),
              Container(
                width: 30,
                height: 2,
                decoration: BoxDecoration(
                  gradient: kAccentGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
          _iconButton(Icons.search_rounded, () async {
            var typedName = await Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => CityScreen(),
                transitionsBuilder: (_, animation, __, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 1),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    )),
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 400),
              ),
            );
            if (typedName != null) {
              setState(() => _isLoading = true);
              var weatherData = await weather.getCityWeather(typedName);
              updateUI(weatherData);
              _animController.reset();
              _animController.forward();
              setState(() => _isLoading = false);
            }
          }),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white.withOpacity(0.1),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Icon(icon, color: kTextWhite, size: 22),
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Weather icon
          Text(weatherIcon, style: TextStyle(fontSize: 80)),
          SizedBox(height: 8),

          // Temperature
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.white, Colors.white70],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds),
            child: Text(
              '$temperature°',
              style: TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.w100,
                color: Colors.white,
                height: 1.0,
                letterSpacing: -6,
              ),
            ),
          ),
          SizedBox(height: 4),

          // City name
          Text(
            cityName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: kTextMuted,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        Expanded(child: _glassCard('CONDITION', weatherIcon, null)),
        SizedBox(width: 12),
        Expanded(child: _glassCard('TEMP', '$temperature°C', null)),
        SizedBox(width: 12),
        Expanded(child: _glassCard('CITY', cityName.length > 8 ? '${cityName.substring(0, 7)}…' : cityName, null)),
      ],
    );
  }

  Widget _glassCard(String label, String value, IconData? icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            gradient: kCardGradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: kAccentCyan,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kTextWhite,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kAccentCyan.withOpacity(0.15),
                kAccentPurple.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  gradient: kAccentGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  '$weatherMessage in $cityName',
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
