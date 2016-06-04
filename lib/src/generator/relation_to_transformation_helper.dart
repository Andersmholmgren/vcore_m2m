import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:vcore/vcore.dart';
import 'package:option/option.dart';

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

    String maybeConvertedValue(String valueVariable) {
      final descOpt = _getTransformDescriptor(propertyRelation);

      return descOpt
          .map((d) => '${d.variableName}($valueVariable)')
          .getOrElse(() => valueVariable);
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

  Option<_TransformDescriptor> _getTransformDescriptor(PropertyRelation pr) {
    final to = pr.to;
    final from = pr.from;
    final converterRequired = to.property.type != from.property.type;
    if (!converterRequired) return const None();

    String simpleTypeName(Property p) {
//        print('simpleTypeName type: ${p.type.runtimeType} ${p.type.name} => ismulti: ${p.isMultiValued}');
//        if (p.isMultiValued) { // not sure what to do with maps
      if (p.isCollection) {
        final gt = p.type as GenericType;
        return gt.genericTypeValues.values.first.name;
      }
      return p.type.name;
    }

    final fromName = simpleTypeName(from.property);
    final toName = simpleTypeName(to.property);

    final variableName = '${_uncapitalise(fromName)}To'
        '${toName}Transform';

    final typeString = 'Transform<$fromName, $toName>';

    return new Some<_TransformDescriptor>(
        new _TransformDescriptor(typeString, variableName));
  }
}

class _TransformDescriptor {
  final String typeString, variableName;

  _TransformDescriptor(this.typeString, this.variableName);
}

// TODO: these should be in a util
String _capitalise(String s) =>
    s.substring(0, 1).toUpperCase() + s.substring(1);

String _uncapitalise(String s) =>
    s.substring(0, 1).toLowerCase() + s.substring(1);
