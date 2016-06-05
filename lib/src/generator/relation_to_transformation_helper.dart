import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:vcore/vcore.dart';
import 'package:option/option.dart';
import 'package:built_collection/built_collection.dart';

class RelationToTransformationHelper {
  final PackageRelation packageRelation;
  final StringSink sink;

  RelationToTransformationHelper(this.packageRelation, this.sink);

  void generate() {
    final helpers = packageRelation.classifierRelations
        .where((cr) => cr is ValueClassRelation)
        .map((vr) => new _ValueClassRelationHelper(vr));

    helpers.forEach(_generateClassifiers);
    _generateTransformationContext();
  }

  void _generateClassifiers(_ValueClassRelationHelper helper) {
    final transformerParamExtra =
        helper.hasDependencies ? ', ${helper.transformerParams}' : '';

    sink.writeln('''
class ${helper.className} extends AbstractTransformation<${helper.fromName},
    ${helper.fromName}Builder, ${helper.toName}, ${helper.toName}Builder> {
  ${helper.transformerFields}

  ${helper.className}(${helper.fromName} from, TransformationContext context
  $transformerParamExtra
      )
      : super(from, new ${helper.toName}Builder(), context);

  @override
  void mapProperties() {
  ''');
    _generateProperties(helper);
    sink.writeln('''
  }
}
''');
  }

  void _generateProperties(_ValueClassRelationHelper helper) {
    helper.classRelation.propertyRelations
        .forEach((p) => _generateProperty(p, helper));
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

  void _generateProperty(
      PropertyRelation propertyRelation, _ValueClassRelationHelper helper) {
    final to = propertyRelation.to;
    final from = propertyRelation.from;
    final toPathExpression = 'toBuilder.${to.path.join('.')}';
    final fromPathExpression = 'from.${from.path.join('?.')}';

    String maybeConvertedValue(String valueVariable) {
      final descOpt = helper.getTransformDescriptor(propertyRelation);

      String toBuilderClause(_TransformDescriptor d) =>
          d.isBuilder ? '?.toBuilder()' : '';

      return descOpt
          .map((d) => '${d.variableName}($valueVariable)${toBuilderClause(d)}')
          .getOrElse(() => valueVariable);
    }

    if (to.property.isCollection != from.property.isCollection) {
      throw new ArgumentError(
          'only support relationships between properties of the same arity');
    }
    if (from.property.isCollection) {
      sink.writeln('''
    if ($fromPathExpression != null) {
      $fromPathExpression.forEach((e) {
        $toPathExpression.add(${maybeConvertedValue('e')});
      });
    }
      ''');
    } else {
      sink.writeln('$toPathExpression = '
          '${maybeConvertedValue(fromPathExpression)};');
    }
  }

  void _generateTransformationContext() {
    sink.writeln('''
Option<Transform/*<F, T>*/ > lookupTransform/*<F, T>*/(
    Type fromType, Type toType) {
  return new _TransformationContext()
      .lookupTransform/*<F, T>*/(fromType, toType);
}

class _TransformationContext extends BaseTransformationContext {
  _TransformationContext() {
    transformers = (new MapBuilder<TransformKey, TransformFactory>()
    ''');

    packageRelation.classifierRelations.forEach((cr) {
      final helper = new _ValueClassRelationHelper(cr as ValueClassRelation);
      sink.writeln('''
      ..[new TransformKey((b) => b
        ..from = ${helper.fromName}
        ..to = ${helper.toName})] = ${helper.createTransformName}
    ''');
    });

    sink.writeln(''')
    .build();
  }
    ''');

    packageRelation.classifierRelations.forEach((cr) {
      final fromName = cr.from.name;
      final toName = cr.to.name;
      sink.writeln('''
    Transform<$fromName, $toName> _create${fromName}To${toName}Transform() {
      return ($fromName ${_uncapitalise(fromName)}) => new ${fromName}To${toName}Transformation(
        ${_uncapitalise(fromName)}, this
//        , _createSchemaToValueClassTransform()
        )
        .transform();
    }
    ''');
    });

    sink.writeln('''
}
    ''');
  }

/*
class _TransformationContext extends BaseTransformationContext {
  _TransformationContext() {
    transformers = (new MapBuilder<TransformKey, TransformFactory>()
          ..[new TransformKey((b) => b
            ..from = Schema
            ..to = Package)] = _createSchemaToPackageTransform
          ..[new TransformKey((b) => b
            ..from = Schema
            ..to = ValueClass)] = _createSchemaToValueClassTransform
          ..[new TransformKey((b) => b
            ..from = SchemaProperty
            ..to = Property)] = _createSchemaPropertyToPropertyTransformation)
        .build();
  }

  Transform<Schema, Package> _createSchemaToPackageTransform() {
    return (Schema schema) => new SchemaToPackageTransformation(
            schema, this, _createSchemaToValueClassTransform())
        .transform();
  }

  Transform<Schema, ValueClass> _createSchemaToValueClassTransform() {
    return (Schema schema) => new SchemaToValueClassTransformation(
            schema, this, _createSchemaPropertyToPropertyTransformation())
        .transform();
  }

  Transform<SchemaProperty, Property>
      _createSchemaPropertyToPropertyTransformation() {
    return (SchemaProperty schemaProperty) =>
        new SchemaPropertyToPropertyTransformation(schemaProperty, this)
            .transform();
  }
}
     */
}

class _ValueClassRelationHelper {
  final ValueClassRelation classRelation;
  final BuiltMap<PropertyRelation, _TransformDescriptor> descriptors;

  bool get hasDependencies => descriptors.isNotEmpty;

  String get fromName => classRelation.from.name;
  String get toName => classRelation.to.name;
  String get className => '${fromName}To${toName}Transformation';
  String get createTransformName => '_create${fromName}To${toName}Transform';

  String get transformerFields => descriptors.values
      .map((d) => 'final ${d.typeString} ${d.variableName};')
      .join('\n');

  String get transformerParams =>
      descriptors.values.map((d) => 'this.${d.variableName}').join(', ');

  _ValueClassRelationHelper._(this.classRelation, this.descriptors);

  _ValueClassRelationHelper(ValueClassRelation classRelation)
      : this._(classRelation,
            new BuiltMap<PropertyRelation, _TransformDescriptor>.build(
                (MapBuilder b) {
          classRelation.propertyRelations.forEach((pr) {
            final desc = _getTransformDescriptor(pr);
            if (desc is Some) {
              b[pr] = desc.get();
            }
          });
        }));

  Option<_TransformDescriptor> getTransformDescriptor(PropertyRelation pr) =>
      new Option<_TransformDescriptor>(descriptors[pr]);

  static Option<_TransformDescriptor> _getTransformDescriptor(
      PropertyRelation pr) {
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

    bool isBuilder(Property p) {
      if (p.isCollection) {
        final gt = p.type as GenericType;
        return gt.genericTypeValues.values.first is ValueClass;
      }
      return p.type is ValueClass;
    }

    final fromName = simpleTypeName(from.property);
    final toName = simpleTypeName(to.property);

    final variableName = '${_uncapitalise(fromName)}To'
        '${toName}Transform';

    final typeString = 'Transform<$fromName, $toName>';

    return new Some<_TransformDescriptor>(new _TransformDescriptor(
        typeString, variableName, isBuilder(to.property)));
  }
}

class _TransformDescriptor {
  final String typeString, variableName;
  final bool isBuilder;

  _TransformDescriptor(this.typeString, this.variableName, this.isBuilder);
}

// TODO: these should be in a util
String _capitalise(String s) =>
    s.substring(0, 1).toUpperCase() + s.substring(1);

String _uncapitalise(String s) =>
    s.substring(0, 1).toLowerCase() + s.substring(1);
