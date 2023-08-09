import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/global_controller.dart';
import 'package:weatherapp/widgets/current_weather_widget.dart';
import 'package:weatherapp/widgets/header_widget.dart';
import 'package:weatherapp/widgets/hourly_data_widget.dart';

import '../widgets/daily_data_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: 
          [Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: 
              
              [
                Color(0xff2980B9),
                 Color(0xff6DD5FA),
                Color(0xffFFFFFF),
              
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
              ),
             
            ),
            child: SafeArea(
              child: Obx(() => globalController.checkLoading().isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      scrollDirection: Axis.vertical,
                    children:  [const SizedBox(height: 20), const HeaderWidget(),
                      //for our current temp
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                       globalController.getData().getCurrentWeather(),
                       ),
                   const SizedBox(height: 20),
                       HourlyDataWidget(weatherDataHourly: globalController.getData().getHourlyWeather()),
      
                      DailyDataForecast(
                        weatherDataDaily: globalController.getData().getDailyWeather(),
                      ),
                      ],
                    )),
            ),
          ),
        ],
      ),
    );
  }
}
