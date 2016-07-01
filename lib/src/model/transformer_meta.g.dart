// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-07-01T23:13:47.971594Z

part of transformer_meta;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformationMetaModel
// **************************************************************************

class _$TransformationMetaModel extends TransformationMetaModel {
  final String fromTypeName;
  final String toTypeName;
  final BuiltList<TransformMetaModel> requiredTransforms;
  final BuiltSet<PropertyTransform> propertyTransforms;
  _$TransformationMetaModel._(
      {this.fromTypeName,
      this.toTypeName,
      this.requiredTransforms,
      this.propertyTransforms})
      : super._() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (requiredTransforms == null)
      throw new ArgumentError('null requiredTransforms');
    if (propertyTransforms == null)
      throw new ArgumentError('null propertyTransforms');
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
        requiredTransforms == other.requiredTransforms &&
        propertyTransforms == other.propertyTransforms;
  }

  int get hashCode {
    return hashObjects(
        [fromTypeName, toTypeName, requiredTransforms, propertyTransforms]);
  }

  String toString() {
    return 'TransformationMetaModel {'
        'fromTypeName=${fromTypeName.toString()}\n'
        'toTypeName=${toTypeName.toString()}\n'
        'requiredTransforms=${requiredTransforms.toString()}\n'
        'propertyTransforms=${propertyTransforms.toString()}\n'
        '}';
  }
}

class _$TransformationMetaModelBuilder extends TransformationMetaModelBuilder {
  _$TransformationMetaModelBuilder() : super._();
  void replace(TransformationMetaModel other) {
    super.fromTypeName = other.fromTypeName;
    super.toTypeName = other.toTypeName;
    super.requiredTransforms = other.requiredTransforms?.toBuilder();
    super.propertyTransforms = other.propertyTransforms?.toBuilder();
  }

  void update(updates(TransformationMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformationMetaModel build() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (requiredTransforms == null)
      throw new ArgumentError('null requiredTransforms');
    if (propertyTransforms == null)
      throw new ArgumentError('null propertyTransforms');
    return new _$TransformationMetaModel._(
        fromTypeName: fromTypeName,
        toTypeName: toTypeName,
        requiredTransforms: requiredTransforms != null
            ? new ListBuilder<TransformMetaModel>(
                requiredTransforms.build().map((v) => v.build())).build()
            : null,
        propertyTransforms: propertyTransforms != null
            ? new SetBuilder<PropertyTransform>(
                propertyTransforms.build().map((v) => v.build())).build()
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

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class PropertyTransform
// **************************************************************************

class _$PropertyTransform extends PropertyTransform {
  final BuiltList<String> fromPathSegments;
  final BuiltList<String> toPathSegments;
  final Option<String> transformName;
  final bool isCollection;
  final bool requiresToBuilder;
  _$PropertyTransform._(
      {this.fromPathSegments,
      this.toPathSegments,
      this.transformName,
      this.isCollection,
      this.requiresToBuilder})
      : super._() {
    if (fromPathSegments == null)
      throw new ArgumentError('null fromPathSegments');
    if (toPathSegments == null) throw new ArgumentError('null toPathSegments');
    if (transformName == null) throw new ArgumentError('null transformName');
    if (isCollection == null) throw new ArgumentError('null isCollection');
    if (requiresToBuilder == null)
      throw new ArgumentError('null requiresToBuilder');
  }
  factory _$PropertyTransform([updates(PropertyTransformBuilder b)]) =>
      (new PropertyTransformBuilder()..update(updates)).build();
  PropertyTransform rebuild(updates(PropertyTransformBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$PropertyTransformBuilder toBuilder() =>
      new _$PropertyTransformBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! PropertyTransform) return false;
    return fromPathSegments == other.fromPathSegments &&
        toPathSegments == other.toPathSegments &&
        transformName == other.transformName &&
        isCollection == other.isCollection &&
        requiresToBuilder == other.requiresToBuilder;
  }

  int get hashCode {
    return hashObjects([
      fromPathSegments,
      toPathSegments,
      transformName,
      isCollection,
      requiresToBuilder
    ]);
  }

  String toString() {
    return 'PropertyTransform {'
        'fromPathSegments=${fromPathSegments.toString()}\n'
        'toPathSegments=${toPathSegments.toString()}\n'
        'transformName=${transformName.toString()}\n'
        'isCollection=${isCollection.toString()}\n'
        'requiresToBuilder=${requiresToBuilder.toString()}\n'
        '}';
  }
}

class _$PropertyTransformBuilder extends PropertyTransformBuilder {
  _$PropertyTransformBuilder() : super._();
  void replace(PropertyTransform other) {
    super.fromPathSegments = other.fromPathSegments;
    super.toPathSegments = other.toPathSegments;
    super.transformName = other.transformName;
    super.isCollection = other.isCollection;
    super.requiresToBuilder = other.requiresToBuilder;
  }

  void update(updates(PropertyTransformBuilder b)) {
    if (updates != null) updates(this);
  }

  PropertyTransform build() {
    if (fromPathSegments == null)
      throw new ArgumentError('null fromPathSegments');
    if (toPathSegments == null) throw new ArgumentError('null toPathSegments');
    if (transformName == null) throw new ArgumentError('null transformName');
    if (isCollection == null) throw new ArgumentError('null isCollection');
    if (requiresToBuilder == null)
      throw new ArgumentError('null requiresToBuilder');
    return new _$PropertyTransform._(
        fromPathSegments: fromPathSegments,
        toPathSegments: toPathSegments,
        transformName: transformName,
        isCollection: isCollection,
        requiresToBuilder: requiresToBuilder);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformationContextMetaModel
// **************************************************************************

class _$TransformationContextMetaModel extends TransformationContextMetaModel {
  _$TransformationContextMetaModel._() : super._() {}
  factory _$TransformationContextMetaModel(
          [updates(TransformationContextMetaModelBuilder b)]) =>
      (new TransformationContextMetaModelBuilder()..update(updates)).build();
  TransformationContextMetaModel rebuild(
          updates(TransformationContextMetaModelBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$TransformationContextMetaModelBuilder toBuilder() =>
      new _$TransformationContextMetaModelBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! TransformationContextMetaModel) return false;
    return true;
  }

  int get hashCode {
    return 200256111;
  }

  String toString() {
    return 'TransformationContextMetaModel {}';
  }
}

class _$TransformationContextMetaModelBuilder
    extends TransformationContextMetaModelBuilder {
  _$TransformationContextMetaModelBuilder() : super._();
  void replace(TransformationContextMetaModel other) {}
  void update(updates(TransformationContextMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformationContextMetaModel build() {
    return new _$TransformationContextMetaModel._();
  }
}
