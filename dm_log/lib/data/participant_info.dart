import 'dart:ffi';

import 'package:dm_log/data/participant_provider.dart';
import 'package:dm_log/data/study_info.dart';

/// Represents detailed information about a participant.
class ParticipantInfo {
  String name;
  String timeEntered;
  String altId;
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
  String shortID;
  String leftTag;
  String rightTag;
  String sonyID;
  String type; // Adding enum for typ
  final StudyInfo study;
  final ParticipantProvider provider;

  ParticipantInfo({
    required this.study,
    required this.provider,
    this.name = "",
    this.timeEntered = "",
    this.altId = "",
    this.lenaID = "1",
    this.lenaNum = "",
    this.vestOn = "",
    this.vestOff = "",
    this.lenaOff = "",
    this.status = "",
    this.ULeft = "",
    this.URight = "",
    this.notes = "",
    this.type = "",
    this.subjectID = "",
    this.shortID = "",
    this.leftTag = "",
    this.rightTag = "",
    this.sonyID = "",
  });

  /// Create a copy of this [ParticipantInfo] but with the given fields replaced with the new values.
  ParticipantInfo copyWith({
    String? name,
    String? timeEntered,
    String? altId,
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
    String? shortID,
    String? leftTag,
    String? rightTag,
    String? sonyID,
    String? notes,
  }) {
    return ParticipantInfo(
      study: study,
      provider: provider,
      name: name ?? this.name,
      timeEntered: timeEntered ?? this.timeEntered,
      altId: altId ?? this.altId,
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
      shortID: shortID ?? this.shortID,
      leftTag: leftTag ?? this.leftTag,
      rightTag: rightTag ?? this.rightTag,
      sonyID: sonyID ?? this.sonyID,
    );
  }

  @override
  String toString() {
    return '[name: $name, timeEntered: $timeEntered, altId: $altId, subjectID: $subjectID,  shortID: $shortID, leftTag: $leftTag, rightTag: $rightTag , sonyID: $sonyID, type: ${type.toString().split('.').last}]';
  }
}

/// Defines the type of participant.
enum ParticipantType { student, adult }
