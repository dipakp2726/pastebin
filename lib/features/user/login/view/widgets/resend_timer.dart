import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendCodeTimer extends ConsumerStatefulWidget {
  const ResendCodeTimer({
    super.key,
    required this.onTimerFinished,
    this.timerDuration = 60,
  });

  final VoidCallback onTimerFinished;
  final int timerDuration;

  @override
  ConsumerState<ResendCodeTimer> createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends ConsumerState<ResendCodeTimer> {
  late Timer _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _remainingSeconds = widget.timerDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          stopTimer();
          widget.onTimerFinished();
        }
      });
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  String get remainingTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Center(
        child: Column(
          children: [
            Text(
              'Resend code in $remainingTime',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: AppSpacing.sm),
            if (_remainingSeconds == 0)
              InkWell(
                onTap: startTimer,
                child: const Text(
                  'Resend',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
