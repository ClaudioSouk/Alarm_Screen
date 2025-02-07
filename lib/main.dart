import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for formatting time

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlarmScreen(),
    );
  }
}

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<String> alarmTimes = ['11:30 AM', '12:15 PM', '1:05 PM'];

  Future<void> _editTime(int index) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        alarmTimes[index] = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text(
              'Alarms',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Spacer(), // Align time to the right
            StreamBuilder<DateTime>(
              stream: Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()),
              builder: (context, snapshot) {
                String timeText = snapshot.hasData ? DateFormat('hh:mm:ss a').format(snapshot.data!) : "Loading...";
                return Text(
                  timeText,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              setState(() {
                alarmTimes.add('2:00 PM'); // Add a new alarm time
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Divider(color: Colors.white24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('No Alarm', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: Text('SET UP'),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white24),
            Expanded(
              child: ListView.builder(
                itemCount: alarmTimes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _editTime(index),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(alarmTimes[index], style: TextStyle(color: Colors.white, fontSize: 24)),
                                  Text('Alarm', style: TextStyle(color: Colors.white70)),
                                ],
                              ),
                              Switch(
                                value: false,
                                onChanged: (bool value) {},
                                activeColor: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
