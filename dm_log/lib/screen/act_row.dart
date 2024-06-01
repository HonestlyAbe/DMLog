import 'package:flutter/material.dart';
import 'package:dm_log/data/study_info.dart';
import '../data/activity.dart';
import '../data/activity_provider.dart';
import '../data/participant_provider.dart';

class ActivityRow extends StatefulWidget {
  final Activity data;
  final ActivityProvider activityProvider;
  final ParticipantProvider participantProvider;
  final StudyInfo study;
  final int index;

  const ActivityRow({
    Key? key,
    required this.data,
    required this.activityProvider,
    required this.participantProvider,
    required this.study,
    required this.index,
  }) : super(key: key);

  @override
  _ActivityRowState createState() => _ActivityRowState();
}

class _ActivityRowState extends State<ActivityRow> {
  TextEditingController timeStartedController = TextEditingController();
  TextEditingController timeEndedController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    timeStartedController.text = _formatTime(now);
    widget.data.timeStarted = timeStartedController.text;
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: 750,
          decoration: _containerDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _activityTitle(),
              const SizedBox(height: 10),
              _activityDetailsRow(
                  participantProvider: widget.participantProvider),
              _activityAdditionalDetailsRow(),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.blueGrey[50],
      border: Border.all(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Text _activityTitle() {
    return Text(
      "Activity ${widget.index + 1}",
      style: const TextStyle(fontSize: 20),
    );
  }

  Row _activityDetailsRow({required ParticipantProvider participantProvider}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timeDetailColumn(
          title: "Time Started",
          controller: timeStartedController,
          onIconPressed: () {
            DateTime now = DateTime.now();
            timeStartedController.text = _formatTime(now);
            widget.data.timeStarted = timeStartedController.text;
          },
        ),
        _timeDetailColumn(
          title: "Time Ended",
          controller: timeEndedController,
          onIconPressed: () {
            DateTime now = DateTime.now();
            timeEndedController.text = _formatTime(now);
            widget.data.timeEnded = timeEndedController.text;
          },
        ),
        _involvedDetail(participantProvider: participantProvider),
        _typeDropdownDetail(),
      ],
    );
  }

  Column _timeDetailColumn({
    required String title,
    required TextEditingController controller,
    required VoidCallback onIconPressed,
  }) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.all(10),
          width: 120,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: onIconPressed,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (title == "Time Started") {
                      widget.data.timeStarted = value;
                    } else {
                      widget.data.timeEnded = value;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _involvedDetail({required ParticipantProvider participantProvider}) {
    return Column(
      children: [
        const Text("Involved", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) => AlertDialog(
                        title: const Text("Involved"),
                        content: SizedBox(
                          width: 300,
                          height: 300,
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            children: <Widget>[
                              for (String key in participantProvider
                                  .participants
                                  .map((p) => p.name))
                                Column(children: <Widget>[
                                  Text(key),
                                  Checkbox(
                                    value: widget.data.involved[key],
                                    onChanged: (value) {
                                      widget.data.involved[key] = value as bool;
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
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _typeDropdownDetail() {
    return Column(
      children: [
        const Text("Type", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: DropdownButton<String>(
              value: widget.data.type,
              onChanged: (newValue) {
                setState(() {
                  widget.data.type = newValue!;
                });
              },
              items: widget.study.studyActivities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Column _countDetailColumn({
    required String title,
    required int count,
    required VoidCallback onMinusPressed,
    required VoidCallback onPlusPressed,
  }) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 15)),
        Container(
          margin: title == "Child Count"
              ? const EdgeInsets.only(right: 10)
              : const EdgeInsets.all(0),
          width: 125,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: onMinusPressed,
                ),
                Text(count.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: onPlusPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      color: Colors.white,
    );
  }

  Row _activityAdditionalDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _countDetailColumn(
          title: "Adult Count",
          count: widget.data.adultCount,
          onMinusPressed: () {
            if (widget.data.adultCount > 0) {
              setState(() => widget.data.adultCount--);
            }
          },
          onPlusPressed: () => setState(() => widget.data.adultCount++),
        ),
        _countDetailColumn(
          title: "Child Count",
          count: widget.data.childCount,
          onMinusPressed: () {
            if (widget.data.childCount > 0) {
              setState(() => widget.data.childCount--);
            }
          },
          onPlusPressed: () => setState(() => widget.data.childCount++),
        ),
        _commentDetail(),
        _deleteButton(),
      ],
    );
  }

  Column _commentDetail() {
    return Column(
      children: [
        const Text("Comment", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: 250,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: Row(
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
                              itemCount: widget.study.quickComments.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                  onPressed: () {
                                    commentsController.text +=
                                        "${widget.study.quickComments[index]} ";
                                    widget.data.comment +=
                                        "${widget.study.quickComments[index]} ";
                                    Navigator.of(context).pop();
                                  },
                                  child:
                                      Text(widget.study.quickComments[index]),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _deleteButton() {
    return Container(
      margin: const EdgeInsets.only(top: 18, left: 5),
      width: 100,
      height: 65,
      padding: const EdgeInsets.all(8),
      decoration: _boxDecoration(),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            widget.activityProvider.removeActivity(widget.data);
          },
        ),
      ),
    );
  }
}
