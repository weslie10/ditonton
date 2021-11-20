import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../core/test/json_reader.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,w
    name: "Action",
  );

  final tGenre = Genre(
    id: 1,
    name: "Action",
  );

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
  test('should return a valid model from JSON', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(json.encode({'id': 1, 'name': 'Action'}));
    // act
    final result = GenreModel.fromJson(jsonMap);
    // assert
    expect(result, tGenreModel);
  });
  test('should return a JSON map containing proper data', () async {
    final result = tGenreModel.toJson();
    // assert
    final expectedJsonMap = {
      'id': 1,
      'name': 'Action',
    };
    expect(result, expectedJsonMap);
  });
}
