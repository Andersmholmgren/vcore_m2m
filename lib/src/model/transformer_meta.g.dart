// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-07-02T00:07:33.648280Z

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
  final String fromTypeName;
  final String toTypeName;
  final BuiltList<String> fromPathSegments;
  final BuiltList<String> toPathSegments;
  final Option<String> transformName;
  final bool hasCustomTransform;
  final bool isCollection;
  final bool requiresToBuilder;
  _$PropertyTransform._(
      {this.fromTypeName,
      this.toTypeName,
      this.fromPathSegments,
      this.toPathSegments,
      this.transformName,
      this.hasCustomTransform,
      this.isCollection,
      this.requiresToBuilder})
      : super._() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (fromPathSegments == null)
      throw new ArgumentError('null fromPathSegments');
    if (toPathSegments == null) throw new ArgumentError('null toPathSegments');
    if (transformName == null) throw new ArgumentError('null transformName');
    if (hasCustomTransform == null)
      throw new ArgumentError('null hasCustomTransform');
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
    return fromTypeName == other.fromTypeName &&
        toTypeName == other.toTypeName &&
        fromPathSegments == other.fromPathSegments &&
        toPathSegments == other.toPathSegments &&
        transformName == other.transformName &&
        hasCustomTransform == other.hasCustomTransform &&
        isCollection == other.isCollection &&
        requiresToBuilder == other.requiresToBuilder;
  }

  int get hashCode {
    return hashObjects([
      fromTypeName,
      toTypeName,
      fromPathSegments,
      toPathSegments,
      transformName,
      hasCustomTransform,
      isCollection,
      requiresToBuilder
    ]);
  }

  String toString() {
    return 'PropertyTransform {'
        'fromTypeName=${fromTypeName.toString()}\n'
        'toTypeName=${toTypeName.toString()}\n'
        'fromPathSegments=${fromPathSegments.toString()}\n'
        'toPathSegments=${toPathSegments.toString()}\n'
        'transformName=${transformName.toString()}\n'
        'hasCustomTransform=${hasCustomTransform.toString()}\n'
        'isCollection=${isCollection.toString()}\n'
        'requiresToBuilder=${requiresToBuilder.toString()}\n'
        '}';
  }
}

class _$PropertyTransformBuilder extends PropertyTransformBuilder {
  _$PropertyTransformBuilder() : super._();
  void replace(PropertyTransform other) {
    super.fromTypeName = other.fromTypeName;
    super.toTypeName = other.toTypeName;
    super.fromPathSegments = other.fromPathSegments;
    super.toPathSegments = other.toPathSegments;
    super.transformName = other.transformName;
    super.hasCustomTransform = other.hasCustomTransform;
    super.isCollection = other.isCollection;
    super.requiresToBuilder = other.requiresToBuilder;
  }

  void update(updates(PropertyTransformBuilder b)) {
    if (updates != null) updates(this);
  }

  PropertyTransform build() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (fromPathSegments == null)
      throw new ArgumentError('null fromPathSegments');
    if (toPathSegments == null) throw new ArgumentError('null toPathSegments');
    if (transformName == null) throw new ArgumentError('null transformName');
    if (hasCustomTransform == null)
      throw new ArgumentError('null hasCustomTransform');
    if (isCollection == null) throw new ArgumentError('null isCollection');
    if (requiresToBuilder == null)
      throw new ArgumentError('null requiresToBuilder');
    return new _$PropertyTransform._(
        fromTypeName: fromTypeName,
        toTypeName: toTypeName,
        fromPathSegments: fromPathSegments,
        toPathSegments: toPathSegments,
        transformName: transformName,
        hasCustomTransform: hasCustomTransform,
        isCollection: isCollection,
        requiresToBuilder: requiresToBuilder);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformationContextMetaModel
// **************************************************************************

class _$TransformationContextMetaModel extends TransformationContextMetaModel {
  final BuiltSet<TransformationMetaModel> transformations;
  _$TransformationContextMetaModel._({this.transformations}) : super._() {
    if (transformations == null)
      throw new ArgumentError('null transformations');
  }
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
    return transformations == other.transformations;
  }

  int get hashCode {
    return hashObjects([transformations]);
  }

  String toString() {
    return 'TransformationContextMetaModel {'
        'transformations=${transformations.toString()}\n'
        '}';
  }
}

class _$TransformationContextMetaModelBuilder
    extends TransformationContextMetaModelBuilder {
  _$TransformationContextMetaModelBuilder() : super._();
  void replace(TransformationContextMetaModel other) {
    super.transformations = other.transformations?.toBuilder();
  }

  void update(updates(TransformationContextMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformationContextMetaModel build() {
    if (transformations == null)
      throw new ArgumentError('null transformations');
    return new _$TransformationContextMetaModel._(
        transformations: transformations != null
            ? new SetBuilder<TransformationMetaModel>(
                transformations.build().map((v) => v.build())).build()
            : null);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class AbstractTypeMapping
// **************************************************************************

class _$AbstractTypeMapping extends AbstractTypeMapping {
  final String fromTypeName;
  final String toTypeName;
  final BuiltSet<TransformMetaModel> subTypeMappings;
  _$AbstractTypeMapping._(
      {this.fromTypeName, this.toTypeName, this.subTypeMappings})
      : super._() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (subTypeMappings == null)
      throw new ArgumentError('null subTypeMappings');
  }
  factory _$AbstractTypeMapping([updates(AbstractTypeMappingBuilder b)]) =>
      (new AbstractTypeMappingBuilder()..update(updates)).build();
  AbstractTypeMapping rebuild(updates(AbstractTypeMappingBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$AbstractTypeMappingBuilder toBuilder() =>
      new _$AbstractTypeMappingBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! AbstractTypeMapping) return false;
    return fromTypeName == other.fromTypeName &&
        toTypeName == other.toTypeName &&
        subTypeMappings == other.subTypeMappings;
  }

  int get hashCode {
    return hashObjects([fromTypeName, toTypeName, subTypeMappings]);
  }

  String toString() {
    return 'AbstractTypeMapping {'
        'fromTypeName=${fromTypeName.toString()}\n'
        'toTypeName=${toTypeName.toString()}\n'
        'subTypeMappings=${subTypeMappings.toString()}\n'
        '}';
  }
}

class _$AbstractTypeMappingBuilder extends AbstractTypeMappingBuilder {
  _$AbstractTypeMappingBuilder() : super._();
  void replace(AbstractTypeMapping other) {
    super.fromTypeName = other.fromTypeName;
    super.toTypeName = other.toTypeName;
    super.subTypeMappings = other.subTypeMappings?.toBuilder();
  }

  void update(updates(AbstractTypeMappingBuilder b)) {
    if (updates != null) updates(this);
  }

  AbstractTypeMapping build() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (subTypeMappings == null)
      throw new ArgumentError('null subTypeMappings');
    return new _$AbstractTypeMapping._(
        fromTypeName: fromTypeName,
        toTypeName: toTypeName,
        subTypeMappings: subTypeMappings != null
            ? new SetBuilder<TransformMetaModel>(
                subTypeMappings.build().map((v) => v.build())).build()
            : null);
  }
}
