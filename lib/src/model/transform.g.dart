// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-06-26T23:27:22.780030Z

part of transform;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class BidirectionalTransform
// **************************************************************************

// Error: Please make changes to use built_value.
// TODO: Make class have factory: factory BidirectionalTransform([updates(BidirectionalTransformBuilder b)]) = _$BidirectionalTransform;

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
