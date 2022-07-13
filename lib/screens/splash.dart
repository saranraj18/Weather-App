import 'package:flutter/material.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/data/cities_list.dart';
import 'package:weather/screens/home.dart';
import 'package:weather/widgets/temperature_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late int? hour;
  late int? min;
  late String? amPm;

  late String? date;
  late String? month;
  late int? year;
  late String? day;

  void getTime() {
    hour = DateTime.now().hour;
    min = DateTime.now().minute;
    amPm = "AM";

    if (hour! > 12 || (hour == 12 && min! > 0)) {
      amPm = "PM";
    }

    if (hour! > 12) {
      hour = hour! - 12;
    }
  }

  void getDate() {
    date = DateTime.now().day.toString().padLeft(2, '0');
    int mm = DateTime.now().month;
    switch (mm) {
      case 1:
        month = 'Jan';
        break;
      case 2:
        month = 'Feb';
        break;
      case 3:
        month = 'Mar';
        break;
      case 4:
        month = 'Apr';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'Jun';
        break;
      case 7:
        month = 'Jul';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sep';
        break;
      case 10:
        month = 'Oct';
        break;
      case 11:
        month = 'Nov';
        break;
      case 12:
        month = 'Dec';
        break;
      default:
    }

    year = DateTime.now().year;
    int _day = DateTime.now().weekday;

    switch (_day) {
      case 1:
        day = 'Mon';
        break;
      case 2:
        day = 'Tue';
        break;
      case 3:
        day = 'Wed';
        break;
      case 4:
        day = 'Thu';
        break;
      case 5:
        day = 'Fri';
        break;
      case 6:
        day = 'Sat';
        break;
      case 7:
        day = 'Sun';
        break;
      default:
    }
  }

  Future fetchCitiesWeather() async {
    await WeatherController.fetchCityWeather();
  }

  Future fetchLocationWeather() async {
    await WeatherController.fetchLocation();
  }

  void setup() async {
    await fetchLocationWeather().then((_) async {
      setState(() {});
      await fetchCitiesWeather().then((_) {
        setState(() {});
        Future.delayed(
          const Duration(seconds: 3),
          (() => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              )),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTime();
    getDate();
    setup();
  }

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
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                Row(
                  children: [
                    Text(
                      "${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontSize: 80,
                      ),
                    ),
                    SizedBox(width: width * 0.005),
                    Padding(
                      padding: const EdgeInsets.only(top: 43),
                      child: Text(
                        "$amPm",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.02),
                  child: Text(
                    "$date $month $year  |  $day",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.035),
                Text(
                  CURRENT_LOC.cityName ?? "",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Temperature(
                        temperature: CURRENT_LOC.temperature ?? 0,
                        tempSize: 40,
                        degSize: 13,
                        rightDiff: 12,
                      ),
                      Image.asset(
                        "images/${WeatherController.getImage(CURRENT_LOC.weather ?? "")}",
                        height: height * 0.17,
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
