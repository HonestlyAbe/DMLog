import 'package:flutter/material.dart';
import 'participant_info.dart';

enum ParticipantAttribute { name, timeEntered, altId }

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

  // TODO: add anything to this?
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
