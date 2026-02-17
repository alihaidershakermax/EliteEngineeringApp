import 'package:flutter_test/flutter_test.dart';
import 'package:my_test_app/main.dart';

void main() {
  testWidgets('App loads Arabic home content', (tester) async {
    await tester.pumpWidget(const EliteEngineeringGatheringApp());

    expect(find.text('Elite Engineering Gathering App'), findsOneWidget);
    expect(find.text('إعلانات حديثة'), findsOneWidget);
    expect(find.text('سجل الآن'), findsOneWidget);
  });
}
