// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-07-01T22:14:42.906972Z

part of transformer_meta;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformationMetaModel
// **************************************************************************

class _$TransformationMetaModel extends TransformationMetaModel {
  final String fromTypeName;
  final String toTypeName;
  final BuiltList<TransformMetaModel> requiredTransforms;
  _$TransformationMetaModel._(
      {this.fromTypeName, this.toTypeName, this.requiredTransforms})
      : super._() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (requiredTransforms == null)
      throw new ArgumentError('null requiredTransforms');
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
    return fromTypeName == other.fromTypeName &&
        toTypeName == other.toTypeName &&
        requiredTransforms == other.requiredTransforms;
  }

  int get hashCode {
    return hashObjects([fromTypeName, toTypeName, requiredTransforms]);
  }

  String toString() {
    return 'TransformationMetaModel {'
        'fromTypeName=${fromTypeName.toString()}\n'
        'toTypeName=${toTypeName.toString()}\n'
        'requiredTransforms=${requiredTransforms.toString()}\n'
        '}';
  }
}

class _$TransformationMetaModelBuilder extends TransformationMetaModelBuilder {
  _$TransformationMetaModelBuilder() : super._();
  void replace(TransformationMetaModel other) {
    super.fromTypeName = other.fromTypeName;
    super.toTypeName = other.toTypeName;
    super.requiredTransforms = other.requiredTransforms?.toBuilder();
  }

  void update(updates(TransformationMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformationMetaModel build() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (requiredTransforms == null)
      throw new ArgumentError('null requiredTransforms');
    return new _$TransformationMetaModel._(
        fromTypeName: fromTypeName,
        toTypeName: toTypeName,
        requiredTransforms: requiredTransforms != null
            ? new ListBuilder<TransformMetaModel>(
                requiredTransforms.build().map((v) => v.build())).build()
            : null);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformMetaModel
// **************************************************************************

class _$TransformMetaModel extends TransformMetaModel {
  final String fromName;
  final String toName;
  _$TransformMetaModel._({this.fromName, this.toName}) : super._() {
    if (fromName == null) throw new ArgumentError('null fromName');
    if (toName == null) throw new ArgumentError('null toName');
  }
  factory _$TransformMetaModel([updates(TransformMetaModelBuilder b)]) =>
      (new TransformMetaModelBuilder()..update(updates)).build();
  TransformMetaModel rebuild(updates(TransformMetaModelBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$TransformMetaModelBuilder toBuilder() =>
      new _$TransformMetaModelBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! TransformMetaModel) return false;
    return fromName == other.fromName && toName == other.toName;
  }

  int get hashCode {
    return hashObjects([fromName, toName]);
  }

  String toString() {
    return 'TransformMetaModel {'
        'fromName=${fromName.toString()}\n'
        'toName=${toName.toString()}\n'
        '}';
  }
}

class _$TransformMetaModelBuilder extends TransformMetaModelBuilder {
  _$TransformMetaModelBuilder() : super._();
  void replace(TransformMetaModel other) {
    super.fromName = other.fromName;
    super.toName = other.toName;
  }

  void update(updates(TransformMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformMetaModel build() {
    if (fromName == null) throw new ArgumentError('null fromName');
    if (toName == null) throw new ArgumentError('null toName');
    return new _$TransformMetaModel._(fromName: fromName, toName: toName);
  }
}
