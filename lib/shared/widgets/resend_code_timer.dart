import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shaty/core/localization/localization_extension.dart';

class ResendCodeTimer extends StatefulWidget {
  final VoidCallback onResend;

  const ResendCodeTimer({super.key, required this.onResend});

  @override
  State<ResendCodeTimer> createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends State<ResendCodeTimer> {
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }



  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _secondsRemaining > 0
          ? Text('${context.loc.send_code} $_secondsRemaining s')
          : TextButton(
        onPressed: () {
          widget.onResend();
          _startTimer();
        },
        child: Text(context.loc.send_code),
      ),
    );
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

}
