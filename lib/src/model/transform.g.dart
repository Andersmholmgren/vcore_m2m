// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-04-30T04:30:19.171128Z

part of transform;

// **************************************************************************
// Generator: BuiltJsonGenerator
// Target: library transform
// **************************************************************************

Serializer<ClassifierRelation> _$classifierRelationSerializer =
    new _$ClassifierRelationSerializer();

class _$ClassifierRelationSerializer
    implements StructuredSerializer<ClassifierRelation> {
  final Iterable<Type> types =
      new BuiltList<Type>([ClassifierRelation, _$ClassifierRelation]);
  final String wireName = 'ClassifierRelation';

  @override
  Iterable serialize(Serializers serializers, ClassifierRelation object,
      {FullType specifiedType: FullType.unspecified}) {
    return [];
  }

  @override
  ClassifierRelation deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new ClassifierRelationBuilder();

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
        }
      }
    }

    return result.build();
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class ClassifierRelation
// **************************************************************************

class _$ClassifierRelation extends ClassifierRelation {
  _$ClassifierRelation._() : super._() {}
  factory _$ClassifierRelation([updates(ClassifierRelationBuilder b)]) =>
      (new ClassifierRelationBuilder()..update(updates)).build();
  ClassifierRelation rebuild(updates(ClassifierRelationBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$ClassifierRelationBuilder toBuilder() =>
      new _$ClassifierRelationBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! ClassifierRelation) return false;
    return true;
  }

  int get hashCode {
    return 230051829;
  }

  String toString() {
    return 'ClassifierRelation {}';
  }
}

class _$ClassifierRelationBuilder extends ClassifierRelationBuilder {
  _$ClassifierRelationBuilder() : super._();
  void replace(ClassifierRelation other) {}
  void update(updates(ClassifierRelationBuilder b)) {
    if (updates != null) updates(this);
  }

  ClassifierRelation build() {
    return new _$ClassifierRelation._();
  }
}
