import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var temp;
  var currently;
  var humidity;
  var windSpeed;
  String city = "kolkata";

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  PressedButton() {
    city = textController.text;
    FocusScope.of(context).unfocus();
    this.getWeather();
  }

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=" +
            city +
            "&units=metric&appid=9bb8db86a4620820bbccccae4e5e8826");
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result["main"]["temp"];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windSpeed = result['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Image.network(
                  'https://images.unsplash.com/photo-1535498730771-e735b998cd64?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
              height: height,
            ),
            Container(
              height: height,
              child: Scaffold(
                backgroundColor: Colors.black54,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: DefaultTextStyle(
                    style: GoogleFonts.raleway(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "Hello!",
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Check the weather by city",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: textController,
                          decoration: InputDecoration(
                            border: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: inputBorder,
                            hintText: "Search city",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => PressedButton(),
                              icon: Icon(Icons.search),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            city.toUpperCase(),
                            style: TextStyle(fontSize: 42),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    Icons.thermostat_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    temp.toString() + "° C",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cloud_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    currently.toString(),
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    WeatherIcons.strong_wind,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    windSpeed.toString() + " m/s",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    WeatherIcons.humidity,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    humidity.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
