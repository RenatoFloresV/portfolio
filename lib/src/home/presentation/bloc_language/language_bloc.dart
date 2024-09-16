import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portfolio/core/local_storage/local_storage.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final StorageService _storageService;

  LanguageBloc(this._storageService)
      : super(
            const LanguageState(language: 'es', status: LanguageStatus.none)) {
    on<LanguageChangeEvent>(_onLanguageChange);
    on<LoadLanguageEvent>(_onLoadLanguage);

    add(LoadLanguageEvent());
  }

  Future<void> _onLoadLanguage(
      LoadLanguageEvent event, Emitter<LanguageState> emit) async {
    try {
      final savedLanguage = await _storageService.getLanguage();
      final language = savedLanguage ?? 'es';
      emit(state.copyWith(language: language));
    } catch (e) {
      print('Error loading language: $e');

      emit(state.copyWith(language: 'es'));
    }
  }

  void _onLanguageChange(
      LanguageChangeEvent event, Emitter<LanguageState> emit) async {
    try {
      await _storageService.saveLanguage(event.language);
      emit(state.copyWith(language: event.language));
    } catch (e) {
      print('Error changing language: $e');
    }
  }
}
