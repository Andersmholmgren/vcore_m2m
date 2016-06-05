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
      final helper = new _ValueClassRelationHelper(cr as ValueClassRelation);
      final fromName = helper.fromName;
      final toName = helper.toName;
      final constructorParamExtra =
          helper.hasDependencies ? ', ${helper.constructorParams}' : '';
      sink.writeln('''
    Transform<$fromName, $toName> ${helper.createTransformName}() {
      return ($fromName ${_uncapitalise(fromName)}) => new ${helper.className}(
        ${_uncapitalise(fromName)}, this
        $constructorParamExtra)
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

class _PackageRelationHelper {
  final PackageRelation packageRelation;
  final BuiltMap<ValueClassRelation, _ValueClassRelationHelper> valueClasses;

  Iterable<PropertyRelation> get abstractPropertyRelations =>
      valueClasses.keys.expand((cr) =>
          cr.propertyRelations.where((pr) => pr.to.property.type.isAbstract));

  Map<Classifier, Classifier> get requiredTransforms =>
      _typeMapFor(valueClasses.keys.expand((cr) => cr.propertyRelations));

  Map<Classifier, Classifier> get requiredAbstractTransforms =>
      _typeMapFor(abstractPropertyRelations);

  Map<Classifier, Classifier> get providedTransforms {
    return new Map<Classifier, Classifier>.fromIterable(
        packageRelation.classifierRelations,
        key: (ClassifierRelation cr) => cr.from,
        value: (ClassifierRelation cr) => cr.to);
  }

  _PackageRelationHelper._(this.packageRelation, this.valueClasses);

  _PackageRelationHelper(PackageRelation packageRelation)
      : this._(packageRelation,
            new BuiltMap<ValueClassRelation, _ValueClassRelationHelper>.build(
                (MapBuilder b) {
          packageRelation.classifierRelations.forEach((cr) {
            if (cr is ValueClassRelation) {
              b[cr] = new _ValueClassRelationHelper(cr as ValueClassRelation);
            }
          });
        }));

  Map<Classifier, Classifier> _typeMapFor(Iterable<PropertyRelation> prs) {
    return new Map<Classifier, Classifier>.fromIterable(prs,
        key: (PropertyRelation pr) => pr.from.property.type,
        value: (PropertyRelation pr) => pr.to.property.type);
  }
}

class _ValueClassRelationHelper {
  final ValueClassRelation classRelation;
  final BuiltMap<PropertyRelation, _PropertyRelationHelper> properties;
  Iterable<_TransformDescriptor> get descriptors =>
      properties.values.expand((h) => h.transformDescriptor);

  bool get hasDependencies => descriptors.isNotEmpty;

  String get fromName => classRelation.from.name;
  String get toName => classRelation.to.name;
  String get className => '${fromName}To${toName}Transformation';
  String get createTransformName => '_create${fromName}To${toName}Transform';

  String get transformerFields => descriptors
      .map((d) => 'final ${d.typeString} ${d.variableName};')
      .join('\n');

  String get transformerParams =>
      descriptors.map((d) => 'this.${d.variableName}').join(', ');

  String get constructorParams => descriptors
      .map((d) => '_create${_capitalise(d.variableName)}()')
      .join(', ');

  _ValueClassRelationHelper._(this.classRelation, this.properties);

  _ValueClassRelationHelper(ValueClassRelation classRelation)
      : this._(classRelation,
            new BuiltMap<PropertyRelation, _PropertyRelationHelper>.build(
                (MapBuilder b) {
          classRelation.propertyRelations.forEach((pr) {
            b[pr] = new _PropertyRelationHelper(pr);
          });
        }));

  Option<_TransformDescriptor> getTransformDescriptor(PropertyRelation pr) =>
      new Option<_PropertyRelationHelper>(properties[pr])
          .expand((_PropertyRelationHelper h) => h.transformDescriptor)
      as Option<_TransformDescriptor>;
}

class _PropertyRelationHelper {
  final PropertyRelation propertyRelation;
  final _PropertyRelationEndHelper from;
  final _PropertyRelationEndHelper to;

  String get fromName => from.simpleTypeName;
  String get toName => to.simpleTypeName;
  bool get converterRequired => to.end.property.type != from.end.property.type;

  Option<_TransformDescriptor> _transformDescriptor;

  Option<_TransformDescriptor> get transformDescriptor =>
      _transformDescriptor ??= _createTransformDescriptor();

  Option<_TransformDescriptor> _createTransformDescriptor() {
    if (!converterRequired) return const None();

    final variableName = '${_uncapitalise(fromName)}To'
        '${toName}Transform';

    final typeString = 'Transform<$fromName, $toName>';

    return new Some<_TransformDescriptor>(
        new _TransformDescriptor(typeString, variableName, to.isBuilder));
  }

  _PropertyRelationHelper._(this.propertyRelation, this.from, this.to);
  _PropertyRelationHelper(PropertyRelation propertyRelation)
      : this._(
            propertyRelation,
            new _PropertyRelationEndHelper(propertyRelation.from),
            new _PropertyRelationEndHelper(propertyRelation.to));
}

class _PropertyRelationEndHelper {
  final PropertyRelationEnd end;

  _PropertyRelationEndHelper(this.end);

  String get simpleTypeName {
    final p = end.property;
    if (p.isCollection) {
      final gt = p.type as GenericType;
      return gt.genericTypeValues.values.first.name;
    }
    return p.type.name;
  }

  bool get isBuilder {
    final p = end.property;
    if (p.isCollection) {
      final gt = p.type as GenericType;
      return gt.genericTypeValues.values.first is ValueClass;
    }
    return p.type is ValueClass;
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
