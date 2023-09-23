import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Provider.of<ThemeProvider>(context).isDarkMode
            ? Brightness.dark
            : Brightness.light,
      ),
      home: CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime selectedDate;
  late List<String> events;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    events = ["Watch youtube", "Go to Gam", "Go to football"];
  }

  List<String> getEventsForDate(DateTime date) {
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          "My Events",
          style: TextStyle(
              fontSize: 20, color: const Color.fromARGB(255, 252, 251, 251)),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.search,
            color: const Color.fromARGB(255, 252, 251, 251),
          ),
          IconButton(
            icon: Provider.of<ThemeProvider>(context).isDarkMode
                ? SvgPicture.asset(
                    'assets/icons/moon.svg',
                    width: 24,
                    height: 24,
                  )
                : Icon(Icons.sunny),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).isDarkMode =
                  !Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode;
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10, left: 10),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${selectedDate.toString().substring(0, 10)}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Today",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 150,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Add Event"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CalendarTimeline(
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                  events = getEventsForDate(date);
                });
              },
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(20),
                    width: 400,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                events[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 150,
                              ),
                              Icon(Icons.mode_edit_outline_sharp),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: Colors.white),
                                  Text(
                                    selectedDate.toString().substring(0, 10),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    // Iconstimer,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    selectedDate.toString().substring(0, 10),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  ThemeData getThemeData() {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }
}
