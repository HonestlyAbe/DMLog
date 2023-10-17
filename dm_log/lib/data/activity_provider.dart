import 'package:flutter/foundation.dart';
import 'activity.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity> _activities = [];

  // Getter for activities
  List<Activity> get activities => _activities;

  // Add activity
  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  // Remove activity by instance
  void removeActivity(Activity activity) {
    _activities.remove(activity);
    notifyListeners();
  }

  // Remove activity by ID
  void removeActivityById(String id) {
    _activities.removeWhere((activity) => activity.ID == id);
    notifyListeners();
  }

  // Update activity
  void updateActivity(String id, Activity updatedActivity) {
    int index = _activities.indexWhere((activity) => activity.ID == id);
    if (index != -1) {
      _activities[index] = updatedActivity;
      notifyListeners();
    }
  }

  // Get activity by ID
  Activity? getActivityById(String id) {
    return _activities.firstWhere((activity) => activity.ID == id);
  }

  //print the activities
  @override
  String toString() {
    return '$_activities';
  }
}
