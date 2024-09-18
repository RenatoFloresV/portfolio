import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:portfolio/src/home/presentation/bloc_window/window_bloc.dart';

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
  final Size size;
  final bool isMaximized;
  final WebViewController? webViewController;

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
    required this.size,
    required this.isMaximized,
    required this.webViewController,
  });

  @override
  createState() => _WebProjectWindowState();
}

class _WebProjectWindowState extends State<WebProjectWindow> {
  late WebViewController _controller;
  late Size _size;
  late Offset _position;
  bool _isMaximized = false;
  Offset _dragStart = Offset.zero;

  @override
  void initState() {
    super.initState();
    if (widget.webViewController != null) {
      _controller = widget.webViewController!;
    } else {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.url));
    }
    // Update the WebViewController in the Bloc
    context.read<WindowBloc>().add(
          UpdateWebViewControllerEvent(
            id: widget.id,
            controller: _controller,
          ),
        );

    _position = widget.position;
    _size = widget.size;
    _isMaximized = widget.isMaximized;
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
                context.read<WindowBloc>().add(UpdateWindowPositionEvent(
                      id: widget.id,
                      newPosition: _position +=
                          details.globalPosition - _dragStart,
                    ));
              },
              child: Stack(
                children: [
                  WindowContent(
                    url: widget.url,
                    width: _isMaximized
                        ? MediaQuery.of(context).size.width
                        : _size.width,
                    height: _isMaximized
                        ? MediaQuery.of(context).size.height - 60
                        : _size.height,
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
                            _size = Size(
                              (_size.width + details.delta.dx)
                                  .clamp(200.0, double.infinity),
                              (_size.height + details.delta.dy)
                                  .clamp(200.0, double.infinity),
                            );
                          });
                          context.read<WindowBloc>().add(
                                UpdateWindowSizeEvent(
                                  id: widget.id,
                                  newSize: _size,
                                ),
                              );
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
      _size = Size(
        width.clamp(200.0, double.infinity),
        height.clamp(200.0, double.infinity),
      );
    });
  }

  void _toggleMaximize() {
    setState(() {
      _isMaximized = !_isMaximized;
      if (_isMaximized) {
        _position = Offset.zero;
        _size = Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height - 60);
      } else {
        _position = widget.position;
        _size = widget.size;
      }
      context.read<WindowBloc>().add(
            MaximizeWindowEvent(
              id: widget.id,
              context: context,
            ),
          );
    });
  }
}
