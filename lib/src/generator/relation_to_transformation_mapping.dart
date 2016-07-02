import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/src/model/relation.dart';
import 'package:vcore_m2m/src/model/transformer_meta.dart';

PackageTransformationMetaModel transform(PackageRelation packageRelation,
    Uri packageRelationPackageUri, Uri sourceModelPackageUri) {
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

  Iterable<ValueClassRelation> subTypesOf(ValueClass from, ValueClass to) =>
      valueClassRelations.where((classRelation) =>
          (classRelation as ValueClassRelation).isSubTypeOf(from, to));

  Iterable<TransformMetaModelBuilder> subTransforms(
          Classifier from, Classifier to) =>
      from is ValueClass && to is ValueClass
          ? subTypesOf(from as ValueClass, to as ValueClass).map((vr) {
              return new TransformMetaModelBuilder()
                ..fromName = vr.from.name
                ..toName = vr.to.name;
            })
          : [];

  final abstractTypeMappings =
      transformations.expand/*<AbstractTypeMappingBuilder>*/((t) {
    final abstractPropertyTransforms =
        t.propertyTransforms.build().where((pt) => pt.isAbstract);

    return abstractPropertyTransforms.map((pt) {
      return new AbstractTypeMappingBuilder()
        ..fromTypeName = pt.fromSimpleType.name
        ..toTypeName = pt.toSimpleType.name
        ..subTypeMappings
            .addAll(subTransforms(pt.fromSimpleType, pt.toSimpleType));
    });
  });

  b.abstractTypeMappings.addAll(abstractTypeMappings);

  return new PackageTransformationMetaModel((pb) {
    pb.context = b;
    pb.fromPackageName = packageRelation.from.name;
    pb.toPackageName = packageRelation.to.name;
    pb.sourceModelPackageUri = sourceModelPackageUri;
    pb.packageRelationPackageUri = packageRelationPackageUri;
  });
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
