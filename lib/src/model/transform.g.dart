// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-05-07T02:59:35.397385Z

part of transform;

// **************************************************************************
// Generator: BuiltJsonGenerator
// Target: library transform
// **************************************************************************

Serializer<ValueClassRelation> _$valueClassRelationSerializer =
    new _$ValueClassRelationSerializer();
Serializer<PropertyRelation> _$propertyRelationSerializer =
    new _$PropertyRelationSerializer();

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
          specifiedType: const FullType(FeatureQuery)),
      'to',
      serializers.serialize(object.to,
          specifiedType: const FullType(FeatureQuery)),
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
            result.from = serializers.deserialize(value,
                specifiedType: const FullType(FeatureQuery));
            break;
          case 'to':
            result.to = serializers.deserialize(value,
                specifiedType: const FullType(FeatureQuery));
            break;
        }
      }
    }

    return result.build();
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class ValueClassRelation
// **************************************************************************

class _$ValueClassRelation extends ValueClassRelation {
  final ValueClass from;
  final ValueClass to;
  _$ValueClassRelation._({this.from, this.to}) : super._() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
  }
  factory _$ValueClassRelation([updates(ValueClassRelationBuilder b)]) =>
      (new ValueClassRelationBuilder()..update(updates)).build();
  ValueClassRelation rebuild(updates(ValueClassRelationBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$ValueClassRelationBuilder toBuilder() =>
      new _$ValueClassRelationBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! ValueClassRelation) return false;
    return from == other.from && to == other.to;
  }

  int get hashCode {
    return hashObjects([from, to]);
  }

  String toString() {
    return 'ValueClassRelation {'
        'from=${from.toString()}\n'
        'to=${to.toString()}\n'
        '}';
  }
}

class _$ValueClassRelationBuilder extends ValueClassRelationBuilder {
  _$ValueClassRelationBuilder() : super._();
  void replace(ValueClassRelation other) {
    super.from = other.from;
    super.to = other.to;
  }

  void update(updates(ValueClassRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  ValueClassRelation build() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    return new _$ValueClassRelation._(from: from, to: to);
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class PropertyRelation
// **************************************************************************

class _$PropertyRelation extends PropertyRelation {
  final FeatureQuery from;
  final FeatureQuery to;
  _$PropertyRelation._({this.from, this.to}) : super._() {
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
    return from == other.from && to == other.to;
  }

  int get hashCode {
    return hashObjects([from, to]);
  }

  String toString() {
    return 'PropertyRelation {'
        'from=${from.toString()}\n'
        'to=${to.toString()}\n'
        '}';
  }
}

class _$PropertyRelationBuilder extends PropertyRelationBuilder {
  _$PropertyRelationBuilder() : super._();
  void replace(PropertyRelation other) {
    super.from = other.from;
    super.to = other.to;
  }

  void update(updates(PropertyRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  PropertyRelation build() {
    if (from == null) throw new ArgumentError('null from');
    if (to == null) throw new ArgumentError('null to');
    return new _$PropertyRelation._(from: from, to: to);
  }
}
