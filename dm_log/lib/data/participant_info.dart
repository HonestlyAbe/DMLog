import 'package:dm_log/data/participant_provider.dart';
import 'package:dm_log/data/study_info.dart';

/// Represents detailed information about a participant.
class ParticipantInfo {
  String name;
  String timeEntered;
  String lenaID;
  String lenaNum;
  String vestOn;
  String vestOff;
  String lenaOff;
  String status;
  String ULeft;
  String URight;
  String notes;
  String subjectID;
  String sonyID;
  String type; // Adding enum for typ
  final StudyInfo study;
  final ParticipantProvider provider;

  ParticipantInfo({
    required this.study,
    required this.provider,
    this.name = "",
    this.timeEntered = "",
    this.lenaID = "",
    this.lenaNum = "",
    this.vestOn = "",
    this.vestOff = "",
    this.lenaOff = "false",
    this.status = "Present",
    this.ULeft = "",
    this.URight = "",
    this.notes = "",
    this.type = "student",
    this.subjectID = "",
    this.sonyID = "",
  });

  /// Create a copy of this [ParticipantInfo] but with the given fields replaced with the new values.
  ParticipantInfo copyWith({
    String? name,
    String? timeEntered,
    String? lenaID,
    String? lenaNum,
    String? vestOn,
    String? vestOff,
    String? lenaOff,
    String? status,
    String? ULeft,
    String? URight,
    String? type,
    String? subjectID,
    String? sonyID,
    String? notes,
  }) {
    return ParticipantInfo(
      study: study,
      provider: provider,
      name: name ?? this.name,
      lenaID: lenaID ?? this.lenaID,
      lenaNum: lenaNum ?? this.lenaNum,
      vestOn: vestOn ?? this.vestOn,
      vestOff: vestOff ?? this.vestOff,
      lenaOff: lenaOff ?? this.lenaOff,
      status: status ?? this.status,
      ULeft: ULeft ?? this.ULeft,
      URight: URight ?? this.URight,
      type: type ?? this.type,
      subjectID: subjectID ?? this.subjectID,
      sonyID: sonyID ?? this.sonyID,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return '[name: $name, vestOn: $vestOn, subjectID: $subjectID,  sonyID: $sonyID, type: $type, lenaID: $lenaID, lenaNum: $lenaNum, vestOff: $vestOff, lenaOff: $lenaOff, status: $status, ULeft: $ULeft, URight: $URight, notes: $notes]';
  }
}

/// Defines the type of participant.
enum ParticipantType { student, adult }
