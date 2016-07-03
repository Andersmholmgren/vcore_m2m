// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-07-02T02:23:17.170391Z

part of transformer_meta;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class PackageTransformationMetaModel
// **************************************************************************

class _$PackageTransformationMetaModel extends PackageTransformationMetaModel {
  final TransformationContextMetaModel context;
  final Uri packageRelationPackageUri;
  final Uri sourceModelPackageUri;
  final String fromPackageName;
  final String toPackageName;
  _$PackageTransformationMetaModel._(
      {this.context,
      this.packageRelationPackageUri,
      this.sourceModelPackageUri,
      this.fromPackageName,
      this.toPackageName})
      : super._() {
    if (context == null) throw new ArgumentError('null context');
    if (packageRelationPackageUri == null)
      throw new ArgumentError('null packageRelationPackageUri');
    if (sourceModelPackageUri == null)
      throw new ArgumentError('null sourceModelPackageUri');
    if (fromPackageName == null)
      throw new ArgumentError('null fromPackageName');
    if (toPackageName == null) throw new ArgumentError('null toPackageName');
  }
  factory _$PackageTransformationMetaModel(
          [updates(PackageTransformationMetaModelBuilder b)]) =>
      (new PackageTransformationMetaModelBuilder()..update(updates)).build();
  PackageTransformationMetaModel rebuild(
          updates(PackageTransformationMetaModelBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$PackageTransformationMetaModelBuilder toBuilder() =>
      new _$PackageTransformationMetaModelBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! PackageTransformationMetaModel) return false;
    return context == other.context &&
        packageRelationPackageUri == other.packageRelationPackageUri &&
        sourceModelPackageUri == other.sourceModelPackageUri &&
        fromPackageName == other.fromPackageName &&
        toPackageName == other.toPackageName;
  }

  int get hashCode {
    return hashObjects([
      context,
      packageRelationPackageUri,
      sourceModelPackageUri,
      fromPackageName,
      toPackageName
    ]);
  }

  String toString() {
    return 'PackageTransformationMetaModel {'
        'context=${context.toString()}\n'
        'packageRelationPackageUri=${packageRelationPackageUri.toString()}\n'
        'sourceModelPackageUri=${sourceModelPackageUri.toString()}\n'
        'fromPackageName=${fromPackageName.toString()}\n'
        'toPackageName=${toPackageName.toString()}\n'
        '}';
  }
}

class _$PackageTransformationMetaModelBuilder
    extends PackageTransformationMetaModelBuilder {
  _$PackageTransformationMetaModelBuilder() : super._();
  void replace(PackageTransformationMetaModel other) {
    super.context = other.context?.toBuilder();
    super.packageRelationPackageUri = other.packageRelationPackageUri;
    super.sourceModelPackageUri = other.sourceModelPackageUri;
    super.fromPackageName = other.fromPackageName;
    super.toPackageName = other.toPackageName;
  }

  void update(updates(PackageTransformationMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  PackageTransformationMetaModel build() {
    if (context == null) throw new ArgumentError('null context');
    if (packageRelationPackageUri == null)
      throw new ArgumentError('null packageRelationPackageUri');
    if (sourceModelPackageUri == null)
      throw new ArgumentError('null sourceModelPackageUri');
    if (fromPackageName == null)
      throw new ArgumentError('null fromPackageName');
    if (toPackageName == null) throw new ArgumentError('null toPackageName');
    return new _$PackageTransformationMetaModel._(
        context: context?.build(),
        packageRelationPackageUri: packageRelationPackageUri,
        sourceModelPackageUri: sourceModelPackageUri,
        fromPackageName: fromPackageName,
        toPackageName: toPackageName);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformationMetaModel
// **************************************************************************

class _$TransformationMetaModel extends TransformationMetaModel {
  final String fromTypeName;
  final String toTypeName;
  final BuiltSet<PropertyTransform> propertyTransforms;
  _$TransformationMetaModel._(
      {this.fromTypeName, this.toTypeName, this.propertyTransforms})
      : super._() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
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
        propertyTransforms == other.propertyTransforms;
  }

  int get hashCode {
    return hashObjects([fromTypeName, toTypeName, propertyTransforms]);
  }

  String toString() {
    return 'TransformationMetaModel {'
        'fromTypeName=${fromTypeName.toString()}\n'
        'toTypeName=${toTypeName.toString()}\n'
        'propertyTransforms=${propertyTransforms.toString()}\n'
        '}';
  }
}

class _$TransformationMetaModelBuilder extends TransformationMetaModelBuilder {
  _$TransformationMetaModelBuilder() : super._();
  void replace(TransformationMetaModel other) {
    super.fromTypeName = other.fromTypeName;
    super.toTypeName = other.toTypeName;
    super.propertyTransforms = new SetBuilder<PropertyTransformBuilder>(
        other.propertyTransforms?.map((tp) => tp.toBuilder()));
  }

  void update(updates(TransformationMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformationMetaModel build() {
    if (fromTypeName == null) throw new ArgumentError('null fromTypeName');
    if (toTypeName == null) throw new ArgumentError('null toTypeName');
    if (propertyTransforms == null)
      throw new ArgumentError('null propertyTransforms');
    return new _$TransformationMetaModel._(
        fromTypeName: fromTypeName,
        toTypeName: toTypeName,
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
  final Classifier fromSimpleType;
  final Classifier toSimpleType;
  final BuiltList<String> fromPathSegments;
  final BuiltList<String> toPathSegments;
  final bool hasCustomTransform;
  final bool isCollection;
  final bool requiresToBuilder;
  final bool isAbstract;
  _$PropertyTransform._(
      {this.fromSimpleType,
      this.toSimpleType,
      this.fromPathSegments,
      this.toPathSegments,
      this.hasCustomTransform,
      this.isCollection,
      this.requiresToBuilder,
      this.isAbstract})
      : super._() {
    if (fromSimpleType == null) throw new ArgumentError('null fromSimpleType');
    if (toSimpleType == null) throw new ArgumentError('null toSimpleType');
    if (fromPathSegments == null)
      throw new ArgumentError('null fromPathSegments');
    if (toPathSegments == null) throw new ArgumentError('null toPathSegments');
    if (hasCustomTransform == null)
      throw new ArgumentError('null hasCustomTransform');
    if (isCollection == null) throw new ArgumentError('null isCollection');
    if (requiresToBuilder == null)
      throw new ArgumentError('null requiresToBuilder');
    if (isAbstract == null) throw new ArgumentError('null isAbstract');
  }
  factory _$PropertyTransform([updates(PropertyTransformBuilder b)]) =>
      (new PropertyTransformBuilder()..update(updates)).build();
  PropertyTransform rebuild(updates(PropertyTransformBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$PropertyTransformBuilder toBuilder() =>
      new _$PropertyTransformBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! PropertyTransform) return false;
    return fromSimpleType == other.fromSimpleType &&
        toSimpleType == other.toSimpleType &&
        fromPathSegments == other.fromPathSegments &&
        toPathSegments == other.toPathSegments &&
        hasCustomTransform == other.hasCustomTransform &&
        isCollection == other.isCollection &&
        requiresToBuilder == other.requiresToBuilder &&
        isAbstract == other.isAbstract;
  }

  int get hashCode {
    return hashObjects([
      fromSimpleType,
      toSimpleType,
      fromPathSegments,
      toPathSegments,
      hasCustomTransform,
      isCollection,
      requiresToBuilder,
      isAbstract
    ]);
  }

  String toString() {
    return 'PropertyTransform {'
        'fromSimpleType=${fromSimpleType.toString()}\n'
        'toSimpleType=${toSimpleType.toString()}\n'
        'fromPathSegments=${fromPathSegments.toString()}\n'
        'toPathSegments=${toPathSegments.toString()}\n'
        'hasCustomTransform=${hasCustomTransform.toString()}\n'
        'isCollection=${isCollection.toString()}\n'
        'requiresToBuilder=${requiresToBuilder.toString()}\n'
        'isAbstract=${isAbstract.toString()}\n'
        '}';
  }
}

class _$PropertyTransformBuilder extends PropertyTransformBuilder {
  _$PropertyTransformBuilder() : super._();
  void replace(PropertyTransform other) {
    super.fromSimpleType = other.fromSimpleType;
    super.toSimpleType = other.toSimpleType;
    super.fromPathSegments = other.fromPathSegments;
    super.toPathSegments = other.toPathSegments;
    super.hasCustomTransform = other.hasCustomTransform;
    super.isCollection = other.isCollection;
    super.requiresToBuilder = other.requiresToBuilder;
    super.isAbstract = other.isAbstract;
  }

  void update(updates(PropertyTransformBuilder b)) {
    if (updates != null) updates(this);
  }

  PropertyTransform build() {
    if (fromSimpleType == null) throw new ArgumentError('null fromSimpleType');
    if (toSimpleType == null) throw new ArgumentError('null toSimpleType');
    if (fromPathSegments == null)
      throw new ArgumentError('null fromPathSegments');
    if (toPathSegments == null) throw new ArgumentError('null toPathSegments');
    if (hasCustomTransform == null)
      throw new ArgumentError('null hasCustomTransform');
    if (isCollection == null) throw new ArgumentError('null isCollection');
    if (requiresToBuilder == null)
      throw new ArgumentError('null requiresToBuilder');
    if (isAbstract == null) throw new ArgumentError('null isAbstract');
    return new _$PropertyTransform._(
        fromSimpleType: fromSimpleType,
        toSimpleType: toSimpleType,
        fromPathSegments: fromPathSegments,
        toPathSegments: toPathSegments,
        hasCustomTransform: hasCustomTransform,
        isCollection: isCollection,
        requiresToBuilder: requiresToBuilder,
        isAbstract: isAbstract);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TransformationContextMetaModel
// **************************************************************************

class _$TransformationContextMetaModel extends TransformationContextMetaModel {
  final BuiltSet<TransformationMetaModel> transformations;
  final BuiltSet<AbstractTypeMapping> abstractTypeMappings;
  _$TransformationContextMetaModel._(
      {this.transformations, this.abstractTypeMappings})
      : super._() {
    if (transformations == null)
      throw new ArgumentError('null transformations');
    if (abstractTypeMappings == null)
      throw new ArgumentError('null abstractTypeMappings');
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
    return transformations == other.transformations &&
        abstractTypeMappings == other.abstractTypeMappings;
  }

  int get hashCode {
    return hashObjects([transformations, abstractTypeMappings]);
  }

  String toString() {
    return 'TransformationContextMetaModel {'
        'transformations=${transformations.toString()}\n'
        'abstractTypeMappings=${abstractTypeMappings.toString()}\n'
        '}';
  }
}

class _$TransformationContextMetaModelBuilder
    extends TransformationContextMetaModelBuilder {
  _$TransformationContextMetaModelBuilder() : super._();
  void replace(TransformationContextMetaModel other) {
    super.transformations = new SetBuilder<TransformationMetaModelBuilder>(
        other.transformations?.map((tp) => tp.toBuilder()));
    super.abstractTypeMappings = new SetBuilder<AbstractTypeMappingBuilder>(
        other.abstractTypeMappings?.map((tp) => tp.toBuilder()));
  }

  void update(updates(TransformationContextMetaModelBuilder b)) {
    if (updates != null) updates(this);
  }

  TransformationContextMetaModel build() {
    if (transformations == null)
      throw new ArgumentError('null transformations');
    if (abstractTypeMappings == null)
      throw new ArgumentError('null abstractTypeMappings');
    return new _$TransformationContextMetaModel._(
        transformations: transformations != null
            ? new SetBuilder<TransformationMetaModel>(
                transformations.build().map((v) => v.build())).build()
            : null,
        abstractTypeMappings: abstractTypeMappings != null
            ? new SetBuilder<AbstractTypeMapping>(
                abstractTypeMappings.build().map((v) => v.build())).build()
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
    super.subTypeMappings = new SetBuilder<TransformMetaModelBuilder>(
        other.subTypeMappings?.map((tp) => tp.toBuilder()));
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
