part of 'icons_bloc.dart';

class IconState extends Equatable {
  final List<DsIconData?> icons;
  final List<String> texts;
  final List<Offset> positions;
  final List<void Function()> function;
  final String language;

  const IconState({
    required this.icons,
    required this.texts,
    required this.positions,
    required this.function,
    this.language = 'en',
  });

  IconState copyWith({
    List<DsIconData>? icons,
    List<String>? texts,
    List<Offset>? positions,
    List<void Function()>? function,
    String? language,
  }) {
    return IconState(
      icons: icons ?? this.icons,
      texts: texts ?? this.texts,
      positions: positions ?? this.positions,
      function: function ?? this.function,
      language: language ?? this.language,
    );
  }

  @override
  List<Object> get props => [icons, texts, positions, language, function];
}
