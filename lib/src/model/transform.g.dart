// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-07-02T02:30:16.862594Z

part of transform;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class BidirectionalTransform
// **************************************************************************

class _$BidirectionalTransform<F, T> extends BidirectionalTransform<F, T> {
  final Transform<F, T> forwards;
  final Transform<T, F> backwards;
  _$BidirectionalTransform._({this.forwards, this.backwards}) : super._() {
    if (forwards == null) throw new ArgumentError('null forwards');
    if (backwards == null) throw new ArgumentError('null backwards');
  }
  factory _$BidirectionalTransform(
          [updates(BidirectionalTransformBuilder<F, T> b)]) =>
      (new BidirectionalTransformBuilder<F, T>()..update(updates)).build();
  BidirectionalTransform<F, T> rebuild(
          updates(BidirectionalTransformBuilder<F, T> b)) =>
      (toBuilder()..update(updates)).build();
  _$BidirectionalTransformBuilder<F, T> toBuilder() =>
      new _$BidirectionalTransformBuilder<F, T>()..replace(this);
  bool operator ==(other) {
    if (other is! BidirectionalTransform) return false;
    return forwards == other.forwards && backwards == other.backwards;
  }

  int get hashCode {
    return hashObjects([forwards, backwards]);
  }

  String toString() {
    return 'BidirectionalTransform {'
        'forwards=${forwards.toString()}\n'
        'backwards=${backwards.toString()}\n'
        '}';
  }
}

class _$BidirectionalTransformBuilder<F, T>
    extends BidirectionalTransformBuilder<F, T> {
  _$BidirectionalTransformBuilder() : super._();
  void replace(BidirectionalTransform<F, T> other) {
    super.forwards = other.forwards;
    super.backwards = other.backwards;
  }

  void update(updates(BidirectionalTransformBuilder<F, T> b)) {
    if (updates != null) updates(this);
  }

  BidirectionalTransform<F, T> build() {
    if (forwards == null) throw new ArgumentError('null forwards');
    if (backwards == null) throw new ArgumentError('null backwards');
    return new _$BidirectionalTransform<F, T>._(
        forwards: forwards, backwards: backwards);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformKey
// **************************************************************************

class _$TransformKey extends TransformKey {
  final Type from;
  final Type to;
  _$TransformKey._({this.from, this.to}) : super._() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
  }
  factory _$TransformKey([updates(TransformKeyBuilder b)]) =>
      (new TransformKeyBuilder()..update(updates)).build();
  TransformKey rebuild(updates(TransformKeyBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$TransformKeyBuilder toBuilder() =>
      new _$TransformKeyBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! TransformKey) return false;
    return from == other.from && to == other.to;
  }

  int get hashCode {
    return hashObjects([from, to]);
  }

  String toString() {
    return 'TransformKey {'
        'from=${from.toString()}\n'
        'to=${to.toString()}\n'
        '}';
  }
}

class _$TransformKeyBuilder extends TransformKeyBuilder {
  _$TransformKeyBuilder() : super._();
  void replace(TransformKey other) {
    super.from = other.from;
    super.to = other.to;
  }

  void update(updates(TransformKeyBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformKey build() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    return new _$TransformKey._(from: from, to: to);
  }
}
