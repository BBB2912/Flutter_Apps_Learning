import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class Worldtimeapi {
  String location;
  late String time;
  String url;
  String flag;
  String isDayTime="day";
  Worldtimeapi({required this.location, required this.url, required this.flag});

  Future<void> getTime() async{
    try{
    Response response=await get(Uri.parse('https://timeapi.io/api/timezone/zone?timeZone=$url'));
    Map data=jsonDecode(response.body);
    DateTime currentLocalTime=DateTime.parse(data['currentLocalTime']);
    int currentUtcOffsetInSec=data['currentUtcOffset']['seconds'];
    DateTime currentUtcTime=currentLocalTime.add(Duration(seconds:currentUtcOffsetInSec));
    // if(kDebugMode){
    //   debugPrint("Current Local Time: $currentLocalTime");
    //   debugPrint("Current UTC Offset in Seconds: $currentUtcOffsetInSec");
    //   debugPrint("Current UTC Time: $currentUtcTime");
    // } 
    time=DateFormat.jm().format(currentUtcTime);
    isDayTime=(currentUtcTime.hour>6 && currentUtcTime.hour<20) ? "day" : "night";
    
  }
  catch(e){
    if(kDebugMode){
      debugPrint("Error occurred while fetching time: $e");
    }
    time="Could not fetch time data";
  }
  }

}