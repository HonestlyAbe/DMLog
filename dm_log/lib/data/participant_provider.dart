import 'package:dm_log/data/study_info.dart';
import 'package:flutter/material.dart';
import 'participant_info.dart';

enum ParticipantAttribute {
  name,
  timeEntered,
  lenaID,
  lenaNum,
  vestOn,
  vestOff,
  lenaOff,
  status,
  ULeft,
  URight,
  notes,
  subjectID,
  leftTag,
  rightTag,
  sonyID,
  type,
}

class ParticipantProvider extends ChangeNotifier {
  List<ParticipantInfo> participants = [];

  static ParticipantInfo defaultParticipant(
      StudyInfo study, ParticipantProvider provider) {
    return ParticipantInfo(study: study, provider: provider);
  }

  void addParticipant(ParticipantInfo participant) {
    participants.add(participant);
    notifyListeners();
  }

  void removeParticipant(ParticipantInfo participant) {
    participants.remove(participant);
    notifyListeners();
  }

  void updateParticipant(ParticipantInfo participant, String value,
      ParticipantAttribute attribute) {
    int index = participants.indexOf(participant);
    if (index != -1) {
      ParticipantInfo updatedParticipant;
      switch (attribute) {
        case ParticipantAttribute.name:
          updatedParticipant = participant.copyWith(name: value);
          break;
        case ParticipantAttribute.timeEntered:
          updatedParticipant = participant.copyWith(timeEntered: value);
          break;
        case ParticipantAttribute.lenaID:
          updatedParticipant = participant.copyWith(lenaID: value);
          break;
        case ParticipantAttribute.lenaNum:
          updatedParticipant = participant.copyWith(lenaNum: value);
          break;
        case ParticipantAttribute.vestOn:
          updatedParticipant = participant.copyWith(vestOn: value);
          break;
        case ParticipantAttribute.vestOff:
          updatedParticipant = participant.copyWith(vestOff: value);
          break;
        case ParticipantAttribute.lenaOff:
          updatedParticipant = participant.copyWith(lenaOff: value);
          break;
        case ParticipantAttribute.status:
          updatedParticipant = participant.copyWith(status: value);
          break;
        case ParticipantAttribute.ULeft:
          updatedParticipant = participant.copyWith(ULeft: value);
          break;
        case ParticipantAttribute.URight:
          updatedParticipant = participant.copyWith(URight: value);
          break;
        case ParticipantAttribute.notes:
          updatedParticipant = participant.copyWith(notes: value);
          break;
        case ParticipantAttribute.subjectID:
          updatedParticipant = participant.copyWith(subjectID: value);
          break;
        case ParticipantAttribute.sonyID:
          updatedParticipant = participant.copyWith(sonyID: value);
          break;
        case ParticipantAttribute.type:
          updatedParticipant = participant.copyWith(type: value);
          break;
        default:
          updatedParticipant = participant; // No changes in default case
      }
      participants[index] =
          updatedParticipant; // Replace the object in the list
      notifyListeners();
    }
  }

  @override
  String toString() {
    return 'ParticipantProvider: ${participants.map((p) => p.toString()).join(', ')}';
  }
}
