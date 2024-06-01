import 'package:dm_log/data/participant_provider.dart';
import 'package:dm_log/data/participant_info.dart';
import 'package:dm_log/data/study_info.dart';
import 'package:flutter/material.dart';

class PartRow extends StatefulWidget {
  final ParticipantInfo participant;
  final ParticipantProvider participantProvider;
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
  TextEditingController vestOnController = TextEditingController();
  TextEditingController vestOffController = TextEditingController();

  @override
  void initState() {
    super.initState();
    vestOnController.text = widget.participant.vestOn;
    vestOffController.text = widget.participant.vestOff;
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
              _participantTitle(),
              const SizedBox(height: 10),
              _participantsDetailsRow(),
              const SizedBox(height: 10),
              _participantsAdditionalDetailsRow(),
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

  Text _participantTitle() {
    return Text(
      "Participant ${widget.index + 1}",
      style: const TextStyle(fontSize: 20),
    );
  }

  Row _participantsDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _subjectIDColumn(),
        _nameColumn(),
        _LENAIDDropDownColumn(),
        _timeDetailColumn(
          title: "Vest On",
          controller: vestOnController,
          onIconPressed: () {
            DateTime now = DateTime.now();
            vestOnController.text = _formatTime(now);
            widget.participant.vestOn = vestOnController.text;
            widget.participantProvider.updateParticipant(
              widget.participant,
              vestOnController.text,
              ParticipantAttribute.vestOn,
            );
          },
        ),
        _timeDetailColumn(
          title: "Vest Off",
          controller: vestOffController,
          onIconPressed: () {
            DateTime now = DateTime.now();
            vestOffController.text = _formatTime(now);
            widget.participant.vestOff = vestOffController.text;
            widget.participantProvider.updateParticipant(
              widget.participant,
              vestOffController.text,
              ParticipantAttribute.vestOff,
            );
          },
        ),
        //_involvedDetail(),
        _LENADropdownDetail(),
        //
      ],
    );
  }

  Row _participantsAdditionalDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _leftTagColumn(),
        _rightTagColumn(),
        _sonyIDColumn(),
        _typeColumn(),
        _statusColumn(),
        _notesColumn(),
      ],
    );
  }

  Column _notesColumn() {
    return Column(
      children: [
        const Text("Notes", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  widget.participant.notes = value;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    value,
                    ParticipantAttribute.notes,
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _leftTagColumn() {
    return Column(
      children: [
        const Text("ULeft", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  widget.participant.ULeft = value;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    value,
                    ParticipantAttribute.ULeft,
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _rightTagColumn() {
    return Column(
      children: [
        const Text("URight", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  widget.participant.URight = value;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    value,
                    ParticipantAttribute.URight,
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }

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
              onChanged: (value) {
                setState(() {
                  widget.participant.subjectID = value;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    value,
                    ParticipantAttribute.subjectID,
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }

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
              onChanged: (value) {
                setState(() {
                  widget.participant.sonyID = value;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    value,
                    ParticipantAttribute.sonyID,
                  );
                });
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
              onChanged: (String value) {
                setState(() {
                  widget.participant.name = value;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    value,
                    ParticipantAttribute.name,
                  );
                });
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
        const Text("LenaID", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 100,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  widget.participant.lenaID = value;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    value,
                    ParticipantAttribute.lenaID,
                  );
                });
              },
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
          margin: const EdgeInsets.only(right: 10),
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

  Column _LENADropdownDetail() {
    return Column(children: [
      const Text("LENA Off", style: TextStyle(fontSize: 15)),
      Container(
        margin: const EdgeInsets.only(right: 10),
        width: 100,
        height: 65,
        padding: const EdgeInsets.all(8),
        decoration: _boxDecoration(),
        child: Center(
          child: DropdownButton<bool>(
            value: widget.participant.lenaOff == 'True' ? true : false,
            onChanged: (bool? newValue) {
              setState(() {
                widget.participant.lenaOff = newValue! ? "True" : "False";
                widget.participantProvider.updateParticipant(
                  widget.participant,
                  widget.participant.lenaOff,
                  ParticipantAttribute.lenaOff,
                );
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

  Column _typeColumn() {
    return Column(
      children: [
        const Text("Type", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 110,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: DropdownButton<String>(
              value: widget.participant.type,
              onChanged: (String? newValue) {
                setState(() {
                  widget.participant.type = newValue!;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    newValue,
                    ParticipantAttribute.type,
                  );
                });
              },
              items: <String>['student', 'adult']
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

  Column _statusColumn() {
    return Column(
      children: [
        const Text("Status", style: TextStyle(fontSize: 15)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 110,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: _boxDecoration(),
          child: Center(
            child: DropdownButton<String>(
              value: widget.participant.status,
              onChanged: (String? newValue) {
                setState(() {
                  widget.participant.status = newValue!;
                  widget.participantProvider.updateParticipant(
                    widget.participant,
                    newValue,
                    ParticipantAttribute.status,
                  );
                });
              },
              items: <String>['Present', 'Absent', 'No Data']
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

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      color: Colors.white,
    );
  }

  Container _deleteButton() {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 20),
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
