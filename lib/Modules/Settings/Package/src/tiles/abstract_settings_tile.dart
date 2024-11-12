import 'package:flutter/material.dart';

abstract class AbstractSettingsTile extends StatelessWidget {
  const AbstractSettingsTile({super.key});

  Widget? get description => null;
  bool get hasLeading => true;
}
