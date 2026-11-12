import 'package:chattova/shared/widgets/chattova_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('an enabled button submits once when tapped', (tester) async {
    var submissions = 0;
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ChattovaButton(
      label: 'Submit', onPressed: () => submissions++,
    ))));
    await tester.tap(find.text('Submit'));
    expect(submissions, 1);
  });

  testWidgets('loading prevents duplicate submissions and shows progress', (tester) async {
    var submissions = 0;
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ChattovaButton(
      label: 'Submit', isLoading: true, onPressed: () => submissions++,
    ))));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
    await tester.tap(find.byType(ElevatedButton));
    expect(submissions, 0);
  });

  testWidgets('a disabled button cannot submit', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: ChattovaButton(
      label: 'Submit', onPressed: null,
    ))));
    expect(find.text('Submit'), findsOneWidget);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
  });
}
