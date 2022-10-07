part of 'library_cubit.dart';

class LibraryState extends Equatable {
  LibraryState(this.library) : dateModified = DateTime.now();

  factory LibraryState.fromJson(String source) =>
      LibraryState.fromMap(json.decode(source));

  factory LibraryState.fromMap(Map<String, dynamic> map) {
    return LibraryState(
      List<LibraryPalette>.from(
          map['library']?.map((x) => LibraryPalette.fromMap(x))),
    );
  }

  factory LibraryState.init() => LibraryState([]);

  final DateTime dateModified;
  final List<LibraryPalette> library;

  @override
  List<Object> get props => [dateModified];

  LibraryState copyWith({
    List<LibraryPalette>? library,
  }) {
    return LibraryState(
      library ?? this.library,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'library': library.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'LibraryState(library: $library)';
}
