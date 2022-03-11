import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('${this.runtimeType}: onChange-$bloc $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('${this.runtimeType}: onTransition-$bloc $transition');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('${this.runtimeType}: onCreate-$bloc');
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    log('${this.runtimeType}: onEvent-$bloc $event');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('${this.runtimeType}: onClose-$bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('${this.runtimeType}: onError-$bloc', error: error, stackTrace: stackTrace);
  }
}
