import 'package:built_collection/built_collection.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:logging/logging.dart';
import 'package:option/option.dart';
import 'package:quiver/core.dart';
import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/vcore_m2m.dart';

import 'template.dart';

final _log = new Logger('vcore.m2m.relation.transformation');

class RelationToTransformationHelper {
  final PackageRelation packageRelation;
  final StringSink sink;
  final _PackageRelationHelper packageRelationHelper;
  final Uri packageRelationPackageUri;
  final Uri sourceModelPackageUri;

  RelationToTransformationHelper._(
      this.packageRelation,
      this.packageRelationPackageUri,
      this.sourceModelPackageUri,
      this.sink,
      this.packageRelationHelper);

  RelationToTransformationHelper(PackageRelation packageRelation,
      Uri packageRelationPackageUri, Uri sourceModelPackageUri, StringSink sink)
      : this._(
            packageRelation,
            packageRelationPackageUri,
            sourceModelPackageUri,
            sink,
            new _PackageRelationHelper(packageRelation));

  void generate() {
    _log.info(() => 'generating transformer for ${packageRelationHelper.name}');

    /**
     * Another approach is to create models for each part of this
     * - TransformationClasses
     * - context
     *   - transformKeys
     *   - factory methods (3 sorts)
     *
     * - then have a more direct serialisation of these
     */

    String perClassRelation(
        String b(String className, String fromName, String toName,
            [String transformField(String b(String f, String t)),
            String mapProperties()])) {
      return packageRelationHelper.valueClasses.values.map((h) {
        String transformField(String b(String f, String t)) =>
            h.convertingProperties
                .map((f) => b(f.fromName, f.toName))
                .join('\n');

        String mapProperties() => _generateProperties(h);

        return b(
            h.className, h.fromName, h.toName, transformField, mapProperties);
      }).join('\n');
    }

    String perRequiredAbstractToConcreteTransform(
        String b(String fromName, String toName,
            String perAvailableTransform(String b(String f, String t)))) {
      final StringBuffer buffer = new StringBuffer();

      packageRelationHelper.requiredAbstractTransforms.forEach((from, to) {
        final fromName = from.name;
        final toName = to.name;
        print('requiredAbstractTransforms: $fromName -> $toName');

        if (from is ValueClass && to is ValueClass) {
          String perSubTypeTransform(String b(String f, String t)) {
            return packageRelationHelper
                .subTypesOf(from, to)
                .map((h) => b(h.fromName, h.toName))
                .join('\n');
          }

          buffer.writeln(b(fromName, toName, perSubTypeTransform));
        }
      });

      return buffer.toString();
    }

    String perCustomTransform(
        String b(String fromName, String toName, String fromPathSegments,
            String toPathSegments)) {
      final propertyHelpers = packageRelationHelper.valueClasses.values
          .expand((h) => h.properties.values)
          .toSet();
      return propertyHelpers.map((ph) {
        return ph.hasCustomTransform
            ? b(ph.fromName, ph.toName, ph.fromPathExpression,
                ph.toPathExpression)
            : "";
      }).join('\n');
    }

    sink.writeln(template(
        sourceModelPackageUri.toString(),
        packageRelationPackageUri.toString(),
        packageRelationHelper.fromName,
        packageRelationHelper.toName,
        perClassRelation,
        perRequiredAbstractToConcreteTransform,
        perCustomTransform));
  }

  String _generateProperties(_ValueClassRelationHelper helper) {
    return helper.classRelation.propertyRelations
        .map((p) => _generateProperty(p, helper))
        .join('\n');
  }

  String _generateProperty(
      PropertyRelation propertyRelation, _ValueClassRelationHelper helper) {
    final StringBuffer buffer = new StringBuffer();
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
      buffer.writeln('''
    if ($fromPathExpression != null) {
      $fromPathExpression.forEach((e) {
        $toPathExpression.add(${maybeConvertedValue('e')});
      });
    }
      ''');
    } else {
      buffer.writeln('$toPathExpression = '
          '${maybeConvertedValue(fromPathExpression)};');
    }
    return buffer.toString();
  }
}

class _PackageRelationHelper {
  final PackageRelation packageRelation;
  final BuiltMap<ValueClassRelation, _ValueClassRelationHelper> valueClasses;

  String get fromName => packageRelation.from.name;
  String get toName => packageRelation.to.name;

  Iterable<_ValueClassRelationHelper> get classHelpers => valueClasses.values;

  Iterable<_PropertyRelationHelper> get allPropertyHelpers =>
      classHelpers.expand((ch) => ch.properties.values);

  Iterable<_PropertyRelationHelper> get abstractPropertyHelpers =>
      allPropertyHelpers.where(
          (h) => h.to.singleType.isAbstract || h.from.singleType.isAbstract);

  Iterable<PropertyRelation> get abstractPropertyRelations =>
      abstractPropertyHelpers.map((h) => h.propertyRelation);

  BuiltSetMultimap<Classifier, Classifier> get requiredTransforms =>
      _typeMapFor(allPropertyHelpers.where((h) => h.converterRequired));

  BuiltSetMultimap<Classifier, Classifier> get requiredAbstractTransforms =>
      _typeMapFor(abstractPropertyHelpers);

  BuiltSetMultimap<Classifier, Classifier> get providedTransforms {
    return new BuiltSetMultimap<Classifier, Classifier>.build((b) {
      b.addIterable(packageRelation.classifierRelations,
          key: (ClassifierRelation cr) => cr.from,
          value: (ClassifierRelation cr) => cr.to);
    });
  }

  String get name =>
      '${packageRelation.from.name}To${packageRelation.to.name}Relation';

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

  BuiltSet<_ValueClassRelationHelper> subTypesOf(
          ValueClass from, ValueClass to) =>
      new BuiltSet<_ValueClassRelationHelper>(
          classHelpers.where((ch) => ch.classRelation.isSubTypeOf(from, to)));

  BuiltSetMultimap<Classifier, Classifier> _typeMapFor(
      Iterable<_PropertyRelationHelper> prs) {
    return new BuiltSetMultimap<Classifier, Classifier>.build((b) {
      b.addIterable(prs,
          key: (_PropertyRelationHelper pr) => pr.from.singleType,
          value: (_PropertyRelationHelper pr) => pr.to.singleType);
    });
  }
}

class _ValueClassRelationHelper {
  final ValueClassRelation classRelation;
  final BuiltMap<PropertyRelation, _PropertyRelationHelper> properties;

  Iterable<_PropertyRelationHelper> get convertingProperties =>
      properties.values.where((p) => p.converterRequired);

  Iterable<_TransformDescriptor> get transformerFields2 =>
      properties.values.expand((h) => h.transformDescriptor);

  Iterable<FieldMetadata> get transformerFields =>
      transformerFields2.map((td) => new FieldMetadata.field(
          td.variableName, new TypeMetadata(td.typeString),
          isFinal: true));

  bool get hasDependencies => transformerFields2.isNotEmpty;

  String get fromName => classRelation.from.name;
  String get toName => classRelation.to.name;
  String get className => '${fromName}To${toName}Transformation';
  String get createTransformName => '_create${fromName}To${toName}Transform';

  @deprecated
  String get transformerFieldsOld => transformerFields2
      .map((d) => 'final ${d.typeString} ${d.variableName};')
      .join('\n');

  Iterable<String> get transformerParameters =>
      transformerFields2.map((d) => 'this.${d.variableName}');

  String get transformerParams =>
      transformerFields2.map((d) => 'this.${d.variableName}').join(', ');

  String get constructorParams => transformerFields2
      .map((d) => '_create${_capitalise(d.variableName)}()')
      .join(', ');

  /// How to find this relation in the model
  String relationModelExpression(String packageRelationName) =>
      '''$packageRelationName.classifierRelations.firstWhere(
      (cr) => cr.from.name == '$fromName' && cr.to.name == '$toName')
    as ValueClassRelation;''';

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

  String get fromName => from.singleTypeName;
  String get toName => to.singleTypeName;

  @override
  bool operator ==(other) =>
      other is _PropertyRelationHelper &&
      other.fromName == fromName &&
      other.toName == toName;

  @override
  int get hashCode => hash2(fromName, toName);

  bool get converterRequired => from.singleType != to.singleType;
  bool get hasCustomTransform => propertyRelation.transform != null;

  Option<_TransformDescriptor> _transformDescriptor;

  Option<_TransformDescriptor> get transformDescriptor =>
      _transformDescriptor ??= _createTransformDescriptor();

  String pathExpression(BuiltList<String> path) =>
      'new BuiltList<String>(${[path.map((s) => "'$s'").join(', ')]})';

  String get fromPathExpression => pathExpression(from.end.path);
  String get toPathExpression => pathExpression(to.end.path);

  /// How to find this relation in the model
  String relationModelExpression(String classVariableName) =>
      '''$classVariableName.propertyRelations
        .firstWhere((pr) => pr.from.path == ${pathExpression(from.end.path)}
        && pr.to.path == ${pathExpression(to.end.path)});
    ''';

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

  /// type for a single item. If in a collection then it is the type of a
  /// single element
  Classifier get singleType {
    final p = end.property;
    if (p.isCollection) {
      final gt = p.type as GenericType;
      return gt.genericTypeValues.values.first;
    }
    return p.type;
  }

  String get singleTypeName => singleType.name;

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

  String get createMethodDeclaration =>
      '$typeString _create${_capitalise(variableName)}()';

  _TransformDescriptor(this.typeString, this.variableName, this.isBuilder);
}

/*
    final classRelation = packageRelation.classifierRelations.firstWhere(
            (cr) => cr.from.name == 'Schema' && cr.to.name == 'Package')
        as ValueClassRelation;

    final pr = classRelation.propertyRelations
        .firstWhere((pr) => pr.from.path == 'id' && pr.to.path == 'name');
    final transform = pr.transform.forwards as Transform<Uri, String>;

 */

// TODO: these should be in a util
String _capitalise(String s) =>
    s.substring(0, 1).toUpperCase() + s.substring(1);

String _uncapitalise(String s) =>
    s.substring(0, 1).toLowerCase() + s.substring(1);
