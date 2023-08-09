



import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp/controller/global_controller.dart';
import 'package:weatherapp/model/weather_data_hourly.dart';
import 'package:weatherapp/utils/custom_colors.dart';

class HourlyDataWidget extends StatefulWidget {

  final WeatherDataHourly weatherDataHourly;
  const HourlyDataWidget({
    Key? key,
    required this.weatherDataHourly,
  }) : super(key: key);

  @override
  State<HourlyDataWidget> createState() => _HourlyDataWidgetState();
}

class _HourlyDataWidgetState extends State<HourlyDataWidget> {
  RxInt cardIndex =GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text("Today",style: TextStyle(
            fontSize: 18,
          fontWeight:FontWeight.w500
          ),),
        ),
        hourlyList(),
      ],
    );
  }

Widget  hourlyList() {
  return Container(
    height: 160,
    padding: const EdgeInsets.only(top: 10,bottom: 10),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.weatherDataHourly.hourly.length > 12
       ? 14
       :widget.weatherDataHourly.hourly.length,
      itemBuilder: (context,index) {
        return Obx((()=> GestureDetector(
          onTap: () {
            cardIndex.value =index;
          },
          child: Container(
            width: 90,
            margin: const EdgeInsets.only(left: 20,right: 5),
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0.5, 0),
                blurRadius: 30,
                spreadRadius: 1,
                color: CustomColors.dividerLine.withAlpha(150),
              ),
            ],
            gradient:cardIndex.value ==index  ? const LinearGradient(colors: 
            [CustomColors.firstGradientColor,
            CustomColors.secondGradientColor]
            ):null
          ),
          child: HourlyDetails(
            index: index,
            cardIndex: cardIndex.toInt(),
            temp:widget.weatherDataHourly.hourly[index].temp!,
            timestamp: widget.weatherDataHourly.hourly[index].dt!, 
            weatherIcon: widget.weatherDataHourly.hourly[index].weather![0].icon!,
            ),
        ))));
      }
      ),
  );
}
}

//hourly details class
class HourlyDetails extends StatelessWidget {
 final int temp;
 final  int index;
final  int cardIndex;
final int timestamp;
final String weatherIcon;

 


  const HourlyDetails(
      {Key? key,
      required this.cardIndex,
      required this.index,
      required this.temp,
      required this.timestamp,
      required this.weatherIcon})
      : super(key: key);

String getTime(final timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text(getTime(timestamp),style: TextStyle(color: cardIndex ==index ? Colors.white :CustomColors.textColorBlack,),),
      ),
      Container(
        margin: const EdgeInsets.all(5),
        child: Image.asset("assets/weather/$weatherIcon.png",height:40,width: 40,),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Text("$temp°",
        style: TextStyle(
          color: cardIndex ==index ? Colors.white :CustomColors.textColorBlack,
        ),
        ),
      ),
    ],
    );
  }
}
