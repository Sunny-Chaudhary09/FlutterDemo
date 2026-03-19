import 'package:assignment2/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App loads home with search bar', (WidgetTester tester) async {
    await tester.pumpWidget(const AppRoot());
    await tester.pumpAndSettle();

    expect(find.text('Where to?'), findsOneWidget);
  });
}
