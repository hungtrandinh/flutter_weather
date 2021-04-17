import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/blocs.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingBloc = BlocProvider.of<SettingBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return ListTile(
                title: Text(
                  'Temperature Units',
                ),
                isThreeLine: true,
                subtitle:
                    Text('Use metric measurements for temperature units.'),
                trailing: Switch(
                  value: state.temperatureUnits == TemperatureUnits.celsius,
                  onChanged: (_) => settingBloc.add(
                    TemperatureUnitsToggled(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
