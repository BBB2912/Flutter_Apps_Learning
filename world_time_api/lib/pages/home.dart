import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty
        ? data
        : (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    String backgroundImage=data['isDayTime'] == 'day' ? 'day.jpg' : 'night.jpg';
    String textColor=data['isDayTime'] == 'day' ? 'black' : 'white';
    return Scaffold(
      body:Container(
        decoration:BoxDecoration(
          image:DecorationImage(
            image:AssetImage('assets/images/$backgroundImage'),
            fit:BoxFit.cover
          )
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0,120.0,0,0),
          child: Column(
            children:<Widget> [
              TextButton.icon(
                onPressed: () async{
                  dynamic results=await Navigator.pushNamed(context,'/choose_location');
                  setState(() {
                    data = {
                      'location': results['location'],
                      'flag': results['flag'],
                      'time': results['time'],
                      'isDayTime': results['isDayTime'],
                    };
                  });
                },
                icon:Icon(Icons.edit_location),
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    color: textColor == 'black' ? Colors.black : Colors.white,
                    fontSize: 20.0,
                  ),
              ),
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'] ?? 'No Location',
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: textColor == 'black' ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Text(
                data['time'] ?? 'No Time Data',
                style: TextStyle(
                  fontSize: 66.0,
                  letterSpacing: 2.0,
                  color: textColor == 'black' ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        )
        ),
    );
  }
}