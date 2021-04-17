import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/blocs.dart';
import 'package:flutter_weather/view/weather_view.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:flutter_weather/repositories/repositories.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository repository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    // BlocProvider<ThemeBloc>(
    //   create: (context) => ThemeBloc(),
    //   child: MyApp(
    //     weatherRepository: repository,
    //   ),
    // ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingBloc>(
          create: (context) => SettingBloc(),
        ),
      ],
      child: MyApp(
        weatherRepository: repository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Flutter Weather',
          theme: themeState.theme,
          home: BlocProvider(
            create: (context) =>
                WeatherBloc(weatherRepository: weatherRepository),
            child: WeatherView(),
          ),
        );
      },
    );
  }
}
