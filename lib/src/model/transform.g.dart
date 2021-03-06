// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-06-18T01:18:42.744576Z

part of transform;

// **************************************************************************
// Generator: BuiltJsonGenerator
// Target: library transform
// **************************************************************************

Serializer<PackageRelation> _$packageRelationSerializer =
    new _$PackageRelationSerializer();
Serializer<ValueClassRelation> _$valueClassRelationSerializer =
    new _$ValueClassRelationSerializer();
Serializer<PropertyRelation> _$propertyRelationSerializer =
    new _$PropertyRelationSerializer();
Serializer<SchemeBasedNameRelation> _$schemeBasedNameRelationSerializer =
    new _$SchemeBasedNameRelationSerializer();

class _$PackageRelationSerializer
    implements StructuredSerializer<PackageRelation> {
  final Iterable<Type> types =
      new BuiltList<Type>([PackageRelation, _$PackageRelation]);
  final String wireName = 'PackageRelation';

  @override
  Iterable serialize(Serializers serializers, PackageRelation object,
      {FullType specifiedType: FullType.unspecified}) {
    return [
      'from',
      serializers.serialize(object.from,
          specifiedType: const FullType(Package)),
      'to',
      serializers.serialize(object.to, specifiedType: const FullType(Package)),
      'reflectFrom',
      serializers.serialize(object.reflectFrom,
          specifiedType: const FullType(VCoreMirrorSystem)),
      'reflectTo',
      serializers.serialize(object.reflectTo,
          specifiedType: const FullType(VCoreMirrorSystem)),
      'classifierRelations',
      serializers.serialize(object.classifierRelations,
          specifiedType: const FullType(
              BuiltSet, const [const FullType(ClassifierRelation)])),
    ];
  }

  @override
  PackageRelation deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PackageRelationBuilder();

    var key;
    var value;
    var expectingKey = true;
    for (final item in serialized) {
      if (expectingKey) {
        key = item;
        expectingKey = false;
      } else {
        value = item;
        expectingKey = true;

        switch (key as String) {
          case 'from':
            result.from = serializers.deserialize(value,
                specifiedType: const FullType(Package));
            break;
          case 'to':
            result.to = serializers.deserialize(value,
                specifiedType: const FullType(Package));
            break;
          case 'reflectFrom':
            result.reflectFrom = serializers.deserialize(value,
                specifiedType: const FullType(VCoreMirrorSystem));
            break;
          case 'reflectTo':
            result.reflectTo = serializers.deserialize(value,
                specifiedType: const FullType(VCoreMirrorSystem));
            break;
          case 'classifierRelations':
            result.classifierRelations.replace(serializers.deserialize(value,
                specifiedType: const FullType(
                    BuiltSet, const [const FullType(ClassifierRelation)])));
            break;
        }
      }
    }

    return result.build();
  }
}

class _$ValueClassRelationSerializer
    implements StructuredSerializer<ValueClassRelation> {
  final Iterable<Type> types =
      new BuiltList<Type>([ValueClassRelation, _$ValueClassRelation]);
  final String wireName = 'ValueClassRelation';

  @override
  Iterable serialize(Serializers serializers, ValueClassRelation object,
      {FullType specifiedType: FullType.unspecified}) {
    return [
      'from',
      serializers.serialize(object.from,
          specifiedType: const FullType(ValueClass)),
      'to',
      serializers.serialize(object.to,
          specifiedType: const FullType(ValueClass)),
      'propertyRelations',
      serializers.serialize(object.propertyRelations,
          specifiedType: const FullType(
              BuiltSet, const [const FullType(PropertyRelation)])),
    ];
  }

  @override
  ValueClassRelation deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ValueClassRelationBuilder();

    var key;
    var value;
    var expectingKey = true;
    for (final item in serialized) {
      if (expectingKey) {
        key = item;
        expectingKey = false;
      } else {
        value = item;
        expectingKey = true;

        switch (key as String) {
          case 'from':
            result.from = serializers.deserialize(value,
                specifiedType: const FullType(ValueClass));
            break;
          case 'to':
            result.to = serializers.deserialize(value,
                specifiedType: const FullType(ValueClass));
            break;
          case 'propertyRelations':
            result.propertyRelations.replace(serializers.deserialize(value,
                specifiedType: const FullType(
                    BuiltSet, const [const FullType(PropertyRelation)])));
            break;
        }
      }
    }

    return result.build();
  }
}

class _$PropertyRelationSerializer
    implements StructuredSerializer<PropertyRelation> {
  final Iterable<Type> types =
      new BuiltList<Type>([PropertyRelation, _$PropertyRelation]);
  final String wireName = 'PropertyRelation';

  @override
  Iterable serialize(Serializers serializers, PropertyRelation object,
      {FullType specifiedType: FullType.unspecified}) {
    return [
      'from',
      serializers.serialize(object.from,
          specifiedType: const FullType(PropertyRelationEnd)),
      'to',
      serializers.serialize(object.to,
          specifiedType: const FullType(PropertyRelationEnd)),
      'nameRelation',
      serializers.serialize(object.nameRelation,
          specifiedType: const FullType(NameRelation)),
      'transform',
      serializers.serialize(object.transform,
          specifiedType: const FullType(BidirectionalTransform)),
    ];
  }

  @override
  PropertyRelation deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PropertyRelationBuilder();

    var key;
    var value;
    var expectingKey = true;
    for (final item in serialized) {
      if (expectingKey) {
        key = item;
        expectingKey = false;
      } else {
        value = item;
        expectingKey = true;

        switch (key as String) {
          case 'from':
            result.from.replace(serializers.deserialize(value,
                specifiedType: const FullType(PropertyRelationEnd)));
            break;
          case 'to':
            result.to.replace(serializers.deserialize(value,
                specifiedType: const FullType(PropertyRelationEnd)));
            break;
          case 'nameRelation':
            result.nameRelation = serializers.deserialize(value,
                specifiedType: const FullType(NameRelation));
            break;
          case 'transform':
            result.transform = serializers.deserialize(value,
                specifiedType: const FullType(BidirectionalTransform));
            break;
        }
      }
    }

    return result.build();
  }
}

class _$SchemeBasedNameRelationSerializer
    implements StructuredSerializer<SchemeBasedNameRelation> {
  final Iterable<Type> types =
      new BuiltList<Type>([SchemeBasedNameRelation, _$SchemeBasedNameRelation]);
  final String wireName = 'SchemeBasedNameRelation';

  @override
  Iterable serialize(Serializers serializers, SchemeBasedNameRelation object,
      {FullType specifiedType: FullType.unspecified}) {
    return [
      'forwardConversion',
      serializers.serialize(object.forwardConversion,
          specifiedType: const FullType(NameConversion)),
      'reverseConversion',
      serializers.serialize(object.reverseConversion,
          specifiedType: const FullType(NameConversion)),
    ];
  }

  @override
  SchemeBasedNameRelation deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new SchemeBasedNameRelationBuilder();

    var key;
    var value;
    var expectingKey = true;
    for (final item in serialized) {
      if (expectingKey) {
        key = item;
        expectingKey = false;
      } else {
        value = item;
        expectingKey = true;

        switch (key as String) {
          case 'forwardConversion':
            result.forwardConversion = serializers.deserialize(value,
                specifiedType: const FullType(NameConversion));
            break;
          case 'reverseConversion':
            result.reverseConversion = serializers.deserialize(value,
                specifiedType: const FullType(NameConversion));
            break;
        }
      }
    }

    return result.build();
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class PackageRelation
// **************************************************************************

class _$PackageRelation extends PackageRelation {
  final Package from;
  final Package to;
  final VCoreMirrorSystem reflectFrom;
  final VCoreMirrorSystem reflectTo;
  final BuiltSet<ClassifierRelation> classifierRelations;
  _$PackageRelation._(
      {this.from,
      this.to,
      this.reflectFrom,
      this.reflectTo,
      this.classifierRelations})
      : super._() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    if (reflectFrom == null) throw new ArgumentError('null reflectFrom');
    if (reflectTo == null) throw new ArgumentError('null reflectTo');
    if (classifierRelations == null)
      throw new ArgumentError('null classifierRelations');
  }
  factory _$PackageRelation([updates(PackageRelationBuilder b)]) =>
      (new PackageRelationBuilder()..update(updates)).build();
  PackageRelation rebuild(updates(PackageRelationBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$PackageRelationBuilder toBuilder() =>
      new _$PackageRelationBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! PackageRelation) return false;
    return from == other.from &&
        to == other.to &&
        reflectFrom == other.reflectFrom &&
        reflectTo == other.reflectTo &&
        classifierRelations == other.classifierRelations;
  }

  int get hashCode {
    return hashObjects([from, to, reflectFrom, reflectTo, classifierRelations]);
  }

  String toString() {
    return 'PackageRelation {'
        'from=${from.toString()}\n'
        'to=${to.toString()}\n'
        'reflectFrom=${reflectFrom.toString()}\n'
        'reflectTo=${reflectTo.toString()}\n'
        'classifierRelations=${classifierRelations.toString()}\n'
        '}';
  }
}

class _$PackageRelationBuilder extends PackageRelationBuilder {
  _$PackageRelationBuilder() : super._();
  void replace(PackageRelation other) {
    super.from = other.from;
    super.to = other.to;
    super.reflectFrom = other.reflectFrom;
    super.reflectTo = other.reflectTo;
    super.classifierRelations = other.classifierRelations?.toBuilder();
  }

  void update(updates(PackageRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  PackageRelation build() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    if (reflectFrom == null) throw new ArgumentError('null reflectFrom');
    if (reflectTo == null) throw new ArgumentError('null reflectTo');
    if (classifierRelations == null)
      throw new ArgumentError('null classifierRelations');
    return new _$PackageRelation._(
        from: from,
        to: to,
        reflectFrom: reflectFrom,
        reflectTo: reflectTo,
        classifierRelations: classifierRelations?.build());
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class BidirectionalTransform
// **************************************************************************

class _$BidirectionalTransform extends BidirectionalTransform {
  final Transform forwards;
  final Transform backwards;
  _$BidirectionalTransform._({this.forwards, this.backwards}) : super._() {
    if (forwards == null) throw new ArgumentError('null forwards');
    if (backwards == null) throw new ArgumentError('null backwards');
  }
  factory _$BidirectionalTransform(
          [updates(BidirectionalTransformBuilder b)]) =>
      (new BidirectionalTransformBuilder()..update(updates)).build();
  BidirectionalTransform rebuild(updates(BidirectionalTransformBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$BidirectionalTransformBuilder toBuilder() =>
      new _$BidirectionalTransformBuilder()..replace(this);
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

class _$BidirectionalTransformBuilder extends BidirectionalTransformBuilder {
  _$BidirectionalTransformBuilder() : super._();
  void replace(BidirectionalTransform other) {
    super.forwards = other.forwards;
    super.backwards = other.backwards;
  }

  void update(updates(BidirectionalTransformBuilder b)) {
    if (updates != null) updates(this);
  }

  BidirectionalTransform build() {
    if (forwards == null) throw new ArgumentError('null forwards');
    if (backwards == null) throw new ArgumentError('null backwards');
    return new _$BidirectionalTransform._(
        forwards: forwards, backwards: backwards);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class ValueClassRelation
// **************************************************************************

class _$ValueClassRelation extends ValueClassRelation {
  final ValueClass from;
  final ValueClass to;
  final BuiltSet<PropertyRelation> propertyRelations;
  _$ValueClassRelation._({this.from, this.to, this.propertyRelations})
      : super._() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    if (propertyRelations == null)
      throw new ArgumentError('null propertyRelations');
  }
  factory _$ValueClassRelation([updates(ValueClassRelationBuilder b)]) =>
      (new ValueClassRelationBuilder()..update(updates)).build();
  ValueClassRelation rebuild(updates(ValueClassRelationBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$ValueClassRelationBuilder toBuilder() =>
      new _$ValueClassRelationBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! ValueClassRelation) return false;
    return from == other.from &&
        to == other.to &&
        propertyRelations == other.propertyRelations;
  }

  int get hashCode {
    return hashObjects([from, to, propertyRelations]);
  }

  String toString() {
    return 'ValueClassRelation {'
        'from=${from.toString()}\n'
        'to=${to.toString()}\n'
        'propertyRelations=${propertyRelations.toString()}\n'
        '}';
  }
}

class _$ValueClassRelationBuilder extends ValueClassRelationBuilder {
  _$ValueClassRelationBuilder() : super._();
  void replace(ValueClassRelation other) {
    super.from = other.from;
    super.to = other.to;
    super.propertyRelations = other.propertyRelations?.toBuilder();
  }

  void update(updates(ValueClassRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  ValueClassRelation build() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    if (propertyRelations == null)
      throw new ArgumentError('null propertyRelations');
    return new _$ValueClassRelation._(
        from: from, to: to, propertyRelations: propertyRelations?.build());
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class PropertyRelation
// **************************************************************************

class _$PropertyRelation extends PropertyRelation {
  final PropertyRelationEnd from;
  final PropertyRelationEnd to;
  final NameRelation nameRelation;
  final BidirectionalTransform transform;
  _$PropertyRelation._({this.from, this.to, this.nameRelation, this.transform})
      : super._() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
  }
  factory _$PropertyRelation([updates(PropertyRelationBuilder b)]) =>
      (new PropertyRelationBuilder()..update(updates)).build();
  PropertyRelation rebuild(updates(PropertyRelationBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$PropertyRelationBuilder toBuilder() =>
      new _$PropertyRelationBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! PropertyRelation) return false;
    return from == other.from &&
        to == other.to &&
        nameRelation == other.nameRelation &&
        transform == other.transform;
  }

  int get hashCode {
    return hashObjects([from, to, nameRelation, transform]);
  }

  String toString() {
    return 'PropertyRelation {'
        'from=${from.toString()}\n'
        'to=${to.toString()}\n'
        'nameRelation=${nameRelation.toString()}\n'
        'transform=${transform.toString()}\n'
        '}';
  }
}

class _$PropertyRelationBuilder extends PropertyRelationBuilder {
  _$PropertyRelationBuilder() : super._();
  void replace(PropertyRelation other) {
    super.from = other.from?.toBuilder();
    super.to = other.to?.toBuilder();
    super.nameRelation = other.nameRelation;
    super.transform = other.transform;
  }

  void update(updates(PropertyRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  PropertyRelation build() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    return new _$PropertyRelation._(
        from: from?.build(),
        to: to?.build(),
        nameRelation: nameRelation,
        transform: transform);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class PropertyRelationEnd
// **************************************************************************

class _$PropertyRelationEnd extends PropertyRelationEnd {
  final BuiltList<String> path;
  final Property property;
  _$PropertyRelationEnd._({this.path, this.property}) : super._() {
    if (path == null) throw new ArgumentError('null path');
    if (property == null) throw new ArgumentError('null property');
  }
  factory _$PropertyRelationEnd([updates(PropertyRelationEndBuilder b)]) =>
      (new PropertyRelationEndBuilder()..update(updates)).build();
  PropertyRelationEnd rebuild(updates(PropertyRelationEndBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$PropertyRelationEndBuilder toBuilder() =>
      new _$PropertyRelationEndBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! PropertyRelationEnd) return false;
    return path == other.path && property == other.property;
  }

  int get hashCode {
    return hashObjects([path, property]);
  }

  String toString() {
    return 'PropertyRelationEnd {'
        'path=${path.toString()}\n'
        'property=${property.toString()}\n'
        '}';
  }
}

class _$PropertyRelationEndBuilder extends PropertyRelationEndBuilder {
  _$PropertyRelationEndBuilder() : super._();
  void replace(PropertyRelationEnd other) {
    super.path = other.path;
    super.property = other.property;
  }

  void update(updates(PropertyRelationEndBuilder b)) {
    if (updates != null) updates(this);
  }

  PropertyRelationEnd build() {
    if (path == null) throw new ArgumentError('null path');
    if (property == null) throw new ArgumentError('null property');
    return new _$PropertyRelationEnd._(path: path, property: property);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class SchemeBasedNameRelation
// **************************************************************************

class _$SchemeBasedNameRelation extends SchemeBasedNameRelation {
  final NameConversion forwardConversion;
  final NameConversion reverseConversion;
  _$SchemeBasedNameRelation._({this.forwardConversion, this.reverseConversion})
      : super._() {
    if (forwardConversion == null)
      throw new ArgumentError('null forwardConversion');
    if (reverseConversion == null)
      throw new ArgumentError('null reverseConversion');
  }
  factory _$SchemeBasedNameRelation(
          [updates(SchemeBasedNameRelationBuilder b)]) =>
      (new SchemeBasedNameRelationBuilder()..update(updates)).build();
  SchemeBasedNameRelation rebuild(updates(SchemeBasedNameRelationBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$SchemeBasedNameRelationBuilder toBuilder() =>
      new _$SchemeBasedNameRelationBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! SchemeBasedNameRelation) return false;
    return forwardConversion == other.forwardConversion &&
        reverseConversion == other.reverseConversion;
  }

  int get hashCode {
    return hashObjects([forwardConversion, reverseConversion]);
  }

  String toString() {
    return 'SchemeBasedNameRelation {'
        'forwardConversion=${forwardConversion.toString()}\n'
        'reverseConversion=${reverseConversion.toString()}\n'
        '}';
  }
}

class _$SchemeBasedNameRelationBuilder extends SchemeBasedNameRelationBuilder {
  _$SchemeBasedNameRelationBuilder() : super._();
  void replace(SchemeBasedNameRelation other) {
    super.forwardConversion = other.forwardConversion;
    super.reverseConversion = other.reverseConversion;
  }

  void update(updates(SchemeBasedNameRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  SchemeBasedNameRelation build() {
    if (forwardConversion == null)
      throw new ArgumentError('null forwardConversion');
    if (reverseConversion == null)
      throw new ArgumentError('null reverseConversion');
    return new _$SchemeBasedNameRelation._(
        forwardConversion: forwardConversion,
        reverseConversion: reverseConversion);
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
