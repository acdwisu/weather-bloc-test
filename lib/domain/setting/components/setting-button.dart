import 'package:flutter/material.dart';

import '../pages/setting.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingFront(),
          ),
        );
      },
    );
  }
}
