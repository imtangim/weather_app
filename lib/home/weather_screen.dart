import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wheater_app/home/secret.dart';
import 'forcast/forecast.dart';
import 'additional_info/additionalinfo.dart';
import 'location_l/location.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  //weather api
  Future getWeather() async {
    LocationManager location = LocationManager();
    await location.fetchLocationData();
    double? lat = location.lat;
    double? long = location.long;

    final res = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&appid=$openweatherApikey"),
    );
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "30°C",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Rain",
                            style: TextStyle(fontSize: 23),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Weather Forecast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            //Weather forcast Card
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ForcastCard(
                    icon: Icons.cloud,
                    temperature: 30.4,
                    time: "00:02",
                  ),
                  ForcastCard(
                    icon: Icons.cloud,
                    temperature: 30.4,
                    time: "04:02",
                  ),
                  ForcastCard(
                    icon: Icons.cloud,
                    temperature: 30.4,
                    time: "08:02",
                  ),
                  ForcastCard(
                    icon: Icons.cloud,
                    temperature: 30.4,
                    time: "12:02",
                  ),
                  ForcastCard(
                    icon: Icons.cloud,
                    temperature: 30.4,
                    time: "16:02",
                  ),
                  ForcastCard(
                    icon: Icons.cloud,
                    temperature: 30.4,
                    time: "20:02",
                  ),
                  ForcastCard(
                    icon: Icons.cloud,
                    temperature: 30.4,
                    time: "24:02",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Additional Information",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            // additional information
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfo(
                    icon: Icons.water_drop,
                    label: "Humidity",
                    valuee: 56,
                  ),
                  AdditionalInfo(
                    icon: Icons.air_outlined,
                    label: "Air Speed",
                    valuee: 7.62,
                  ),
                  AdditionalInfo(
                    icon: CupertinoIcons.rocket,
                    label: "Air Pressure",
                    valuee: 1007,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
