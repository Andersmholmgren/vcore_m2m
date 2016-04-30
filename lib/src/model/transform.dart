library transform;

import 'package:vcore/vcore.dart';
import 'package:built_value/built_value.dart';
import 'package:built_json/built_json.dart';

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
  B from;
  B2 to;
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

  ValueClassBuilder from = new ValueClassBuilder();
  ValueClassBuilder to = new ValueClassBuilder();

  factory ValueClassRelationBuilder() = _$ValueClassRelationBuilder;
}
