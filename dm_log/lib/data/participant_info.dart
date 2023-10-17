/// Represents detailed information about a participant.
class ParticipantInfo {
  final String name;
  final String timeEntered;
  final String altId;
  final ParticipantType type; // Adding enum for type

  ParticipantInfo({
    required this.name,
    this.timeEntered = "00:00",
    this.altId = "",
    this.type = ParticipantType.Student, // Default type
  });

  /// Create a copy of this [ParticipantInfo] but with the given fields replaced with the new values.
  ParticipantInfo copyWith({
    String? name,
    String? timeEntered,
    String? altId,
    ParticipantType? type,
  }) {
    return ParticipantInfo(
      name: name ?? this.name,
      timeEntered: timeEntered ?? this.timeEntered,
      altId: altId ?? this.altId,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return '[name: $name, timeEntered: $timeEntered, altId: $altId, type: ${type.toString().split('.').last}]';
  }
}

/// Defines the type of participant.
enum ParticipantType { Student, Adult }
