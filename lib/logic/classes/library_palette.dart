import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../util/general.dart';
import 'color_tile.dart';
import 'palette.dart';

class LibraryPalette extends Equatable {
  const LibraryPalette({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
    required this.palette,
  });

  factory LibraryPalette.fromJson(String source) =>
      LibraryPalette.fromMap(json.decode(source));

  factory LibraryPalette.fromMap(Map<String, dynamic> map) {
    return LibraryPalette(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      tags: List<String>.from(map['tags']),
      palette: List<dynamic>.from(map['palette'])
          .map((e) => ColorTile.fromMap(e))
          .toList(),
    );
  }

  final String description;
  final String id;
  final String name;
  final Palette palette;
  final List<String> tags;

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tags': tags,
      'palette': palette.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  LibraryPalette copyWith({
    String? description,
    String? id,
    String? name,
    Palette? palette,
    List<String>? tags,
  }) {
    return LibraryPalette(
      description: description ?? this.description,
      id: id ?? this.id,
      name: name ?? this.name,
      palette: palette ?? this.palette,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'LibraryPalette(description: $description, id: $id, name: $name, palette: $palette, tags: $tags)';
  }
}
