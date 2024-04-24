import 'dart:ffi';

import 'package:dm_log/data/participant_entry.dart';
import 'package:dm_log/data/participant_info.dart';
import 'package:dm_log/data/study_info.dart';
import 'package:flutter/material.dart';
import '../data/activity.dart';
import '../data/activity_provider.dart';

class PartRow extends StatefulWidget {
  final ParticipantInfo participant;
  final ParticipantEntry participantProvider;
  final StudyInfo study;
  final int index;

  const PartRow({
    Key? key,
    required this.participant,
    required this.participantProvider,
    required this.study,
    required this.index,
  }) : super(key: key);

  @override
  _ParticipantRowState createState() => _ParticipantRowState();
}

class _ParticipantRowState extends State<PartRow> {
  TextEditingController timeStartedController = TextEditingController();
  TextEditingController timeEndedController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    timeStartedController.text = _formatTime(now);
    widget.participant.vestOn = timeStartedController.text;
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
              _activityDetailsRow(),
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
      "Participant ${widget.index + 1}",
      style: const TextStyle(fontSize: 20),
    );
  }

  Row _activityDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _subjectIDColumn(),
        _nameColumn(),
        _LENAIDDropDownColumn(),
        _timeDetailColumn(
          title: "Vest On",
          controller: timeStartedController,
          onIconPressed: () {
            DateTime now = DateTime.now();
            timeStartedController.text = _formatTime(now);
            widget.participant.vestOn = timeStartedController.text;
          },
        ),
        _timeDetailColumn(
          title: "Vest Off",
          controller: timeEndedController,
          onIconPressed: () {
            DateTime now = DateTime.now();
            timeEndedController.text = _formatTime(now);
            widget.participant.vestOff = timeEndedController.text;
          },
        ),
        //_involvedDetail(),
        _typeDropdownDetail(),
        //
      ],
    );
  }

//***
//
// NEW ROW EDIT
//
// */

  Row _activityAdditionalDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _shortIDColumn(),
        _leftTagColumn(),
        _rightTagColumn(),
        _sonyIDColumn(),
      ],
    );
  }

//***
  //
  // EDIT FOR NEW Short ID
  //
  // */

   Column _shortIDColumn() {
    return Column(
      children: [
        const Text("Short ID", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              //controller: commentsController,     
              //QUESTION ABOUT CONTROLLER (HAS DEFAULT create its own [TextEditingController])
              onChanged: (value) {
                widget.participant.shortID = value;    
              },
            ),
          ),
        ),
      ],
    );
  }


//***
  //
  // EDIT FOR NEW Left tag
  //
  // */

   Column _leftTagColumn() {
    return Column(
      children: [
        const Text("Left Tag", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              //controller: commentsController,     
              //QUESTION ABOUT CONTROLLER (HAS DEFAULT create its own [TextEditingController])
              onChanged: (value) {
                widget.participant.leftTag = value;    
              },
            ),
          ),
        ),
      ],
    );
  }


  //***
  //
  // EDIT FOR NEW Right Tag
  //
  // */

   Column _rightTagColumn() {
    return Column(
      children: [
        const Text("Right Tag", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              //controller: commentsController,     
              //QUESTION ABOUT CONTROLLER (HAS DEFAULT create its own [TextEditingController])
              onChanged: (value) {
                widget.participant.rightTag = value;    
              },
            ),
          ),
        ),
      ],
    );
  }


  //***
  //
  //EDIT FOR NEW Subject ID
  //
  // */

   Column _subjectIDColumn() {
    return Column(
      children: [
        const Text("Subject ID", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              //controller: commentsController,     
              //QUESTION ABOUT CONTROLLER (HAS DEFAULT create its own [TextEditingController])
              onChanged: (value) {
                widget.participant.subjectID = value;    
              },
            ),
          ),
        ),
      ],
    );
  }


  //***
  //
  //EDIT FOR NEW Subject ID
  //
  // */

   Column _sonyIDColumn() {
    return Column(
      children: [
        const Text("Sony ID", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              //controller: commentsController,     
              //QUESTION ABOUT CONTROLLER (HAS DEFAULT create its own [TextEditingController])
              onChanged: (value) {
                widget.participant.sonyID = value;    
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _nameColumn() {
    return Column(
      children: [
        const Text("Name", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              controller: commentsController,
              onChanged: (value) {
                widget.participant.name = value;
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _LENAIDDropDownColumn() {
    return Column(
      children: [
        const Text("LENA ID", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: DropdownButton<String>(
              value: widget.participant.lenaID,
              onChanged: (String? newValue) {
                setState(() {
                  widget.participant.lenaID = newValue!;
                });
              },
              items: widget.study.lenaIDs
                  .map<DropdownMenuItem<String>>((String value) {
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
                      widget.participant.vestOn = value;
                    } else {
                      widget.participant.vestOff = value;
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

// make docstring

/*
  Column _involvedDetail() {
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
                              for (String key in widget.data.involved.keys)
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
*/
  Column _typeDropdownDetail() {
    return Column(children: [
      const Text("LENA Off", style: TextStyle(fontSize: 15)),
      Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10),
        width: 100,
        height: 65,
        padding: const EdgeInsets.all(8),
        decoration: _boxDecoration(),
        child: Center(
          child: DropdownButton<bool>(
            value: widget.participant.lenaOff,
            onChanged: (bool? newValue) {
              setState(() {
                widget.participant.lenaOff = newValue!;
              });
            },
            items:
                <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
              return DropdownMenuItem<bool>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
        ),
      )
    ]);
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

  /*
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
  */
  Column _commentDetail() {
    return Column(
      children: [
        const Text("Name", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: 100,
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
                      widget.participant.status = value;
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
                                    widget.participant.notes +=
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
            widget.participantProvider.removeParticipant(widget.participant);
          },
        ),
      ),
    );
  }
}
