String template(
        String lower(String s),
        String transformClass(
            String b(
                String className,
                String fromName,
                String toName,
                String transformField(String b(String f, String t)),
                String mapProperties()))) =>
    '''
import 'package:jason_schemer/src/models/schema.dart';
import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:built_collection/built_collection.dart';
import 'package:option/option.dart';
import 'package:logging/logging.dart';
import 'package:jason_schemer/src/m2m/schema_to_vcore.dart' as relations;

final _log = new Logger('schemaTovcoreRelation');

${transformClass((String className, String fromName, String toName,
      String transformField(String b(String f, String t)),
      String mapProperties()) =>
  '''
class $className extends AbstractTransformation<$fromName,
    ${fromName}Builder, $toName, ${toName}Builder> {
  ${transformField((f, t) => '''
  final Transform<$f, $t> ${lower(f)}To${t}Transform;
  ''')}
  $className($fromName from, TransformationContext context
  ${transformField((f, t) => '''
      , this.${lower(f)}To${t}Transform''')})
      : super(from, context, new ${toName}Builder());

  @override
  void mapProperties() {
    _log.finer(() => 'mapProperties for $fromName');

    ${mapProperties()}
//    toBuilder.name = uriToStringTransform(from.id);
//    if (from.definitions != null) {
//      from.definitions.forEach((e) {
//        toBuilder.classifiers.add(schemaToClassifierTransform(e)?.toBuilder());
//      });
//    }
  }
}
''')}


Option<Transform/*<F, T>*/ > lookupTransform/*<F, T>*/(
    Type fromType, Type toType) {
  return new _TransformationContext(relations.rootPackageRelation)
      .lookupTransform/*<F, T>*/(fromType, toType);
}

class _TransformationContext extends BaseTransformationContext {
  final PackageRelation packageRelation;

  _TransformationContext(this.packageRelation) {
    transformers = (new MapBuilder<TransformKey, TransformFactory>()
          ..[new TransformKey((b) => b
            ..from = Schema
            ..to = Package)] = _createSchemaToPackageTransform
          ..[new TransformKey((b) => b
            ..from = Schema
            ..to = ValueClass)] = _createSchemaToValueClassTransform
          ..[new TransformKey((b) => b
            ..from = SchemaProperty
            ..to = Property)] = _createSchemaPropertyToPropertyTransform)
        .build();
  }

  Transform<Schema, Package> _createSchemaToPackageTransform() {
    return (Schema schema) => new SchemaToPackageTransformation(schema, this,
            _createUriToStringTransform(), _createSchemaToClassifierTransform())
        .transform();
  }

  Transform<Schema, ValueClass> _createSchemaToValueClassTransform() {
    return (Schema schema) => new SchemaToValueClassTransformation(
            schema,
            this,
            _createUriToStringTransform(),
            _createSchemaPropertyToPropertyTransform())
        .transform();
  }

  Transform<SchemaProperty, Property>
      _createSchemaPropertyToPropertyTransform() {
    return (SchemaProperty schemaProperty) =>
        new SchemaPropertyToPropertyTransformation(schemaProperty, this,
                _createSchemaReferenceToClassifierTransform())
            .transform();
  }

  Transform<Schema, Classifier> _createSchemaToClassifierTransform() {
    final schemaToValueClassTransformation =
        _createSchemaToValueClassTransform();

    return (Schema schema) {
      if (schema is Schema) {
        return schemaToValueClassTransformation(schema as Schema);
      } else {
        throw new StateError(
            "No transform from %{ schema.runtimeType} to Classifier");
      }
    };
  }

  Transform<SchemaReference, Classifier>
      _createSchemaReferenceToClassifierTransform() {
    final schemaToValueClassTransformation =
        _createSchemaToValueClassTransform();

    return (SchemaReference schemaReference) {
      if (schemaReference is Schema) {
        return schemaToValueClassTransformation(schemaReference as Schema);
      } else {
        throw new StateError(
            "No transform from %{schemaReference.runtimeType} to Classifier");
      }
    };
  }

  Transform<Uri, String> _createUriToStringTransform() {
    // TODO: should cache these lookups
    final classRelation = packageRelation.classifierRelations.firstWhere(
            (cr) => cr.from.name == 'Schema' && cr.to.name == 'Package')
        as ValueClassRelation;

    final propertyRelation = classRelation.propertyRelations.firstWhere((pr) =>
        pr.from.path == new BuiltList<String>(['id']) &&
        pr.to.path == new BuiltList<String>(['name']));

    return propertyRelation.transform.forwards as Transform<Uri, String>;
  }

  Transform<Uri, String> _createUriToStringTransform() {
    // TODO: should cache these lookups
    final classRelation = packageRelation.classifierRelations.firstWhere(
            (cr) => cr.from.name == 'Schema' && cr.to.name == 'ValueClass')
        as ValueClassRelation;

    final propertyRelation = classRelation.propertyRelations.firstWhere((pr) =>
        pr.from.path == new BuiltList<String>(['id']) &&
        pr.to.path == new BuiltList<String>(['name']));

    return propertyRelation.transform.forwards as Transform<Uri, String>;
  }
}

''';
