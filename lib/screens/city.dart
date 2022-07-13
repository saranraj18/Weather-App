import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/utilities/custom_icons.dart';
import 'package:weather/widgets/temperature_widget.dart';

class CityScreen extends StatefulWidget {
  CityScreen(this.cityModel);

  final CityModel? cityModel;

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                        left: width * 0.05,
                        top: height * 0.05,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.05),
                Image.asset(
                  "images/${WeatherController.getImage(widget.cityModel!.weather ?? "")}",
                  height: height * 0.15,
                ),
                SizedBox(height: height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.cityModel!.cityName}",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(width: width * 0.02),
                    Icon(
                      CustomIcons.vector,
                      color: Colors.white,
                      size: width * 0.045,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.015),
                Temperature(
                  temperature: widget.cityModel!.temperature,
                  tempSize: 45,
                  degSize: 14,
                  rightDiff: 13,
                ),
                SizedBox(height: height * 0.05),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.04),
                      ],
                    ),
                    border: Border.all(width: 3.5, color: Colors.white24),
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Today",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "PRESSURE",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                "${widget.cityModel!.pressure} Pa",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.09),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "HUMIDITY",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                "${widget.cityModel!.humidity}%",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.023),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Wind - ${widget.cityModel!.wind} Km/h",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              fontSize: 17,
                            ),
                          ),
                          Image.asset("images/wind.png", height: height * 0.1),
                        ],
                      ),
                    ],
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
