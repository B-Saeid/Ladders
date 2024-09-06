extension IterablesExtension<T> on Iterable<T> {
  Iterable<T> append(T other) => followedBy(Iterable.generate(1, (index) => other));
}
