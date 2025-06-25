import 'dart:async';

typedef DebounceCallback = void Function(String value);

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds = 400});

  void call(String value, DebounceCallback callback) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      callback(value);
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
