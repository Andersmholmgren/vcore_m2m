import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/src/model/relation.dart';
import 'package:vcore_m2m/src/model/transformer_meta.dart';
import 'package:built_collection/built_collection.dart';

TransformationContextMetaModel transform(PackageRelation packageRelation) {
  final b = new TransformationContextMetaModelBuilder();
  final valueClassRelations = packageRelation.classifierRelations
      .where((cr) => cr is ValueClassRelation);

  final transformations = valueClassRelations.map((vr) {
    final classRelation = vr as ValueClassRelation;
    return new TransformationMetaModelBuilder()
      ..fromTypeName = classRelation.from.name
      ..toTypeName = classRelation.to.name
      ..propertyTransforms.addAll(createPropertyTransforms(classRelation));
  });

  b.transformations.addAll(transformations);

  BuiltSet<ValueClassRelation> subTypesOf(ValueClass from, ValueClass to) =>
      new BuiltSet<ValueClassRelation>(valueClassRelations.where(
          (classRelation) =>
              (classRelation as ValueClassRelation).isSubTypeOf(from, to)));

  transformations.map((t) {
    final abstractPropertyTransforms =
        t.propertyTransforms.build().where((pt) => pt.isAbstract);

    abstractPropertyTransforms.map((pt) {
      final b = new AbstractTypeMappingBuilder()
        ..fromTypeName = pt.fromSimpleType.name
        ..toTypeName = pt.toSimpleType.name;

      subTypesOf(
          pt.fromSimpleType as ValueClass, pt.toSimpleType as ValueClass);
    });
  });

//  b.abstractTypeMappings

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

  return classRelation.propertyRelations.map((pr) {
    if (pr.to.property.isCollection != pr.from.property.isCollection) {
      throw new ArgumentError(
          'only support relationships between properties of the same arity');
    }
    final fromSingleType = singleType(pr.from);
    final toSingleType = singleType(pr.to);
    final bool isAbstract =
        fromSingleType.isAbstract || toSingleType.isAbstract;

    return new PropertyTransformBuilder()
      ..fromSimpleType = singleType(pr.from)
      ..toSimpleType = singleType(pr.to)
      ..fromPathSegments = pr.to.path
      ..toPathSegments = pr.from.path
      ..hasCustomTransform = pr.transform != null
      ..isCollection = pr.to.property.isCollection
      ..requiresToBuilder = true
      ..isAbstract = isAbstract;
  });
}
