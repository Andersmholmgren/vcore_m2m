import 'package:vcore_m2m/src/model/relation.dart';
import 'package:vcore_m2m/src/model/transformer_meta.dart';
import 'package:vcore/vcore.dart';
import 'package:option/option.dart';

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
//      tb.propertyTransforms.
//    });
  });

  b.transformations.addAll(transformations);
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

  classRelation.propertyRelations.map((pr) {
    if (pr.to.property.isCollection != pr.from.property.isCollection) {
      throw new ArgumentError(
          'only support relationships between properties of the same arity');
    }


    final fromTypeName = singleTypeName(pr.from);
    final toTypeName = singleTypeName(pr.to);
    final converterRequired = fromTypeName != toTypeName;

    return new PropertyTransformBuilder()
      ..fromTypeName = fromTypeName
      ..toTypeName = toTypeName
      ..fromPathSegments = pr.to.path
      ..toPathSegments = pr.from.path
      ..hasCustomTransform = pr.transform != null
      ..transformName = new None<String>()
      ..isCollection = pr.to.property.isCollection
      ..requiresToBuilder = false;
  });
}
