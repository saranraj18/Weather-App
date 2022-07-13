import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/data/cities_list.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/screens/city.dart';
import 'package:weather/utilities/custom_icons.dart';
import 'package:weather/widgets/temperature_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.13),
                          color: Colors.white12,
                        ),
                        height: width * 0.13,
                        width: width * 0.13,
                        child: Icon(
                          CustomIcons.menu,
                          color: Colors.white,
                          size: width * 0.05,
                        ),
                      ),
                      ClipOval(
                        child: Image.asset(
                          "images/Avatar.png",
                          height: height * 0.07,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: height * 0.015),
                        const Text(
                          "Hi Jesica !",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white.withOpacity(0.15),
                                Colors.white.withOpacity(0.02),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05,
                            vertical: height * 0.011,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: height * 0.04,
                              ),
                              SizedBox(width: width * 0.01),
                              Text(
                                "Search City",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white54),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => CityScreen(CURRENT_LOC),
                              ),
                            );
                          },
                          child: Container(
                            height: height * 0.15,
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
                              border:
                                  Border.all(width: 3.5, color: Colors.white24),
                              borderRadius: BorderRadius.circular(width * 0.04),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * 0.1,
                                  width: width * 0.2,
                                  child: Image.asset(
                                    "images/${WeatherController.getImage(CURRENT_LOC.weather ?? "")}",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Temperature(
                                        temperature:
                                            CURRENT_LOC.temperature ?? 0,
                                        tempSize: 37,
                                        degSize: 12),
                                    Text(
                                      "${CURRENT_LOC.cityName}, ${CURRENT_LOC.country}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        Text(
                          "Popular Locations",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.04,
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: CITY_LIST.length ~/ 2,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CityWidget(cityModel: CITY_LIST[index]),
                            CityWidget(
                                cityModel:
                                    CITY_LIST[CITY_LIST.length ~/ 2 + index]),
                          ],
                        );
                      },
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

class CityWidget extends StatelessWidget {
  const CityWidget({Key? key, this.cityModel}) : super(key: key);

  final CityModel? cityModel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => CityScreen(cityModel),
          ),
        );
      },
      child: Container(
        height: height * 0.152,
        width: width * 0.62,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.03,
        ),
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Temperature(
                      temperature: cityModel!.temperature ?? 0,
                      tempSize: 24,
                      degSize: 9,
                      rightDiff: 8.5,
                      topDiff: 1.2,
                    ),
                    SizedBox(width: width * 0.04),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        cityModel!.weather ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.007),
                SizedBox(
                  width: width * 0.28,
                  child: Text(
                    "${cityModel!.cityName}, ${cityModel!.country}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: width * 0.04),
            SizedBox(
              height: height * 0.075,
              width: width * 0.175,
              child: Image.asset(
                "images/${WeatherController.getImage(cityModel!.weather ?? '')}",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
