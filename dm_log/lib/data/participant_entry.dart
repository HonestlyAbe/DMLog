import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'participant_info.dart';

class ParticipantEntry extends ChangeNotifier {
  List<ParticipantInfo> participants = [];

  ParticipantEntry() {
    participants = [];
  }

  void addParticipant(ParticipantInfo participant) {
    participants.add(participant);
    notifyListeners();
  }

  void removeParticipant(ParticipantInfo participant) {
    participants.remove(participant);
    notifyListeners();
  }

  void updateParticipant(
      ParticipantInfo participant, String value, String attribute) {
    if (attribute == "name") {
      participant.name = value;
    } else if (attribute == "timeEntered") {
      participant.timeEntered = value;
    } else if (attribute == "altId") {
      participant.altId = value;
    }
    notifyListeners();
  }

  @override
  String toString() {
    return '$participants';
  }
}
