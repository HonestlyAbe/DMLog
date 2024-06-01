// settings_page.dart

import 'package:dm_log/data/participant_provider.dart';
import 'package:dm_log/data/study_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dm_log/data/activity_provider.dart';
import './screen/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Settings(
        activities: Provider.of<ActivityProvider>(context, listen: false),
        study: Provider.of<StudyInfo>(context, listen: false),
        participants: Provider.of<ParticipantProvider>(context, listen: false),
      ),
    );
  }
}
