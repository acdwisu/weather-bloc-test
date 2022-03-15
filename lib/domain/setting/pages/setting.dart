import 'package:data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic/logic.dart';

class SettingFront extends StatelessWidget {
  const SettingFront({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingBloc settingsBloc = BlocProvider.of<SettingBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text(
              'Temperature Units',
            ),
            isThreeLine: true,
            subtitle: const Text('Use metric measurements for temperature units.'),
            trailing: BlocBuilder(
              bloc: settingsBloc,
              buildWhen: (SettingState prevState, SettingState state) {
                bool rebuild = prevState==null || prevState.temperatureUnit
                    != state.temperatureUnit;

                return rebuild;
              },
              builder: (ctx, SettingState state) {
                return DropdownButton(
                  items: TemperatureUnit.values.map((e) => DropdownMenuItem(
                    child: Text(
                        describeEnum(e)
                    ),
                    value: e,
                  )).toList(),
                  value: state.temperatureUnit,
                  onChanged: (val) {
                    settingsBloc.add(TemperatureUnitChanged(val));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}