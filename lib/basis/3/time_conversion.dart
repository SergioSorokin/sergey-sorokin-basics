import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TimeConversion extends StatefulWidget {
  static const String routName = '/timeConversion';
  const TimeConversion({Key? key}) : super(key: key);

  @override
  _TimeConversionState createState() => _TimeConversionState();
}

class _TimeConversionState extends State<TimeConversion> {
  String _hour12 = '';
  String _hour24 = '';
  String _minute = '';
  String _time12 = '';
  String _time24 = '';

  bool isChek = false;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeConversion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterSwitch(
              activeText: '12',
              inactiveText: '24',
              padding: 4.0,
              width: 60,
              borderRadius: 30.0,
              showOnOff: true,
              value: isChek,
              onToggle: (bool value) {
                this.setState(
                  () {
                    isChek = value;
                  },
                );
              },
              activeIcon: Icon(Icons.keyboard_arrow_left_outlined),
              inactiveIcon: Icon(Icons.keyboard_arrow_right_outlined),
              activeColor: Colors.indigo,
              inactiveColor: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 88.0, bottom: 150),
              child: IconButton(
                icon: Icon(
                  Icons.access_alarm,
                  color: Colors.red,
                  size: 44,
                ),
                onPressed: () {
                  _selectTime(context);
                },
              ),
            ),
            Text(
              isChek ? _time24 : _time12,
              style: TextStyle(
                fontSize: 64,
                color: Colors.deepPurpleAccent,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null)
      setState(
        () {
          String am = '';
          selectedTime = picked;
          picked.period == DayPeriod.am ? am = 'AM' : am = 'PM';

          _hour24 = selectedTime.hour.toString();
          _hour12 = selectedTime.hourOfPeriod.toString();
          _minute = selectedTime.minute.toString();
          _time24 = '$_hour24:$_minute';
          _time12 = '$_hour12:$_minute $am';
        },
      );
  }
}
