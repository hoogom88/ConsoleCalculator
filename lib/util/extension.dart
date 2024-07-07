extension ListEquality<E> on List<E> {
  bool equals(List<E> other) {
    if (length != other.length) return false;
    for (int i = 0; i < other.length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}
