import 'package:flutter/services.dart';
import 'package:flutter_app_boilerplate/services/world_time.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<dynamic> timezones = [];
  List<WorldTime> locations = [];

  void getTimezones() async {
    Uri uri = Uri.parse('http://worldtimeapi.org/api/timezone/');
    Response response = await get(uri);
    timezones = jsonDecode(response.body);

    timezones.forEach((timezone) {
      List<String> timezoneSplit = timezone.split('/');
      String location =
          timezoneSplit.length > 1 ? timezoneSplit[1] : timezoneSplit[0];

      setState(() {
        locations.add(WorldTime(location: location, url: timezone));
      });
    });
  }

  void updateTime(int index) async {
    WorldTime worldTime = locations[index];
    await worldTime.getTime();

    Navigator.pop(context, {
      'location': worldTime.location,
      'time': worldTime.time,
      'isDayTime': worldTime.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    getTimezones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          backgroundColor: Colors.blue[600],
          title: Text('Choose a Location'),
          centerTitle: true,
          elevation: 0),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
                    onTap: () {
                      updateTime(index);
                    },
                    title: Text(locations[index].url)));
          }),
    );
  }
}
