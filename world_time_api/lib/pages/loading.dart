import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:world_time_api/services/world_time_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setUpTime() async{
    Worldtimeapi instance=Worldtimeapi(location: 'Berlin', url: 'Europe/Berlin', flag: 'germany.png');
    await instance.getTime();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });

    if(kDebugMode){
      debugPrint("current UTC time:: ${instance.time}");
    }

  }
  @override
  void initState(){
    super.initState();
    setUpTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Center(
        child: SpinKitFadingCube(
          color: Colors.redAccent,
          size: 50.0,
        ),
      ),
    );
  }
}