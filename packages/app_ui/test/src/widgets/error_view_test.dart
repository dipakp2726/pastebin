import 'package:app_ui/src/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('alert button ...', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: ErrorView()));

    // Verify that our counter starts at 0.
    expect(find.byType(ErrorView), findsOneWidget);
  });
}
