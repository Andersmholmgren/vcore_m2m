library transform;

import 'package:built_json/built_json.dart';
import 'package:built_value/built_value.dart';
import 'package:vcore/vcore.dart';
import 'package:built_collection/built_collection.dart';

part 'transform.g.dart';

abstract class PackageRelation
    implements Built<PackageRelation, PackageRelationBuilder> {
  static final Serializer<PackageRelation> serializer =
      _$packageRelationSerializer;

  BuiltSet<ClassifierRelation> get classifierRelations;

  PackageRelation._();

  factory PackageRelation([updates(PackageRelationBuilder b)]) =
      _$PackageRelation;
}

abstract class PackageRelationBuilder
    implements Builder<PackageRelation, PackageRelationBuilder> {
  PackageRelationBuilder._();

  SetBuilder<ClassifierRelation> classifierRelations =
      new SetBuilder<ClassifierRelation>();

  factory PackageRelationBuilder() = _$PackageRelationBuilder;
}

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
  BuiltSet<PropertyRelation> get propertyRelations;

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
  SetBuilder<PropertyRelation> propertyRelations =
      new SetBuilder<PropertyRelation>();

  factory ValueClassRelationBuilder() = _$ValueClassRelationBuilder;
}

// TODO: maybe rename a FeatureRelation
abstract class PropertyRelation
    implements Built<PropertyRelation, PropertyRelationBuilder> {
  static final Serializer<PropertyRelation> serializer =
      _$propertyRelationSerializer;

  BuiltList<String> get fromPath;
  BuiltList<String> get toPath;

  PropertyRelation._();

  factory PropertyRelation([updates(PropertyRelationBuilder b)]) =
      _$PropertyRelation;
}

abstract class PropertyRelationBuilder
    implements Builder<PropertyRelation, PropertyRelationBuilder> {
  PropertyRelationBuilder._();

  ListBuilder<String> fromPath = new ListBuilder<String>();
  ListBuilder<String> toPath = new ListBuilder<String>();

  factory PropertyRelationBuilder() = _$PropertyRelationBuilder;
}
