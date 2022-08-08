import 'activity_provider.dart';
import 'study_info.dart';
// Stateful activity widget that is a child of activity provider

class Activity {
  // Initialize class
  Activity(
      {required this.timeStarted,
      required this.timeEnded,
      required this.involved,
      required this.type,
      required this.adultCount,
      required this.childCount,
      required this.comment,
      required this.provider,
      required this.study,
      required this.ID});

  String timeStarted;
  String timeEnded;
  Map<String, bool> involved;
  String type;
  int adultCount;
  int childCount;
  String comment;
  StudyInfo study;
  ActivityProvider provider;
  final String ID;
  static Activity defaultActivity(ActivityProvider provider, StudyInfo study) {
    return Activity(
        timeStarted: "",
        timeEnded: "",
        involved: Map.fromIterable(study.studyParticipants, value: (v) => true),
        type: "G",
        adultCount: study.adultCount,
        childCount: study.childCount,
        comment: "",
        provider: provider,
        study: study,
        ID: idGenerator());
  }

  static Activity blankActivity(ActivityProvider provider, StudyInfo study) {
    return Activity(
        timeStarted: "",
        timeEnded: "",
        involved:
            Map.fromIterable(study.studyParticipants, value: (v) => false),
        type: "G",
        adultCount: 0,
        childCount: 0,
        comment: "",
        provider: provider,
        study: study,
        ID: idGenerator());
  }

  static String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  @override
  String toString() {
    return "\n[\n"
        "Time started: $timeStarted\n"
        "Time ended: $timeEnded\n"
        "Involved: $involved\n"
        "Type: $type\n"
        "Adult count: $adultCount\n"
        "Child count: $childCount\n"
        "Comment: $comment\n]";
  }
}
