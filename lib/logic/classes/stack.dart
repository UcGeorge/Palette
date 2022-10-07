class StackDT<T> {
  final List<T> _elements = [];

  @override
  String toString() =>
      'Stack - Length:${_elements.length} - {${_elements.join(', ')}}';

  T get peek => _elements.last;

  T get pop => _elements.removeLast();

  void push(T element) {
    _elements.add(element);
  }

  void clear() {
    _elements.clear();
  }

  bool get isEmpty => _elements.isEmpty;

  bool get isNotEmpty => !isEmpty;
}
