import 'package:dm_log/data/activity_provider.dart';
import 'package:dm_log/data/participant_provider.dart';
import 'package:flutter/material.dart';
import 'package:dm_log/data/study_info.dart';

class Settings extends StatefulWidget {
  final StudyInfo study;
  final ParticipantProvider participants;
  final ActivityProvider activities;
  const Settings(
      {Key? key,
      required this.study,
      required this.participants,
      required this.activities})
      : super(key: key);
  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  // study name variable
  late TextEditingController _studyNameController;
  @override
  Widget build(BuildContext context) {
    // text box for study name
    _studyNameController = TextEditingController(text: widget.study.studyName);
    return Column(children: <Widget>[
      // Study Name
      Padding(
        padding: const EdgeInsets.fromLTRB(128, 8, 128, 8),
        child: TextField(
          controller: _studyNameController,
          decoration: const InputDecoration(
            labelText: 'File Name',
          ),
          onChanged: (value) {
            widget.study.studyName = value;
          },
        ),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          exportData(_studyNameController.text);
        },
        child: const Text('Export Data'),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          importData(_studyNameController.text);
        },
        child: const Text('Import Data'),
      ),
    ]);
  }

  void exportData(String filename) {}

  void importData(String filename) {}
}
