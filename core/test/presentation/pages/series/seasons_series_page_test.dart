import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/series/seasons_series_page.dart';
import 'package:ditonton/presentation/provider/series/series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'seasons_series_page_test.mocks.dart';

@GenerateMocks([SeriesDetailNotifier])
void main() {
  late MockSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSeriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SeriesDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
        _makeTestableWidget(SeasonsSeriesPage(series: testSeriesDetail)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.seriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.series).thenReturn(testSeriesDetail);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
        _makeTestableWidget(SeasonsSeriesPage(series: testSeriesDetail)));

    expect(listViewFinder, findsOneWidget);
  });

  // testWidgets('Page should display text with message when Error',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.seriesState).thenReturn(RequestState.Error);
  //   when(mockNotifier.message).thenReturn('Error message');

  //   final textFinder = find.byKey(Key('error_message'));

  //   await tester.pumpWidget(
  //       _makeTestableWidget(SeasonsSeriesPage(series: testSeriesDetail)));

  //   expect(textFinder, findsOneWidget);
  // });
}
