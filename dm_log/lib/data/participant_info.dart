/// Represents detailed information about a participant.
class ParticipantInfo {
  final String name;
  final String timeEntered;
  final String altId;
  final ParticipantType type; // Adding enum for type

  // TODO: should this be final? be able to be changed
  final StatusType status;
  final String leftTag;
  final String rightTag;
  final int defaultLENA;
  final int sonyID;

  ParticipantInfo({
    required this.name,
    this.timeEntered = "00:00",
    this.altId = "",
    this.type = ParticipantType.Student, // Default type

    // TODO: do i want this intialized default to present
    this.status = StatusType.PRESENT,
    this.leftTag = "",
    this.rightTag = "",
    this.defaultLENA = 0,
    this.sonyID = 0
  });

  // TODO: do i update this too w all the instance variables?

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

  // TODO: do we want such a long toString
  @override
  String toString() {
    return '[name: $name, timeEntered: $timeEntered, altId: $altId, type: ${type.toString().split('.').last}, status: $status, left tag: $leftTag, right tag: $rightTag, default Lena: $defaultLENA, SONY ID: $sonyID]';
  }
}

/// Defines the type of participant.
enum ParticipantType { Student, Adult }

/// Defines the type of status.
enum StatusType { PRESENT, ABSENT, NODATA}