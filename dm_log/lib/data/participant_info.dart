/// Represents detailed information about a participant.
class ParticipantInfo {
  final String name;
  final String timeEntered;
  final String altId;
  final ParticipantType type; // Adding enum for type

  // not final because we want them to be able to changed
  String shortID;
  String leftTag;
  String rightTag;
  String defaultLENA;
  String sonyID;
  String lenaON;
  String lenaOFF;
  String vestON;
  String vestOFF;
  StatusType status;
  String subjectID;
  String notes;

  // constructor with default values
  ParticipantInfo({
    required this.name,
    this.timeEntered = "00:00",
    this.altId = "",
    this.type = ParticipantType.Student, // Default type
    this.shortID = "",
    this.leftTag = "",
    this.rightTag = "",
    this.defaultLENA = "",
    this.sonyID = "",
    this.lenaON = "",
    this.lenaOFF = "",
    this.vestON = "",
    this.vestOFF = "",
    this.status = StatusType.PRESENT,
    this.subjectID = "",
    this.notes="",
  });

  /// Create a copy of this [ParticipantInfo] but with the given fields replaced with the new values.
  ParticipantInfo copyWith({
    String? name,
    String? timeEntered,
    String? altId,
    ParticipantType? type,
    String? shortID,
    String? leftTag,
    String? rightTag,
    String? defaultLENA,
    String? sonyID,
    String? lenaON,
    String? lenaOFF,
    String? vestON,
    String? vestOFF,
    StatusType? status,
    String? subjectID,
    String? notes,
  }) {
    return ParticipantInfo(
      name: name ?? this.name,
      timeEntered: timeEntered ?? this.timeEntered,
      altId: altId ?? this.altId,
      type: type ?? this.type,
      shortID: shortID ?? this.shortID,
      leftTag: leftTag ?? this.leftTag,
      rightTag: rightTag ?? this.rightTag,
      defaultLENA: defaultLENA ?? this.defaultLENA,
      sonyID: sonyID ?? this.sonyID,
      lenaON: lenaON ?? this.lenaON,
      lenaOFF: lenaOFF ?? this.lenaOFF,
      vestON: vestON ?? this.vestON,
      vestOFF: vestOFF ?? this.vestOFF,
      status: status ?? this.status,
      subjectID: subjectID ?? this.subjectID,
      notes: notes ?? this.notes,
    );
  }

  // TODO: finish toString
  @override
  String toString() {
    return '[name: $name, timeEntered: $timeEntered, altId: $altId, type: ${type.toString().split('.').last}, status: $status, left tag: $leftTag, right tag: $rightTag, default Lena: $defaultLENA, SONY ID: $sonyID]';
  }
}

/// Defines the type of participant.
enum ParticipantType { Student, Adult }

/// Defines the type of status.
enum StatusType { PRESENT, ABSENT, NODATA }

