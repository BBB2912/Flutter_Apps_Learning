import 'package:flutter/material.dart';
import 'package:world_time_api/services/world_time_api.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<Worldtimeapi> locations=[
    Worldtimeapi(location: 'Berlin', url: 'Europe/Berlin', flag: 'germany.png'),
    Worldtimeapi(location: 'Cairo', url: 'Africa/Cairo', flag: 'egypt.png'),
    Worldtimeapi(location: 'Chicago', url: 'America/Chicago', flag: 'usa.png'),
    Worldtimeapi(location: 'Dhaka', url: 'Asia/Dhaka', flag: 'bangladesh.png'),
    Worldtimeapi(location: 'Jakarta', url: 'Asia/Jakarta', flag: 'indonesia.png'),
    Worldtimeapi(location: 'Kolkata', url: 'Asia/Kolkata', flag: 'india.png'),
    Worldtimeapi(location: 'London', url: 'Europe/London', flag: 'uk.png'),
    Worldtimeapi(location: 'New York', url: 'America/New_York', flag: 'usa.png'),
  ];

  void updateTime(index) async{
    Worldtimeapi instance = locations[index];
    await instance.getTime();
    // ignore: use_build_context_synchronously
    print("Current UTC time: ${instance.time}");
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Choose Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: ()  {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading:Icon(Icons.location_on, color: Colors.blue),
              ),
            );
          },
        ),
      ),
    );
  }
}