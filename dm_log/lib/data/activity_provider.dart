import 'package:flutter/foundation.dart';
import 'activity.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity> _activities = [];

  // Initialize class
  ActivityProvider() {
    _activities = [];
  }

  // Getter for activities
  List<Activity> get activities => _activities;

  // Add activity
  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  // Remove activity
  void removeActivity(Activity activity) {
    _activities.remove(activity);
    notifyListeners();
  }

  //print the activities
  @override
  String toString() {
    return '$_activities';
  }
}
