library transform;

import 'package:vcore/vcore.dart';
import 'package:built_value/built_value.dart';
import 'package:built_json/built_json.dart';

part 'transform.g.dart';

typedef Classifier Transform(Classifier);

abstract class ClassifierRelation
    implements Built<ClassifierRelation, ClassifierRelationBuilder> {
  static final Serializer<ClassifierRelation> serializer =
      _$classifierRelationSerializer;

  ClassifierRelation._();

  factory ClassifierRelation([updates(ClassifierRelationBuilder b)]) =
      _$ClassifierRelation;
}

abstract class ClassifierRelationBuilder
    implements Builder<ClassifierRelation, ClassifierRelationBuilder> {
  ClassifierRelationBuilder._();

  factory ClassifierRelationBuilder() = _$ClassifierRelationBuilder;
}
