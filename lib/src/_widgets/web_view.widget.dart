import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/home/presentation/bloc_window/window_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'windows_view/window.content.dart';

class WebProjectWindow extends StatefulWidget {
  final String id;
  final String url;
  final bool isMinimized;
  final VoidCallback onClose;
  final VoidCallback onMinimize;
  final VoidCallback onRestore;
  final VoidCallback onSelect;
  final Offset position;

  const WebProjectWindow({
    super.key,
    required this.id,
    required this.url,
    required this.isMinimized,
    required this.onClose,
    required this.onMinimize,
    required this.onRestore,
    required this.onSelect,
    required this.position,
  });

  @override
  createState() => _WebProjectWindowState();
}

class _WebProjectWindowState extends State<WebProjectWindow> {
  late WebViewController _controller;
  double _width = 600;
  double _height = 400;
  bool _isMaximized = false;
  Offset _position = const Offset(50, 50);
  Offset _dragStart = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
    _position = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _isMaximized ? 0 : _position.dx,
      top: _isMaximized ? 0 : _position.dy,
      right: _isMaximized ? 0 : null,
      bottom: _isMaximized ? 0 : null,
      child: widget.isMinimized
          ? Container()
          : GestureDetector(
              onTap: widget.onSelect,
              onPanStart: (details) {
                setState(() {
                  _dragStart = details.globalPosition;
                });
              },
              onPanUpdate: (details) {
                if (!_isMaximized) {
                  setState(() {
                    _position += details.globalPosition - _dragStart;
                    _dragStart = details.globalPosition;
                  });
                }
                context.read<WindowBloc>().add(
                      UpdateWindowPositionEvent(
                        id: widget.id,
                        newPosition: _position +=
                            details.globalPosition - _dragStart,
                      ),
                    );
              },
              child: Stack(
                children: [
                  WindowContent(
                    url: widget.url,
                    width: _isMaximized
                        ? MediaQuery.of(context).size.width
                        : _width,
                    height: _isMaximized
                        ? MediaQuery.of(context).size.height - 60
                        : _height,
                    onClose: widget.onClose,
                    onMinimize: widget.onMinimize,
                    onResize: _onResize,
                    onMaximize: _toggleMaximize,
                    controller: _controller,
                  ),
                  if (!_isMaximized)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            _width += details.delta.dx;
                            _height += details.delta.dy;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Colors.grey,
                          child: const Icon(Icons.drag_handle),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  void _onResize(double width, double height) {
    setState(() {
      _width = width;
      _height = height;
    });
  }

  void _toggleMaximize() {
    setState(() {
      _isMaximized = !_isMaximized;
      if (_isMaximized) {
        _position = Offset.zero;
      }
    });
  }
}
