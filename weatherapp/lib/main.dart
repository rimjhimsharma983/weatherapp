import 'package:flutter/material.dart';
import 'package:weatherapp/services/api_helper.dart';
import 'package:weatherapp/services/geo_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String city = '';
  double temp = 0.0;
  int humidity = 0;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/pic.jpg'), fit: BoxFit.cover),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 43, 21, 47),
                  Color.fromARGB(255, 236, 110, 221)
                ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          //backgroundColor: Color.fromARGB(255, 222, 238, 240),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      // child: CircleAvatar(
                      //   radius: 130,
                      //   backgroundImage: AssetImage('images/pic.jpg'),
                      // ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: 400,
                        child: TextField(
                          onChanged: (value) {
                            city = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            border: OutlineInputBorder(),
                            hintText: 'Enter location',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var r = await ApiHelper(city).call_api();
                        GpsHelper gps = GpsHelper();
                        await gps.get_location();
                        print(r);
                        setState(() {
                          temp = r['current']['temp_c'];
                          humidity = r['current']['humidity'];
                          latitude = gps.latitude;
                          longitude = gps.longitude;
                        });
                      },
                      child: Text("Search"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Temperature- ${temp} '),
                ),
                Text('Humidity-  ${humidity}'),
                Text('Latitude-  ${latitude}'),
                Text('Longitude-  ${longitude}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
