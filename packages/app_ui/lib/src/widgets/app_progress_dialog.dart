import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

bool _isShowing = false;

late BuildContext _dismissingContext;

/// App progress Dialog
class AppProgressDialog {
  AppProgressDialog._();

  /// show dialog
  static Future<bool> show(BuildContext context, {String? message}) async {
    try {
      if (!_isShowing) {
        unawaited(
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              _dismissingContext = context;
              return _DialogBody(
                message: message,
              );
            },
          ),
        );

        await Future<void>.delayed(const Duration(milliseconds: 100));

        log('ProgressDialog shown');
        _isShowing = true;

        return true;
      } else {
        log('ProgressDialog already shown/showing');
        return false;
      }
    } catch (err) {
      _isShowing = false;

      log('Exception while showing the dialog');
      log('$err');
      return false;
    }
  }

  /// if dialog is still showing
  bool isShowing() {
    return _isShowing;
  }

  /// Dismiss Dialog if active
  static void dismissDialog() {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(_dismissingContext).pop();

        log('ProgressDialog dismissed');
        // return Future.value(true);
      } else {
        log('ProgressDialog already dismissed');
        // return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue dismissing dialog');
      debugPrint(err.toString());
      // return Future.value(false);
    }
  }
}

class _DialogBody extends StatelessWidget {
  const _DialogBody({
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
              backgroundColor: Theme.of(context).dividerColor,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                message ?? 'Loading',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
