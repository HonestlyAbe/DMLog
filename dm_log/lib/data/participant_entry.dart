import 'package:flutter/material.dart';
import 'participant_info.dart';

// attributes of type String (excludes Type and Status)
enum ParticipantAttribute {
  name,
  timeEntered,
  altId,
  shortID,
  leftTag,
  rightTag,
  defaultLENA,
  sonyID,
  lenaON,
  lenaOFF,
  vestON,
  vestOFF,
  subjectID,
  notes
}

class ParticipantEntry extends ChangeNotifier {
  List<ParticipantInfo> participants = [];

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
        case ParticipantAttribute.altId:
          updatedParticipant = participant.copyWith(altId: value);
          break;
        case ParticipantAttribute.shortID:
          updatedParticipant = participant.copyWith(shortID: value);
          break;
        case ParticipantAttribute.leftTag:
          updatedParticipant = participant.copyWith(leftTag: value);
          break;
        case ParticipantAttribute.rightTag:
          updatedParticipant = participant.copyWith(rightTag: value);
          break;
        case ParticipantAttribute.defaultLENA:
          updatedParticipant = participant.copyWith(defaultLENA: value);
          break;
        case ParticipantAttribute.sonyID:
          updatedParticipant = participant.copyWith(sonyID: value);
          break;
        case ParticipantAttribute.lenaON:
          updatedParticipant = participant.copyWith(lenaON: value);
          break;
        case ParticipantAttribute.lenaOFF:
          updatedParticipant = participant.copyWith(lenaOFF: value);
          break;
        case ParticipantAttribute.vestON:
          updatedParticipant = participant.copyWith(vestON: value);
          break;
        case ParticipantAttribute.vestOFF:
          updatedParticipant = participant.copyWith(vestOFF: value);
          break;
        case ParticipantAttribute.subjectID:
          updatedParticipant = participant.copyWith(subjectID: value);
          break;
        case ParticipantAttribute.notes:
          updatedParticipant = participant.copyWith(notes: value);
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
    return 'ParticipantEntry: ${participants.map((p) => p.toString()).join(', ')}';
  }
}
