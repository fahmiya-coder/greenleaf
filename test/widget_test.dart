import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greenleaf/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 960);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const GreenleafApp());
    await tester.pumpAndSettle();

    expect(find.text('greenleaf'), findsWidgets);
    expect(find.text("Today's Hydration"), findsOneWidget);
    expect(find.text('Money Plant'), findsWidgets);
  });
}
