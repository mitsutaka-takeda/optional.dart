library optional_internal;

part 'src/absent.dart';
part 'src/present.dart';
part 'src/novaluepresent.dart';

/// A constant, absent Optional.
const Optional empty = Optional<dynamic>.empty();

/// A container object which may contain a non-null value.
///
/// Offers several methods which depend on the presence or absence of a contained value.
abstract class Optional<T> {
  /// Creates a new Optional with the given non-null value.
  ///
  /// Throws [ArgumentError] if value is null.
  factory Optional.of(T value) {
    if (value == null) {
      throw ArgumentError('value must be non-null');
    } else {
      return _Present<T>(value);
    }
  }

  /// Creates a new Optional with the given value, if non-null.  Otherwise, returns an empty Optional.
  factory Optional.ofNullable(T value) =>
      value == null ? Optional<T>.empty() : Optional.of(value);

  /// Creates an empty Optional.
  const factory Optional.empty() = _Absent<T>._internal;

  /// The value associated with this Optional, if any.
  ///
  /// Throws [NoValuePresentError] if no value is present.
  T get value;

  /// Whether the Optional has a value.
  bool get isPresent;

  /// Returns an Optional with this Optional's value, if there is a value present and it matches the predicate.  Otherwise, returns an empty Optional.
  Optional<T> filter(bool predicate(T val));

  /// Returns an Optional provided by applying the mapper to this Optional's value, if present.  Otherwise, returns an empty Optional.
  Optional<R> flatMap<R>(Optional<R> mapper(T val));

  /// Returns an Optional containing the result of applying the mapper to this Optional's value, if present.  Otherwise, returns an empty Optional.
  ///
  /// If the mapper returns a null value, returns an empty Optional.
  Optional<R> map<R>(R mapper(T val));

  /// Returns this Optional's value, if present.  Otherwise, returns other.
  T orElse(T other);

  /// Returns this Optional's value, if present.  Otherwise, returns the result of calling supply().
  T orElseGet(T supply());

  /// Returns this Optional's value, if present.  Otherwise, throws the result of calling supplyError().
  T orElseThrow(dynamic supplyError());

  /// Invokes consume() with this Optional's value, if present.  Otherwise, if orElse is passed, invokes it, otherwise does nothing.
  void ifPresent(void consume(T val), {void orElse()});

  /// The hashCode of this Optional's value, if present.  Otherwise, 0.
  @override
  int get hashCode;

  @override
  bool operator ==(Object other);

  /// Returns a view of this Optional as an Optional with an [R] value
  Optional<R> cast<R>();
}
