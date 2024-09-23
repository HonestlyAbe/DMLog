import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dm_log/data/activity_provider.dart';
import 'package:dm_log/data/participant_info.dart';
import 'package:dm_log/data/participant_provider.dart';
import 'package:flutter/material.dart';
import 'package:dm_log/data/study_info.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;
import 'package:file_picker/file_picker.dart';

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
          exportData(_studyNameController.text, widget.participants);
        },
        child: const Text('Export Data'),
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          pickAndImportFile(context, widget.participants, widget.study);
        },
        child: const Text('Import CSV'),
      ),
    ]);
  }
}

exportData(String filename, ParticipantProvider participants) {
  // Looking to make a sheet like this:
  // Row 1: "SUBJECTS INFO"
  // Row 2: Short_ID | Default Left Tag | Default Right Tag | Default LENA | Default SONY ID | LENA ON | LENA OFF | VEST ON Starts | VEST OFF Expires | STATUS | Subject_ID | TYPE | Notes
  // Rows 3-n: Corresponding data in each column from participant provider
  // using the exportCSV library to create a CSV file
  List<String> headermain = [];
  List<List<String>> csvList = [];
  //List<Str
  headermain.add("Short_ID");
  headermain.add("Default Left Tag");
  headermain.add("Default Right Tag");
  headermain.add("Default Lena");
  headermain.add("Default SONY ID");
  headermain.add("LENA ON");
  headermain.add("LENA OFF");
  headermain.add("VEST ON Starts");
  headermain.add("VEST OFF Expires");
  headermain.add("STATUS");
  headermain.add("Subject_ID");
  headermain.add("TYPE");
  headermain.add("Notes");
  csvList.add(headermain);
  headermain = ["SUBJECTS INFO"];
  for (int i = 0; i < participants.participants.length; i++) {
    List<String> temp = [];
    temp.add(participants.participants[i].subjectID);
    temp.add(participants.participants[i].ULeft);
    temp.add(participants.participants[i].URight);
    temp.add(participants.participants[i].lenaID);
    temp.add(participants.participants[i].sonyID);
    temp.add("");
    temp.add(participants.participants[i].lenaOff);
    temp.add(participants.participants[i].vestOn);
    temp.add(participants.participants[i].vestOff);
    temp.add(participants.participants[i].status);
    temp.add(participants.participants[i].subjectID);
    temp.add(participants.participants[i].type);
    temp.add(participants.participants[i].notes);
    csvList.add(temp);
  }
  exportCSV.myCSV(headermain, csvList);
}

Future<void> pickAndImportFile(BuildContext context,
    ParticipantProvider participants, StudyInfo study) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.single.path != null) {
      String filePath = result.files.single.path!;
      ParticipantProvider updatedParticipants =
          await importData(filePath, participants, study);
      // Handle the updated participants as needed
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected')),
      );
    }
  } catch (e) {
    // Handle any errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error picking file: $e')),
    );
  }
}

Future<ParticipantProvider> importData(
    String filePath, ParticipantProvider participants, StudyInfo study) async {
  ParticipantProvider temp = ParticipantProvider();

  final file = File(filePath);
  Stream<List<int>> inputStream = file.openRead();

  bool firstLine = true;

  await for (var line
      in inputStream.transform(utf8.decoder).transform(LineSplitter())) {
    if (firstLine) {
      firstLine = false;
      continue;
    }

    List<String> row = line.split(',');
    ParticipantInfo tempParticipant = ParticipantInfo(
      study: study,
      provider: participants,
      name: row[0],
      timeEntered: row[1],
      lenaID: row[2],
      lenaNum: row[3],
      vestOn: row[4],
      vestOff: row[5],
      lenaOff: row[6],
      status: row[7],
      ULeft: row[8],
      URight: row[9],
      type: row[10],
      subjectID: row[11],
      sonyID: row[12],
      notes: row[13],
    );
    temp.addParticipant(tempParticipant);
  }
  return temp;
}
