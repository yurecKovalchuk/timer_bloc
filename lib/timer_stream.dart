import 'dart:async';

class TimerStream {
  final StreamController<int> _timerStreamController = StreamController<int>();
  Timer? _timer;
  int _seconds = 0;
  int _timerLimit = 0;
  Stream<int> get timerStream => _timerStreamController.stream;

  bool get isNotActive => _timer == null || !_timer!.isActive;

  bool get isActive => !isNotActive;

  void getTimerLimit(int limit){
    _timerLimit = limit;
  }

  void startTimer() {
    if (isNotActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        _timerStreamController.sink.add(_seconds);

        if(_timerLimit > 0 && _seconds >= _timerLimit){
          stopTimer();
        }
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _timerStreamController.sink.add(_seconds);
  }

  void dispose() {
    _timerStreamController.close();
  }
}
