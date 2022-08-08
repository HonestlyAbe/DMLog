import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dm_log/data/activity_provider.dart';
import 'screen/act_row.dart';
import 'data/activity_provider.dart';
import 'data/activity.dart';
import 'data/participant_entry.dart';
import './data/study_info.dart';
import './screen/settings.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ActivityProvider()),
    ChangeNotifierProvider(create: (_) => StudyInfo.defaultStudyInfo()),
    ChangeNotifierProvider(create: (_) => ParticipantEntry()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity logging',
      theme: ThemeData(
        // Details about the theme of out app
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Activity logging'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addActivity() {
    setState(() {
      // Add a new activity to the list in provider
      Provider.of<ActivityProvider>(context, listen: false).addActivity(
          Activity.defaultActivity(
              Provider.of<ActivityProvider>(context, listen: false),
              Provider.of<StudyInfo>(context, listen: false)));
    });
  }

  void _addBlankActivity() {
    setState(() {
      //print activies
      // Add a new activity to the list in provider
      Provider.of<ActivityProvider>(context, listen: false).addActivity(
          Activity.blankActivity(
              Provider.of<ActivityProvider>(context, listen: false),
              Provider.of<StudyInfo>(context, listen: false)));
    });
  }

  void _openSettingsPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Settings')),
          content: Settings(
              activities: Provider.of<ActivityProvider>(context, listen: false),
              study: Provider.of<StudyInfo>(context, listen: false),
              participants:
                  Provider.of<ParticipantEntry>(context, listen: false)),
        );
      },
    );
  }

  // Returns a widget for our row titles
  Widget rowTitle(String title, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(child: Text(title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          // Activity Row
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height - 106,
              width: 750,
              child: ListView(
                children: Provider.of<ActivityProvider>(context)
                    .activities
                    .map((activity) => ActivityRow(
                          key: Key(activity.ID),
                          data: activity,
                          activityProvider:
                              Provider.of<ActivityProvider>(context),
                          study: Provider.of<StudyInfo>(context),
                          index: Provider.of<ActivityProvider>(context)
                              .activities
                              .indexOf(activity),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      // Button to add activity on the right and settings button on the left
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _addActivity,
            tooltip: 'Add prefilled activity',
            child: const Icon(Icons.bolt),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _addBlankActivity,
            tooltip: 'Add blank activity',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              _openSettingsPopup();
            },
            tooltip: 'Settings',
            child: const Icon(Icons.settings),
          ),
        ],
      ),
      // pop up menu for the app bar
    );
  }

  Row titlesRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      rowTitle("Time Started", 120),
      rowTitle("Time ended", 100),
      rowTitle("Involved", 100),
      rowTitle("Activity Type", 110),
      rowTitle("# Children", 100),
      rowTitle("# Adults", 100),
      rowTitle("Comments", 250)
    ]);
  }
}
