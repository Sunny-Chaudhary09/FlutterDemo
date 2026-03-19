import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef NativeEventCallback = void Function(Map<dynamic, dynamic> event);

class NativeAndroidView extends StatefulWidget {
  final double height;
  final String initialTitle;
  final String initialMessage;
  final NativeEventCallback? onNativeEvent;

  const NativeAndroidView({
    Key? key,
    this.height = 300,
    this.initialTitle = 'Native Panel',
    this.initialMessage = 'Hello from Flutter',
    this.onNativeEvent,
  }) : super(key: key);

  @override
  _NativeAndroidViewState createState() => _NativeAndroidViewState();
}

class _NativeAndroidViewState extends State<NativeAndroidView> {
  MethodChannel? _channel;

  void _onPlatformViewCreated(int id) {
    _channel = MethodChannel('native_view_channel_$id');

    // Listen to calls from native (optional)
    _channel!.setMethodCallHandler((call) async {
      if (call.method == 'onNativeEvent') {
        final args = call.arguments as Map<dynamic, dynamic>?;
        if (args != null && widget.onNativeEvent != null) {
          widget.onNativeEvent!(args);
        }
      }
      return null;
    });

    // Pass initial data to native (alternative to creationParams)
    _channel!.invokeMethod('setTitle', {'text': widget.initialTitle});
    _channel!.invokeMethod('setMessage', {'text': widget.initialMessage});
  }

  Future<void> setMessage(String text) async {
    if (_channel == null) return;
    await _channel!.invokeMethod('setMessage', {'text': text});
  }

  Future<Map?> getState() async {
    if (_channel == null) return null;
    final res = await _channel!.invokeMethod('getState');
    return res as Map?;
  }

  @override
  Widget build(BuildContext context) {
    // Only Android is supported for this widget.
    if (defaultTargetPlatform != TargetPlatform.android) {
      return SizedBox(
        height: widget.height,
        child: Center(child: Text('Native Android view is only available on Android')),
      );
    }

    return SizedBox(
      height: widget.height,
      child: AndroidView(
        viewType: 'native-view',
        layoutDirection: TextDirection.ltr,
        creationParams: <String, dynamic>{
          'title': widget.initialTitle,
          'message': widget.initialMessage,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      ),
    );
  }
}