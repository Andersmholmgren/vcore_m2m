// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-06-26T23:30:07.901474Z

part of transformer_meta;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformationMetaModel
// **************************************************************************

class _$TransformationMetaModel extends TransformationMetaModel {
  final String fromTypeName;
  final String toTypeName;
  _$TransformationMetaModel._({this.fromTypeName, this.toTypeName})
      : super._() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
  }
  factory _$TransformationMetaModel(
          [updates(TransformationMetaModelBuilder b)]) =>
      (new TransformationMetaModelBuilder()..update(updates)).build();
  TransformationMetaModel rebuild(updates(TransformationMetaModelBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$TransformationMetaModelBuilder toBuilder() =>
      new _$TransformationMetaModelBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! TransformationMetaModel) return false;
    return fromTypeName == other.fromTypeName && toTypeName == other.toTypeName;
  }

  int get hashCode {
    return hashObjects([fromTypeName, toTypeName]);
  }

  String toString() {
    return 'TransformationMetaModel {'
        'fromTypeName=${fromTypeName.toString()}\n'
        'toTypeName=${toTypeName.toString()}\n'
        '}';
  }
}

class _$TransformationMetaModelBuilder extends TransformationMetaModelBuilder {
  _$TransformationMetaModelBuilder() : super._();
  void replace(TransformationMetaModel other) {
    super.fromTypeName = other.fromTypeName;
    super.toTypeName = other.toTypeName;
  }

  void update(updates(TransformationMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformationMetaModel build() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    return new _$TransformationMetaModel._(
        fromTypeName: fromTypeName, toTypeName: toTypeName);
  }
}
