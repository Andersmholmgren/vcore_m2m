library transform;

import 'package:built_json/built_json.dart';
import 'package:built_value/built_value.dart';
import 'package:vcore/vcore.dart';

part 'transform.g.dart';

typedef Classifier Transform(Classifier);

abstract class ClassifierRelation<
    V extends Classifier<V, B>,
    B extends ClassifierBuilder<V, B>,
    V2 extends Classifier<V2, B2>,
    B2 extends ClassifierBuilder<V2, B2>> {
  V get from;
  V2 get to;
}

abstract class ClassifierRelationBuilder<
    V extends Classifier<V, B>,
    B extends ClassifierBuilder<V, B>,
    V2 extends Classifier<V2, B2>,
    B2 extends ClassifierBuilder<V2, B2>> {
  V from;
  V2 to;
}

abstract class ValueClassRelation
    implements
        Built<ValueClassRelation, ValueClassRelationBuilder>,
        ClassifierRelation<ValueClass, ValueClassBuilder, ValueClass,
            ValueClassBuilder> {
  static final Serializer<ValueClassRelation> serializer =
      _$valueClassRelationSerializer;

  ValueClass get from;
  ValueClass get to;

  ValueClassRelation._();

  factory ValueClassRelation([updates(ValueClassRelationBuilder b)]) =
      _$ValueClassRelation;
}

abstract class ValueClassRelationBuilder
    implements
        Builder<ValueClassRelation, ValueClassRelationBuilder>,
        ClassifierRelationBuilder<ValueClass, ValueClassBuilder, ValueClass,
            ValueClassBuilder> {
  ValueClassRelationBuilder._();

  ValueClass from;
  ValueClass to;

  factory ValueClassRelationBuilder() = _$ValueClassRelationBuilder;
}

// TODO: maybe rename a FeatureRelation
abstract class PropertyRelation
    implements Built<PropertyRelation, PropertyRelationBuilder> {
  static final Serializer<PropertyRelation> serializer =
      _$propertyRelationSerializer;

  FeatureQuery get from;
  FeatureQuery get to;

  PropertyRelation._();

  factory PropertyRelation([updates(PropertyRelationBuilder b)]) =
      _$PropertyRelation;
}

abstract class PropertyRelationBuilder
    implements Builder<PropertyRelation, PropertyRelationBuilder> {
  PropertyRelationBuilder._();

  FeatureQuery from;
  FeatureQuery to;

  factory PropertyRelationBuilder() = _$PropertyRelationBuilder;
}

abstract class FeatureQuery {}
