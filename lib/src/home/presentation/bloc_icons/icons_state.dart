part of 'icons_bloc.dart';

class IconState extends Equatable {
  final List<IconData> icons;
  final List<String> texts;
  final List<Offset> positions;
  final String language;

  const IconState({
    required this.icons,
    required this.texts,
    required this.positions,
    this.language = 'en', // Default language
  });

  IconState copyWith({
    List<IconData>? icons,
    List<String>? texts,
    List<Offset>? positions,
    String? language,
  }) {
    return IconState(
      icons: icons ?? this.icons,
      texts: texts ?? this.texts,
      positions: positions ?? this.positions,
      language: language ?? this.language,
    );
  }

  @override
  List<Object> get props => [icons, texts, positions, language];
}
