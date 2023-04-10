import 'package:fcc_final_project/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mekari_pixel/mekari_pixel.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('ProfilePage', () {
    late MockBuildContext mockContext;

    setUp(() {
      mockContext = MockBuildContext();
    });

    testWidgets('should display user profile information', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

      final avatarFinder = find.byType(CircleAvatar);
      expect(avatarFinder, findsOneWidget);

      final nameFinder = find.text('Jackie Mock');
      expect(nameFinder, findsOneWidget);

      final emailFinder = find.text('jackie.mock@mekari.com');
      expect(emailFinder, findsOneWidget);

      final balanceFinder = find.text('Balance IDR 3.000.000');
      expect(balanceFinder, findsOneWidget);
    });

    testWidgets('should have correct text styles', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

      final nameFinder = find.text('Jackie Mock');
      expect(nameFinder, findsOneWidget);
      expect((nameFinder.evaluate().first.widget as Text).style, MpTextStyles.xl.semiBold);

      final emailFinder = find.text('jackie.mock@mekari.com');
      expect(emailFinder, findsOneWidget);
      expect((emailFinder.evaluate().first.widget as Text).style, MpTextStyles.sm);

      final balanceFinder = find.text('Balance IDR 3.000.000');
      expect(balanceFinder, findsOneWidget);
      expect((balanceFinder.evaluate().first.widget as Text).style, MpTextStyles.sm);
    });
  });
}
