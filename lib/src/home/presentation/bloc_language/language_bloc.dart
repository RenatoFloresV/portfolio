import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(
            const LanguageState(language: 'es', status: LanguageStatus.none)) {
    on<LanguageChangeEvent>(_onLanguageChange);
  }
  void _onLanguageChange(
      LanguageChangeEvent event, Emitter<LanguageState> emit) {
    emit(state.copyWith(language: event.language));
  }
}
