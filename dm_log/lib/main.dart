import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dm_log/data/activity_provider.dart';
import 'screen/act_row.dart';
import 'screen/part_row.dart';
import 'data/activity.dart';
import 'data/participant_provider.dart';
import './data/study_info.dart';
import './screen/settings.dart';
import 'settings_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ActivityProvider()),
    ChangeNotifierProvider(create: (_) => StudyInfo()),
    ChangeNotifierProvider(create: (_) => ParticipantProvider()),
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

class ActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Activity Row
        Expanded(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: Provider.of<ActivityProvider>(context)
                  .activities
                  .map((activity) => ActivityRow(
                        key: Key(activity.ID),
                        data: activity,
                        participantProvider:
                            Provider.of<ParticipantProvider>(context),
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
    );
  }
}

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Participant Row
        Expanded(
          child: Center(
            child: ListView(
              children: Provider.of<ParticipantProvider>(context)
                  .participants
                  .map((participant) => PartRow(
                        key: Key(Provider.of<ParticipantProvider>(context)
                            .participants
                            .indexOf(participant)
                            .toString()),
                        participant: participant,
                        participantProvider:
                            Provider.of<ParticipantProvider>(context),
                        study: Provider.of<StudyInfo>(context),
                        index: Provider.of<ParticipantProvider>(context)
                            .participants
                            .indexOf(participant),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
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
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    // Your existing content goes here
    // Replace this with your actual content widgets
    // For example: MyListView(), MyGridView(), etc.
    ActivitiesPage(),
    ParticipantsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // // Handle navigation to different pages here
    // if (_selectedIndex == 2) {
    //   // Open the settings page
    //   _openSettingsPage();
    // }
  }

  void _addActivity() {
    setState(() {
      // Add a new activity to the list in provider
      Provider.of<ActivityProvider>(context, listen: false).addActivity(
          Activity.defaultActivity(
              Provider.of<ActivityProvider>(context, listen: false),
              Provider.of<StudyInfo>(context, listen: false),
              Provider.of<ParticipantProvider>(context, listen: false)));
    });
  }

  void _addParticipant() {
    setState(() {
      // Add a new participant to the list in provider
      Provider.of<ParticipantProvider>(context, listen: false).addParticipant(
          ParticipantProvider.defaultParticipant(
              Provider.of<StudyInfo>(context, listen: false),
              Provider.of<ParticipantProvider>(context, listen: false)));
    });
    print(Provider.of<ParticipantProvider>(context, listen: false).toString());
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
                  Provider.of<ParticipantProvider>(context, listen: true)),
        );
      },
    );
  }

  void _openSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Participants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_export),
            label: 'Import/Export',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      // Button to add activity on the right and settings button on the left
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _addActivity,
            tooltip: 'Add activity',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _addParticipant,
            tooltip: 'Add participant',
            child: const Icon(Icons.person),
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
