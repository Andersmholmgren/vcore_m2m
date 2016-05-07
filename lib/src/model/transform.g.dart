// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-05-07T07:09:26.692342Z

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
      'fromPath',
      serializers.serialize(object.fromPath,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'toPath',
      serializers.serialize(object.toPath,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
          case 'fromPath':
            result.fromPath.replace(serializers.deserialize(value,
                specifiedType:
                    const FullType(BuiltList, const [const FullType(String)])));
            break;
          case 'toPath':
            result.toPath.replace(serializers.deserialize(value,
                specifiedType:
                    const FullType(BuiltList, const [const FullType(String)])));
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
  final BuiltSet<ClassifierRelation> classifierRelations;
  _$PackageRelation._({this.from, this.to, this.classifierRelations})
      : super._() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
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
        classifierRelations == other.classifierRelations;
  }

  int get hashCode {
    return hashObjects([from, to, classifierRelations]);
  }

  String toString() {
    return 'PackageRelation {'
        'from=${from.toString()}\n'
        'to=${to.toString()}\n'
        'classifierRelations=${classifierRelations.toString()}\n'
        '}';
  }
}

class _$PackageRelationBuilder extends PackageRelationBuilder {
  _$PackageRelationBuilder() : super._();
  void replace(PackageRelation other) {
    super.from = other.from;
    super.to = other.to;
    super.classifierRelations = other.classifierRelations?.toBuilder();
  }

  void update(updates(PackageRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  PackageRelation build() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    if (classifierRelations == null)
      throw new ArgumentError('null classifierRelations');
    return new _$PackageRelation._(
        from: from, to: to, classifierRelations: classifierRelations?.build());
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
  final BuiltList<String> fromPath;
  final BuiltList<String> toPath;
  _$PropertyRelation._({this.fromPath, this.toPath}) : super._() {
    if (fromPath == null) throw new ArgumentError('null fromPath');
    if (toPath == null) throw new ArgumentError('null toPath');
  }
  factory _$PropertyRelation([updates(PropertyRelationBuilder b)]) =>
      (new PropertyRelationBuilder()..update(updates)).build();
  PropertyRelation rebuild(updates(PropertyRelationBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$PropertyRelationBuilder toBuilder() =>
      new _$PropertyRelationBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! PropertyRelation) return false;
    return fromPath == other.fromPath && toPath == other.toPath;
  }

  int get hashCode {
    return hashObjects([fromPath, toPath]);
  }

  String toString() {
    return 'PropertyRelation {'
        'fromPath=${fromPath.toString()}\n'
        'toPath=${toPath.toString()}\n'
        '}';
  }
}

class _$PropertyRelationBuilder extends PropertyRelationBuilder {
  _$PropertyRelationBuilder() : super._();
  void replace(PropertyRelation other) {
    super.fromPath = other.fromPath?.toBuilder();
    super.toPath = other.toPath?.toBuilder();
  }

  void update(updates(PropertyRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  PropertyRelation build() {
    if (fromPath == null) throw new ArgumentError('null fromPath');
    if (toPath == null) throw new ArgumentError('null toPath');
    return new _$PropertyRelation._(
        fromPath: fromPath?.build(), toPath: toPath?.build());
  }
}
