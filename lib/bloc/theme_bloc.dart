import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horus_travels_bloc/bloc/theme_event.dart';
import 'package:horus_travels_bloc/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: ThemeData.light())) {
    on<ChangeThemeEvent>((event, emit) {
      emit(ThemeState(
        themeData: state.themeData.brightness == Brightness.dark
            ? ThemeData.light()
            : ThemeData.dark(),
      ));
    });
  }
}
