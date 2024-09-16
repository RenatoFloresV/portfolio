import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/src/home/presentation/bloc_language/language_bloc.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio_ds/lib.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height - 140),
          child: Material(
            color: Colors.transparent,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildLanguageOption(context, S.of(context).english, 'en'),
                _buildLanguageOption(context, S.of(context).spanish, 'es'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String title, String languageCode) {
    final isSelected = context
        .select((LanguageBloc bloc) => bloc.state.language == languageCode);

    return InkWell(
      onTap: () {
        context.read<LanguageBloc>().add(LanguageChangeEvent(languageCode));
        _hideOverlay();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.white.withOpacity(0.1)
              : context.colors.scrim,
          border: Border(
            bottom: BorderSide(
              color: context.colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: context.colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: context.colors.white,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String language =
            context.select((LanguageBloc bloc) => bloc.state.language);
        final String text =
            language == 'en' ? S.of(context).english : S.of(context).spanish;

        return CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: () {
              if (_overlayEntry == null) {
                _showOverlay();
              } else {
                _hideOverlay();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: context.colors.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DsText(
                    text,
                    style: TextStyle(
                      color: context.colors.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_drop_down,
                    color: context.colors.onPrimary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }
}
