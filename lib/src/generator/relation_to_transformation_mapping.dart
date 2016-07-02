import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/src/model/relation.dart';
import 'package:vcore_m2m/src/model/transformer_meta.dart';

TransformationContextMetaModel transform(PackageRelation packageRelation) {
  final b = new TransformationContextMetaModelBuilder();
  final valueClassRelations = packageRelation.classifierRelations
      .where((cr) => cr is ValueClassRelation);

  final transformations = valueClassRelations.map((vr) {
    final classRelation = vr as ValueClassRelation;
    final tb =  new TransformationMetaModelBuilder()
      ..fromTypeName = classRelation.from.name
      ..toTypeName = classRelation.to.name
      ..propertyTransforms.addAll(createPropertyTransforms(classRelation));

    tb.propertyTransforms.
//      tb.propertyTransforms.
//    });
  });

  b.transformations.addAll(transformations);

  return b.build();
}

Iterable<PropertyTransformBuilder> createPropertyTransforms(
    ValueClassRelation classRelation) {
  Classifier singleType(PropertyRelationEnd end) {
    final p = end.property;
    if (p.isCollection) {
      final gt = p.type as GenericType;
      return gt.genericTypeValues.values.first;
    }
    return p.type;
  }

  String singleTypeName(PropertyRelationEnd end) => singleType(end).name;

  return classRelation.propertyRelations.map((pr) {
    if (pr.to.property.isCollection != pr.from.property.isCollection) {
      throw new ArgumentError(
          'only support relationships between properties of the same arity');
    }

    return new PropertyTransformBuilder()
      ..fromTypeName = singleTypeName(pr.from)
      ..toTypeName = singleTypeName(pr.to)
      ..fromPathSegments = pr.to.path
      ..toPathSegments = pr.from.path
      ..hasCustomTransform = pr.transform != null
      ..isCollection = pr.to.property.isCollection
      ..requiresToBuilder = true;
  });
}
