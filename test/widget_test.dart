import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('Edukasi card validates fields and shows the submitted summary', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.drag(find.byType(ListView).first, const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tambah Edukasi'));
    await tester.pumpAndSettle();
    expect(find.text('Nama Institusi'), findsOneWidget);

    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.text('Nama institusi wajib diisi.'), findsOneWidget);
    expect(find.text('Program atau gelar wajib diisi.'), findsOneWidget);
    expect(find.text('Tahun mulai wajib diisi.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), '   ');
    await tester.enterText(find.byType(TextFormField).at(1), 'Ilmu Komputer');
    await tester.enterText(find.byType(TextFormField).at(2), '2024');
    await tester.enterText(find.byType(TextFormField).at(3), '2023');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Nama institusi wajib diisi.'), findsOneWidget);
    expect(
      find.text('Tahun selesai tidak boleh sebelum tahun mulai.'),
      findsOneWidget,
    );

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Universitas Indonesia',
    );
    await tester.enterText(find.byType(TextFormField).at(3), '2025');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan Edukasi'), findsOneWidget);
    expect(find.text('Institusi: Universitas Indonesia'), findsOneWidget);
    expect(find.text('Program/Gelar: Ilmu Komputer'), findsOneWidget);
    expect(find.text('Tahun Mulai: 2024'), findsOneWidget);
    expect(find.text('Tahun Selesai: 2025'), findsOneWidget);

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.text('Tambah Edukasi'), findsOneWidget);
  });

  testWidgets('drawer opens Edukasi and Home returns to the main page', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(Drawer),
        matching: find.text('Tambah Edukasi'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Nama Institusi'), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: find.byType(Drawer), matching: find.text('Home')),
    );
    await tester.pumpAndSettle();
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });
}
