class ParticipantInfo {
  String timeEntered = "00:00";
  String altId = "";
  String name = "";

  ParticipantInfo({
    required this.name,
  });
  // possibly add student or adult here
  void setTimeEntered(String timeEntered) {
    this.timeEntered = timeEntered;
  }

  void setAlternativeIdentifier(String alternativeIdentifier) {
    altId = alternativeIdentifier;
  }

  String getName() {
    return name;
  }

  @override
  String toString() {
    return '[name: $name, timeEntered: $timeEntered, altId: $altId]';
  }
}
