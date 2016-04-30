library transform;

import 'package:vcore/vcore.dart';
import 'package:built_value/built_value.dart';
import 'package:built_json/built_json.dart';

part 'transform.g.dart';

typedef Classifier Transform(Classifier);


abstract class Relation
  implements Built<Relation, RelationBuilder> {
  static final Serializer<Relation> serializer = _$relationSerializer;


  Relation._();

  factory Relation([updates(RelationBuilder b)]) = _$Relation;
}

abstract class RelationBuilder
  implements Builder<Relation, RelationBuilder> {

  RelationBuilder._();

  factory RelationBuilder() = _$RelationBuilder;
}
