library transformer_meta;

import 'package:built_value/built_value.dart';

part 'transformer_meta.g.dart';

abstract class TransformationMetaModel
  implements Built<TransformationMetaModel, TransformationMetaModelBuilder> {

  TransformationMetaModel._();

  factory TransformationMetaModel([updates(TransformationMetaModelBuilder b)]) =
  _$TransformationMetaModel;
}

abstract class TransformationMetaModelBuilder
  implements Builder<TransformationMetaModel, TransformationMetaModelBuilder> {

  TransformationMetaModelBuilder._();

  factory TransformationMetaModelBuilder() = _$TransformationMetaModelBuilder;
}
