// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-06-26T23:27:22.792451Z

part of transformer_meta;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformationMetaModel
// **************************************************************************

class _$TransformationMetaModel extends TransformationMetaModel {
  _$TransformationMetaModel._() : super._() {}
  factory _$TransformationMetaModel(
          [updates(TransformationMetaModelBuilder b)]) =>
      (new TransformationMetaModelBuilder()..update(updates)).build();
  TransformationMetaModel rebuild(updates(TransformationMetaModelBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$TransformationMetaModelBuilder toBuilder() =>
      new _$TransformationMetaModelBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! TransformationMetaModel) return false;
    return true;
  }

  int get hashCode {
    return 837574995;
  }

  String toString() {
    return 'TransformationMetaModel {}';
  }
}

class _$TransformationMetaModelBuilder extends TransformationMetaModelBuilder {
  _$TransformationMetaModelBuilder() : super._();
  void replace(TransformationMetaModel other) {}
  void update(updates(TransformationMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformationMetaModel build() {
    return new _$TransformationMetaModel._();
  }
}
