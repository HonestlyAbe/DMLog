import 'package:dm_log/data/activity_provider.dart';
import 'package:dm_log/data/participant_entry.dart';
import 'package:flutter/material.dart';
import 'package:dm_log/data/study_info.dart';
import 'package:dm_log/data/participant_info.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  final StudyInfo study;
  final ParticipantEntry participants;
  final ActivityProvider activities;
  const Settings(
      {Key? key,
      required this.study,
      required this.participants,
      required this.activities})
      : super(key: key);
  @override
  State<Settings> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Settings> {
  // initit the study from parameter
  List<Widget> pages = [];
  int current = 0;

  @override
  void initState() {
    pages = [
      PartPage(
        study: widget.study,
        participants: widget.participants,
      ),
      CommentsPage(study: widget.study),
      const ActivityGuide(),
      StudyInfoPage(
          study: widget.study,
          participants: widget.participants,
          activities: widget.activities),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Return a widget for our settings
    return Container(
        width: 400,
        height: 400,
        child: Column(
          children: [
            Expanded(child: pages[current]),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Study info",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bolt),
                  label: "Quick comments",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner),
                  label: "Activity Guide",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Study info",
                ),
              ],
              onTap: (int index) {
                setState(() {
                  current = index;
                });
              },
              currentIndex: current,
            ),
          ],
        ));
  }
}

class PartPage extends StatefulWidget {
  const PartPage({Key? key, required this.study, required this.participants})
      : super(key: key);
  final StudyInfo study;
  final ParticipantEntry participants;
  @override
  State<PartPage> createState() => _PartPageState();
}

class _PartPageState extends State<PartPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Add participant',
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // Add participant to provider
            widget.study.addParticipant(controller.text);
            widget.participants
                .addParticipant(ParticipantInfo(name: controller.text));
            setState(() {});
            controller.clear();
          },
        ),
        // List of participants
        Expanded(
          child: ListView.builder(
            itemCount: widget.participants.participants.length,
            itemBuilder: (BuildContext context, int index) {
              return ParticipantRow(
                participant: widget.participants.participants[index],
                study: widget.study,
                participants: widget.participants,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ParticipantRow extends StatelessWidget {
  const ParticipantRow(
      {Key? key,
      required this.participant,
      required this.study,
      required this.participants})
      : super(key: key);
  final ParticipantEntry participants;
  final ParticipantInfo participant;
  final StudyInfo study;

  @override
  Widget build(BuildContext context) {
    TextEditingController timeEntered =
        TextEditingController(text: participant.timeEntered);
    TextEditingController altId =
        TextEditingController(text: participant.altId);
    // returns a widget for our row titles with a button to remove the participant
    return Container(
      width: 600,
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Text(participant.getName()),
            const SizedBox(width: 30),
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  // Button that captures the current time in hours and minutes
                  IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () {
                      DateTime now = DateTime.now();
                      timeEntered.text =
                          "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
                      participants.updateParticipant(
                          participant,
                          "${now.hour}:${now.minute.toString().padLeft(2, '0')}",
                          "timeEntered");
                    },
                  ),
                  // Textfield with controller
                  Expanded(
                    child: TextField(
                      controller: timeEntered,
                      onChanged: (value) {
                        participants.updateParticipant(
                            participant, value, "timeEntered");
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            SizedBox(
              width: 100,
              child: TextField(
                controller: altId,
                decoration: const InputDecoration(
                  labelText: 'Alternative identifier',
                ),
                onChanged: (String value) {
                  participants.updateParticipant(participant, value, "altId");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key, required this.study}) : super(key: key);
  final StudyInfo study;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    // Adds a textfield to add comments to the provider
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Add comment',
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // Add comment to provider
            widget.study.addComment(controller.text);
            setState(() {});
            controller.clear();
          },
        ),
        // List of comments
        //stateful builder
        Expanded(
          child: ListView.builder(
            itemCount: widget.study.quickComments.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(widget.study.quickComments[index]);
            },
          ),
        ),
      ],
    );
  }
}

class StudyValues extends StatefulWidget {
  const StudyValues({Key? key, required this.study}) : super(key: key);
  final StudyInfo study;
  @override
  State<StudyValues> createState() => _StudyValuesState();
}

class _StudyValuesState extends State<StudyValues> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        children: [
          const Text("File Name", style: TextStyle(fontSize: 15)),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 117,
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
            ),
            child: Center(
              child: TextField(
                controller: TextEditingController(text: widget.study.studyName),
                onChanged: (value) {
                  widget.study.studyName = value;
                },
              ),
            ),
          )
        ],
      ),
      Column(
        children: [
          const Text("Adult Count", style: TextStyle(fontSize: 15)),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 125,
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
            ),
            child: Center(
                child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (widget.study.adultCount > 0) {
                      widget.study.adultCount--;
                      setState(() {});
                    }
                  },
                ),
                Text(widget.study.adultCount.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    widget.study.adultCount++;
                    setState(() {});
                  },
                ),
              ],
            )),
          ),
        ],
      ),
      Column(
        children: [
          const Text("Child Count", style: TextStyle(fontSize: 15)),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 125,
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
            ),
            child: Center(
                child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (widget.study.childCount > 0) {
                      widget.study.childCount--;
                      setState(() {});
                    }
                  },
                ),
                Text(widget.study.childCount.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    widget.study.childCount++;
                    setState(() {});
                  },
                ),
              ],
            )),
          ),
        ],
      ),
    ]);
  }
}

// This class is used to export the studyinfo to a csv file
class StudyInfoPage extends StatefulWidget {
  const StudyInfoPage(
      {Key? key,
      required this.study,
      required this.participants,
      required this.activities})
      : super(key: key);
  final StudyInfo study;
  final ParticipantEntry participants;
  final ActivityProvider activities;
  @override
  State<StudyInfoPage> createState() => _ExportStudyState();
}

class _ExportStudyState extends State<StudyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      StudyValues(study: widget.study),
      //button to export study
      TextButton(
        child: const Text("Copy Participant Infos"),
        onPressed: () {
          Clipboard.setData(
              ClipboardData(text: widget.participants.toString()));
        },
      ),
      TextButton(
        child: const Text("Copy Activity Infos"),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: widget.activities.toString()));
        },
      ),
    ]);
  }
}

class ActivityGuide extends StatelessWidget {
  const ActivityGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        'General play time (GP): Child playing on their own initiative. Playing with various toys. Free play time.\n',
        'Organization play time (OrP): Activity the child sits down for focus and engage in (painting, coloring, puzzles) by teacher.\n',
        'Outside play time (OuP): Occurs ourside on the playground\n',
        'Story time (S): Listens to or engages in books for more than 2 minutes\n',
        'Circle time (C): Circle group activity\n',
        'Meal time (M): Given food, sitting in chair; breakfast, snack or lunch\n',
        'Personal Care (PC): Diaper changing, bathroom, hand washing\n',
        'Nap time (N): Time on mat\n',
        'Therapy (T): Child leaves room to go to therapy\n',
        'Transition (Trans): Transition between rooms/locations (e.g. walking to go outide or to another classroom',
      ].map((String text) => Text(text)).toList(),
    );
  }
}
