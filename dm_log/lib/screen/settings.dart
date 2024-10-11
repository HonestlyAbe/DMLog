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
import 'package:dm_log/screen/act_row.dart';

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
  TextEditingController ubiStartTimeController = TextEditingController();
  late TextEditingController ubiEndTimeController = TextEditingController();

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      color: Colors.white,
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
                    if (title == "UBI Start Time") {
                      ubiStartTimeController.text = value;
                    } else {
                      ubiEndTimeController.text = value;
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

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    // text box for study name
    _studyNameController = TextEditingController(text: widget.study.studyName);
    return Column(
      children: <Widget>[
        /* 
      OBSERVATION INFO	
UBI START TIME	REAL TIME
BEEP TIME	ENTERED BY USER
OBSERVER	ENTERED BY USER
TECH PERSON	ENTERED BY USER
UBI RUNNING	YES/NO
UBI END TIME	REAL TIME BUTTON
PIC TAKEN	YES/NO
CLASS DIMENSION UNCHANGED	YES/NO
TRACK START	FORMULA
TRACK END	FORMULA
TIME TRACKED	FORMULA
     */
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _timeDetailColumn(
              title: "UBI Start Time",
              controller: ubiStartTimeController,
              onIconPressed: () {
                DateTime now = DateTime.now();
                ubiStartTimeController.text = _formatTime(now);
                widget.study.ubiStartTime = ubiStartTimeController.text;
              },
            ),
            _timeDetailColumn(
              title: "Time Ended",
              controller: ubiEndTimeController,
              onIconPressed: () {
                DateTime now = DateTime.now();
                ubiEndTimeController.text = _formatTime(now);
                widget.study.ubiEndTime = ubiEndTimeController.text;
              },
            ),
            // drop down for UBI Running
            // drop down for Pic Taken
            // drop down for Class Dimension Unchanged
            Column(
              children: [
                const Text("UBI Running", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, top: 10, right: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: Center(
                    child: DropdownButton<String>(
                      value: widget.study.ubiRunning,
                      onChanged: (newValue) {
                        setState(() {
                          widget.study.ubiRunning = newValue!;
                        });
                      },
                      items: <String>['Yes', 'No'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                const Text("Picture Taken", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, top: 10, right: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: Center(
                    child: DropdownButton<String>(
                      value: widget.study.picTaken,
                      onChanged: (newValue) {
                        setState(() {
                          widget.study.picTaken = newValue!;
                        });
                      },
                      items: <String>['Yes', 'No'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                const Text("Same Dimensions", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 10, top: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: Center(
                    child: DropdownButton<String>(
                      value: widget.study.classDimensionUnchanged,
                      onChanged: (newValue) {
                        setState(() {
                          widget.study.classDimensionUnchanged = newValue!;
                        });
                      },
                      items: <String>['Yes', 'No'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        /* 
BEEP TIME	(TEXT)
OBSERVER	(TEXT)
TECH PERSON	(TEXT)
TRACK START	(TEXT)
TRACK END	(TEXT)
TIME TRACKED	(TEXT)
     */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // input box for beep time
            Column(
              children: [
                const Text("Beep Time", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, top: 10, right: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: TextField(
                    onChanged: (value) {
                      widget.study.beepTime = value;
                    },
                  ),
                ),
              ],
            ),
            // input box for observer
            Column(
              children: [
                const Text("Observer", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, top: 10, right: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: TextField(
                    onChanged: (value) {
                      widget.study.observer = value;
                    },
                  ),
                ),
              ],
            ),
            // input box for tech person
            Column(
              children: [
                const Text("Tech Person", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, top: 10, right: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: TextField(
                    onChanged: (value) {
                      widget.study.techPerson = value;
                    },
                  ),
                ),
              ],
            ),
            // input box for track start
            Column(
              children: [
                const Text("Track Start", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, top: 10, right: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: TextField(
                    onChanged: (value) {
                      widget.study.trackStart = value;
                    },
                  ),
                ),
              ],
            ),
            // input box for track end
            Column(
              children: [
                const Text("Track End", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, top: 10, right: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: TextField(
                    onChanged: (value) {
                      widget.study.trackEnd = value;
                    },
                  ),
                ),
              ],
            ),
            // input box for time tracked
            Column(
              children: [
                const Text("Time Tracked", style: TextStyle(fontSize: 15)),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 10, left: 10, top: 10, right: 10),
                  width: 100,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: _boxDecoration(),
                  child: TextField(
                    onChanged: (value) {
                      widget.study.timeTracked = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),

        // Study Name
        Padding(
          padding: const EdgeInsets.fromLTRB(128, 8, 128, 8),
          child: SizedBox(
            width: 500,
            height: 65,
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
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            exportData(_studyNameController.text, widget.participants,
                widget.study, widget.activities);
          },
          child: const Text('Export CSV'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            pickAndImportFile(context, widget.participants, widget.study);
          },
          child: const Text('Import CSV'),
        ),
      ],
    );
  }
}

exportData(String filename, ParticipantProvider participants, StudyInfo study,
    ActivityProvider activities) {
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
    temp.add(participants.participants[i].name);
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

  csvList.add([]);
  csvList.add(["OBSERVATION INFO"]);
  csvList.add(["UBI START TIME", study.ubiStartTime]);
  csvList.add(["UBI END TIME", study.ubiEndTime]);
  csvList.add(["BEEP TIME", study.beepTime]);
  csvList.add(["OBSERVER", study.observer]);
  csvList.add(["TECH PERSON", study.techPerson]);
  csvList.add(["UBI RUNNING", study.ubiRunning]);
  csvList.add(["PIC TAKEN", study.picTaken]);
  csvList.add(["CLASS DIMENSION UNCHANGED", study.classDimensionUnchanged]);
  csvList.add(["TRACK START", study.trackStart]);
  csvList.add(["TRACK END", study.trackEnd]);
  csvList.add(["TIME TRACKED", study.timeTracked]);
  csvList.add([]);
  csvList.add(["Activity Info"]);
  csvList.add([
    "ACTIVITY TYPE",
    "TIME STARTED",
    "TIME ENDED",
  ]);

  for (int i = 0; i < activities.activities.length; i++) {
    List<String> temp = [];
    temp.add(activities.activities[i].type);
    temp.add(activities.activities[i].timeStarted);
    temp.add(activities.activities[i].timeEnded);
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
    // [az, a#, sxsd, ax, sc, , false, 22:07, 22:07, Present, az, student, so]
    ParticipantInfo tempParticipant = ParticipantInfo(
      study: study,
      provider: participants,
      name: row[0],
      timeEntered: "${DateTime.now().hour}:${DateTime.now().minute}",
      lenaID: row[3],
      lenaNum: "",
      vestOn: row[7],
      vestOff: row[8],
      lenaOff: "",
      ULeft: row[1],
      URight: row[2],
      type: row[11],
      subjectID: row[0],
      sonyID: row[4],
      notes: row[12],
      status: row[9],
    );
    temp.addParticipant(tempParticipant);
  }

  participants.participants = temp.participants;
  return temp;
}
