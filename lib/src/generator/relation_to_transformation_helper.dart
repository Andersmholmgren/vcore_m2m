import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:vcore/vcore.dart';
import 'package:option/option.dart';
import 'package:built_collection/built_collection.dart';
import 'package:logging/logging.dart';

import 'package:dogma_codegen/codegen.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:quiver/iterables.dart';
import 'template.dart';

final _log = new Logger('vcore.m2m.relation.transformation');

class RelationToTransformationHelper {
  final PackageRelation packageRelation;
  final StringSink sink;
  final _PackageRelationHelper packageRelationHelper;

  RelationToTransformationHelper._(
      this.packageRelation, this.sink, this.packageRelationHelper);

  RelationToTransformationHelper(
      PackageRelation packageRelation, StringSink sink)
      : this._(
            packageRelation, sink, new _PackageRelationHelper(packageRelation));

  void generate() {
    _log.info(() => 'generating transformer for ${packageRelationHelper.name}');

    sink.writeln('// starts here');

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
      return packageRelationHelper.valueClasses.values.map((h) {
        final StringBuffer buffer = new StringBuffer();
        h.properties.forEach((pr, ph) {
          if (ph.hasCustomTransform) {
            buffer.writeln(b(ph.fromName, ph.toName, ph.fromPathExpression,
                ph.toPathExpression));
          }
        });
        return buffer.toString();
      }).join('\n');
    }

    sink.writeln(template(_uncapitalise, perClassRelation,
        perRequiredAbstractToConcreteTransform, perCustomTransform));
//    if (true) return;
//
//    sink.writeln('''
//    final _log = new Logger('${packageRelationHelper.name}');
//    ''');
//
//    packageRelationHelper.valueClasses.values.forEach(_generateClassifier);
//    _generateTransformationContext();
  }

  void _generateClassifier(_ValueClassRelationHelper helper) {
    final transformerCtrParams = helper.transformerFields.map(
        (fm) => new ParameterMetadata(fm.name, fm.type, isInitializer: true));

    final superCtrParams = [
      new ParameterMetadata("from", type(helper.fromName)),
      new ParameterMetadata("context", type("TransformationContext"))
    ];

    final superCallParams = concat([
      superCtrParams.map((p) => p.name),
      ['new ${helper.toName}Builder()']
    ]);

    final superCtrCall = 'super(${superCallParams.join(', ')})';

    final StringBuffer buffer = new StringBuffer();

    generateClassDefinition(
        new ClassMetadata(helper.className,
            supertype: new TypeMetadata("AbstractTransformation", arguments: [
              type(helper.fromName),
              type("${helper.fromName}Builder"),
              type(helper.toName),
              type("${helper.toName}Builder")
            ])),
        buffer, (_, __) {
      generateFields(helper.transformerFields, buffer);

      buffer.writeln();

      generateConstructorDefinition(
          new ConstructorMetadata(type(helper.className),
              parameters:
                  concat([superCtrParams, transformerCtrParams]).toList()),
          buffer, initializerListGenerator: (_, __) {
        buffer.write(superCtrCall);
      });

      buffer.writeln();

      generateFunctionDefinition(
          new MethodMetadata('mapProperties', type('void'),
              annotations: [override]),
          buffer, (_, __) {
        buffer.writeln(
            '''_log.finer(() => 'mapProperties for ${helper.className}');''');
        buffer.writeln();
        _generateProperties(helper, buffer);
      }, annotationGenerators: [generateOverrideAnnotation]);
    });

    sink.write(buffer);
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

  void _generateTransformationContext() {
    final StringBuffer buffer = new StringBuffer();

    buffer.writeln('''
Option<Transform/*<F, T>*/ > lookupTransform/*<F, T>*/(
    Type fromType, Type toType) {
  return new _TransformationContext(relations.rootPackageRelation)
      .lookupTransform/*<F, T>*/(fromType, toType);
}
''');

    const String contextClassname = '_TransformationContext';
    generateClassDefinition(
        new ClassMetadata(contextClassname,
            supertype: type("BaseTransformationContext")),
        buffer, (_, __) {
      final packageRelationField = new FieldMetadata.field(
          'packageRelation', type('PackageRelation'),
          isFinal: true);

      generateFields([packageRelationField], buffer);

      buffer.writeln();

      generateConstructorDefinition(
          new ConstructorMetadata(type(contextClassname), parameters: [
            new ParameterMetadata.forField(packageRelationField)
          ]),
          buffer, generator: (_, __) {
//        buffer.write(superCtrCall);

        final classHelpers = packageRelationHelper.classHelpers;

        classHelpers.forEach((helper) {
          buffer.writeln('''
      ..[new TransformKey((b) => b
        ..from = ${helper.fromName}
        ..to = ${helper.toName})] = ${helper.createTransformName}
    ''');
        });

        buffer.writeln(''')
    .build();
  }
    ''');
      });

      buffer.writeln();

      generateFunctionDefinition(
          new MethodMetadata('mapProperties', type('void'),
              annotations: [override]),
          buffer, (_, __) {
        buffer.writeln('''
    transformers = (new MapBuilder<TransformKey, TransformFactory>()
            ''');
        buffer.writeln();
//        _generateProperties(helper, buffer);
      }, annotationGenerators: [generateOverrideAnnotation]);
    });

    sink.write(buffer);

    sink.writeln('''
Option<Transform/*<F, T>*/ > lookupTransform/*<F, T>*/(
    Type fromType, Type toType) {
  return new _TransformationContext(relations.rootPackageRelation)
      .lookupTransform/*<F, T>*/(fromType, toType);
}

class _TransformationContext extends BaseTransformationContext {
  final PackageRelation packageRelation;

  _TransformationContext(this.packageRelation) {
    transformers = (new MapBuilder<TransformKey, TransformFactory>()
    ''');

    final classHelpers = packageRelationHelper.classHelpers;

    classHelpers.forEach((helper) {
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

    _generateTransformFactoryMethods(classHelpers);

    packageRelationHelper.requiredTransforms.forEach((from, to) {
      print('require: ${from.name} -> ${to.name} (${to.isAbstract})');
    });

    packageRelationHelper.providedTransforms.forEach((from, to) {
      print('provided: ${from.name} -> ${to.name}');
    });

//    packageRelationHelper.requiredAbstractTransforms.forEach((from, to) {
//      print('requiredAbstractTransforms: ${from.name} -> ${to.name}');
//    });

    _generateAbstractToConcreteMethods(classHelpers);

    _generateCustomTransformFactoryMethods(classHelpers);

    sink.writeln('''
}
    ''');
  }

  void _generateTransformFactoryMethods(
      Iterable<_ValueClassRelationHelper> classHelpers) {
    classHelpers.forEach((helper) {
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
  }

  void _generateCustomTransformFactoryMethods(
      Iterable<_ValueClassRelationHelper> classHelpers) {
    classHelpers.forEach((ch) {
      ch.properties.forEach((pr, ph) {
        if (ph.hasCustomTransform) {
          sink.writeln('''
          ${ph.transformDescriptor.get().createMethodDeclaration} {
          // TODO: should cache these lookups
            final classRelation = ${ch.relationModelExpression('packageRelation')}

            final propertyRelation = ${ph.relationModelExpression('classRelation')}

            return propertyRelation.transform.forwards as Transform<${ph.fromName}, ${ph.toName}>;
          }
          ''');
        }
      });
    });
  }

  void _generateAbstractToConcreteMethods(
      Iterable<_ValueClassRelationHelper> classHelpers) {
    packageRelationHelper.requiredAbstractTransforms.forEach((from, to) {
      final fromName = from.name;
      final toName = to.name;
      print('requiredAbstractTransforms: $fromName -> $toName');

      if (from is ValueClass && to is ValueClass) {
        _generateAbstractToConcreteMethod(
            fromName, toName, packageRelationHelper.subTypesOf(from, to));
      }
    });
  }

  void _generateAbstractToConcreteMethod(
      String requiredFromName,
      String requiredToName,
      BuiltSet<_ValueClassRelationHelper> subTypeRelations) {
    final propertyHelper =
        packageRelationHelper.abstractPropertyHelpers.firstWhere((h) {
      //          print(
      //              'from: ${h.from.singleTypeName}; ${h.propertyRelation.from.property.type.name}; ${from.name}');
      return h.from.singleTypeName == requiredFromName &&
          h.to.singleTypeName == requiredToName;
    });

    print('propertyHelper: $propertyHelper');

    final transformDescriptor = propertyHelper.transformDescriptor.get();

    sink.writeln('''
      ${transformDescriptor.createMethodDeclaration} {
    ''');

    // create local Transform objects
    subTypeRelations.forEach((vh) {
      sink.writeln('''
        final ${_uncapitalise(vh.className)} = ${vh.createTransformName}();
      ''');
    });

    final requiredFromVariableName = _uncapitalise(requiredFromName);
    sink.writeln('''
      return ($requiredFromName $requiredFromVariableName) {
    ''');

//    sink.writeln('''
//        // TODO: delete
//        if (1 == 2) {
//          return null;
//        }
//      ''');

    subTypeRelations.forEach((vh) {
      sink.writeln('''
        if ($requiredFromVariableName is ${vh.fromName}) {
          return ${_uncapitalise(vh.className)}($requiredFromVariableName as ${vh.fromName});
        }
      ''');
    });

    sink.writeln('''
      else {
        throw new StateError(
            "No transform from \${$requiredFromVariableName.runtimeType} to $requiredToName");
      }
    };
    ''');

    sink.writeln('''
      }
    ''');
  }
}

class _PackageRelationHelper {
  final PackageRelation packageRelation;
  final BuiltMap<ValueClassRelation, _ValueClassRelationHelper> valueClasses;

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

TypeMetadata type(String name) => new TypeMetadata(name);
