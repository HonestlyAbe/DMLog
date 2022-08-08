import 'package:flutter/material.dart';
import 'package:dm_log/data/study_info.dart';
import '../data/activity.dart';
import '../data/activity_provider.dart';

class ActivityRow extends StatefulWidget {
  final Activity data;
  final ActivityProvider activityProvider;
  final StudyInfo study;
  final int index;
  const ActivityRow(
      {Key? key,
      required this.data,
      required this.activityProvider,
      required this.study,
      required this.index})
      : super(key: key);

  @override
  State<ActivityRow> createState() => _ActivityRowState();
}

class _ActivityRowState extends State<ActivityRow> {
  TextEditingController timeStartedController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController timeEndedController = TextEditingController();
  @override
  void initState() {
    DateTime now = DateTime.now();
    timeStartedController = TextEditingController(
        text: "${now.hour}:${now.minute.toString().padLeft(2, '0')}");
    widget.data.timeStarted = timeStartedController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Create text editting controller
    return Column(
      children: [
        Container(
          height: 250,
          width: 750,
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Activity ${widget.index + 1}",
                style: const TextStyle(fontSize: 20)),
            Container(
              height: 2,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Time Started
              Column(
                children: [
                  const Text("Time Started", style: TextStyle(fontSize: 15)),
                  Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: 120,
                      height: 65,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Row(
                        children: [
                          // Button that captures the current time in hours and minutes
                          IconButton(
                            icon: const Icon(Icons.access_time),
                            onPressed: () {
                              DateTime now = DateTime.now();
                              timeStartedController.text =
                                  "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
                              widget.data.timeStarted =
                                  timeStartedController.text;
                            },
                          ),
                          // Textfield with controller
                          Expanded(
                            child: TextField(
                              controller: timeStartedController,
                              onChanged: (value) {
                                widget.data.timeStarted = value;
                              },
                            ),
                          ),
                        ],
                      ))),
                ],
              ),
              // Time Ended
              Column(
                children: [
                  const Text("Time Ended", style: TextStyle(fontSize: 15)),
                  Container(
                      margin: const EdgeInsets.only(bottom: 10, right: 10),
                      width: 120,
                      height: 65,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Row(
                        children: [
                          // Button that captures the current time in hours and minutes
                          IconButton(
                            icon: const Icon(Icons.access_time),
                            onPressed: () {
                              DateTime now = DateTime.now();
                              timeEndedController.text =
                                  "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
                              widget.data.timeEnded = timeEndedController.text;
                            },
                          ),
                          // Textfield with controller
                          Expanded(
                            child: TextField(
                              controller: timeEndedController,
                              onChanged: (value) {
                                widget.data.timeEnded = value;
                              },
                            ),
                          ),
                        ],
                      ))),
                ],
              ),
              // Involved Grid
              Column(
                children: [
                  const Text("Involved", style: TextStyle(fontSize: 15)),
                  Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, right: 10, left: 10),
                      width: 100,
                      height: 65,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Center(
                        child:
                            // Button that opens a pop-up
                            IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: ((context, setState) =>
                                        AlertDialog(
                                          title: const Text("Involved"),
                                          content: // Grid with checkboxes using involved dictionary
                                              SizedBox(
                                            width: 300,
                                            height: 300,
                                            child: GridView.count(
                                              shrinkWrap: true,
                                              crossAxisCount: 4,
                                              children: <Widget>[
                                                for (String key in widget
                                                    .data.involved.keys)

                                                  // Make column with title and checkbox
                                                  Column(children: <Widget>[
                                                    Text(key),
                                                    Checkbox(
                                                      value: widget
                                                          .data.involved[key],
                                                      onChanged: (value) {
                                                        widget.data
                                                                .involved[key] =
                                                            value as bool;
                                                        setState(() {});
                                                      },
                                                    )
                                                  ]),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        )));
                              },
                            );
                          },
                        ),
                      )),
                ],
              ),
              // Type Dropdown
              Column(
                children: [
                  const Text("Type", style: TextStyle(fontSize: 15)),
                  Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 10),
                      width: 100,
                      height: 65,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: DropdownButton<String>(
                              value: widget.data.type,
                              onChanged: (newValue) {
                                widget.data.type = newValue as String;
                                setState(() {});
                              },
                              items: widget.study.studyActivities
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()))),
                ],
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Adult Count
                Column(
                  children: [
                    const Text("Adult Count", style: TextStyle(fontSize: 15)),
                    Container(
                      width: 125,
                      height: 65,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Center(
                          child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (widget.data.adultCount > 0) {
                                widget.data.adultCount--;
                                setState(() {});
                              }
                            },
                          ),
                          Text(widget.data.adultCount.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              widget.data.adultCount++;
                              setState(() {});
                            },
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
                // Child Count
                Column(
                  children: [
                    const Text("Child Count", style: TextStyle(fontSize: 15)),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 125,
                      height: 65,
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
                              if (widget.data.childCount > 0) {
                                widget.data.childCount--;
                                setState(() {});
                              }
                            },
                          ),
                          Text(widget.data.childCount.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              widget.data.childCount++;
                              setState(() {});
                            },
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
                // Comment
                Column(
                  children: [
                    const Text("Comment", style: TextStyle(fontSize: 15)),
                    Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: 250,
                        height: 65,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: // row with a textfield and button that opens a pop-up
                                Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: commentsController,
                                onChanged: (value) {
                                  widget.data.comment = value;
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.quickreply_outlined),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Quick Select"),
                                      content: SizedBox(
                                        width: 300,
                                        height: 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: widget
                                                .study.quickComments.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              // Create text button that adds the value of the key to the comment
                                              return TextButton(
                                                onPressed: () {
                                                  commentsController.text +=
                                                      "${widget.study.quickComments[index]} ";
                                                  widget.data.comment +=
                                                      "${widget.study.quickComments[index]} ";
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(widget.study
                                                    .quickComments[index]),
                                              );
                                            }),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ))),
                  ],
                ),
                // Button to delete the activity
                Container(
                    margin: const EdgeInsets.only(top: 18, left: 5),
                    width: 100,
                    height: 65,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        widget.activityProvider.removeActivity(widget.data);
                      },
                    ))),
              ],
            ),
          ]),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
