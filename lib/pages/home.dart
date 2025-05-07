import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    var routeData = ModalRoute.of(context)?.settings.arguments;
    if (routeData != null ) {
      data = data.isNotEmpty? data:  routeData as Map<String, dynamic> ;
    }
    //set background
    String bgImage= data['isDayTime']? 'day.png': 'night.png';
    Color bgcolor = (data['isDayTime'] as bool)
        ? Colors.lightBlue
        : Colors.indigo[700]!;

    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () async {
                     dynamic result =  await Navigator.pushNamed(context, '/location');
                     setState(() {
                       data={
                         'time': result['time'],
                         'location': result['location'],
                         'isDayTime': result['isDayTime'],
                         'flag': result['flag']
                       };
                     });
                  },
                  icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                  ),
                  label: Text(
                      'Edit location',
                       style: TextStyle(
                         color: Colors.grey[300],
                       ),
                  ),
                ),
              SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        data['location'],
                      style: TextStyle(
                        fontSize: 29.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),

                  ],
                ),
                SizedBox( height: 20.0,),
                Text(
                    data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
