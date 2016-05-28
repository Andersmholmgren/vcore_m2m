import 'package:vcore_m2m/vcore_m2m.dart';

class RelationToTransformationHelper {
  final PackageRelation packageRelation;
  final StringSink sink;

  RelationToTransformationHelper(this.packageRelation, this.sink);

  void generate() {
    packageRelation.classifierRelations.forEach(_generateClassifiers);

/*
'''
class SchemaToPackageTransformation extends AbstractTransformation<Schema,
    SchemaBuilder, Package, PackageBuilder> {
  final Transform<Schema, ValueClass> schemaToValueClassTransform;

  SchemaToPackageTransformation(Schema from, TransformationContext context,
      this.schemaToValueClassTransform)
      : super(from, new PackageBuilder(), context);

  @override
  void mapProperties() {
    toBuilder.name = from?.id?.toString(); // TODO: name to id transform

//    b.relate((f) => f.definitions).to((t) => t.classifiers);
    if (from.definitions != null) {
      from.definitions.forEach((d) {
        final classifier = schemaToValueClassTransform(d);
        toBuilder.classifiers.add(classifier);
      });
    }

//    b.relate((f) => f).to((t) => t.classifiers);
    toBuilder.classifiers.add(schemaToValueClassTransform(from));
  }
}
'''

     */
  }

  void _generateClassifiers(ValueClassRelation relation) {
    final fromName = relation.from.name;
    final toName = relation.to.name;
    final className = '${fromName}To${toName}Transformation';

    sink.writeln('''
class $className extends AbstractTransformation<$fromName,
    ${fromName}Builder, $toName, ${toName}Builder> {
//  final Transform<Schema, ValueClass> schemaToValueClassTransform;

  $className($fromName from, TransformationContext context
//  ,
//      this.schemaToValueClassTransform
      )
      : super(from, new ${toName}Builder(), context);

  @override
  void mapProperties() {
  ''');
    _generateProperties(relation);
    sink.writeln('''
  }
}
''');
  }

  void _generateProperties(ValueClassRelation relation) {
    relation.propertyRelations.forEach(_generateProperty);
/*
    toBuilder.name = from?.id?.toString(); // TODO: name to id transform

//    b.relate((f) => f.definitions).to((t) => t.classifiers);
    if (from.definitions != null) {
      from.definitions.forEach((d) {
        final classifier = schemaToValueClassTransform(d);
        toBuilder.classifiers.add(classifier);
      });
    }

//    b.relate((f) => f).to((t) => t.classifiers);
    toBuilder.classifiers.add(schemaToValueClassTransform(from));

*/
  }

  void _generateProperty(PropertyRelation propertyRelation) {
    // TODO: damn need to know types at both ends of the relation here
    // Do we reflect here or when we create the relation and store it on the relation?
//    propertyRelation.

    final to = propertyRelation.to;
    final from = propertyRelation.from;
    final toPathExpression = 'toBuilder.${to.path.join('.')}';
    final fromPathExpression = 'from.${from.path.join('?.')}';
    final converterRequired = to.property.type != from.property.type;
    String maybeConvertedValue(String valueVariable) {
      return converterRequired
          ? '${from.property.type.name}To${to.property.type.name}Transform($valueVariable)'
          : valueVariable;
    }

    if (to.property.isCollection != from.property.isCollection) {
      throw new ArgumentError(
          'only support relationships between properties of the same arity');
    }
    if (from.property.isCollection) {
      sink.writeln('''
    if ($fromPathExpression != null) {
      $fromPathExpression.forEach((d) {
        $toPathExpression.add(${maybeConvertedValue('d')});
      });
    }
      ''');
    } else {
      sink.writeln('$toPathExpression = '
          '${maybeConvertedValue(fromPathExpression)};');
    }
  }
}