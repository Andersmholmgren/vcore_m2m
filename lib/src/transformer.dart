import 'package:vcore_m2m/src/model/transform.dart';
import 'package:vcore/vcore.dart';
import 'package:built_collection/src/list.dart';

import 'package:logging/logging.dart';
import 'package:built_value/built_value.dart';
import 'package:option/option.dart';
import 'package:built_collection/built_collection.dart';
import 'package:vcore_m2m/src/model/relation.dart';

final Logger _log = new Logger('transformer');
typedef Classifier ClassifierMirrorSystem(Type type);

class Transformer {
  final PackageRelation packageRelation;
  final ClassifierMirrorSystem sourceMirrorSystem;
  final ClassifierMirrorSystem targetMirrorSystem;

  Transformer(
      this.packageRelation, this.sourceMirrorSystem, this.targetMirrorSystem);

  // TODO: would like to avoid fromType but from.runtimeType is the _$ one
  // and we can't reflect on it
  /*=T*/ transform/*<F, T>*/(/*=F*/ from, Type fromType, Type toType) {
    return _transform(
        from, fromType, new _TransformationContext(targetMirrorSystem(toType)));
  }

  /*=T*/ _transform/*<F, T>*/(
      /*=F*/ from,
      Type fromType,
      _TransformationContext context) {
    /*
     * Damn. sourceMirrorSystem needs to include _$ classes as that is the
     * runtime type
     */
    return from != null
        ? _transformTo(from, sourceMirrorSystem(fromType), context)
        : null;
  }

  /*=T*/ _transformTo/*<F, T>*/(
      /*=F*/ from,
      ValueClass fromClassifier,
//    ValueClass toClassifier,
      _TransformationContext context) {
    _log.finer('_transformTo(${from?.runtimeType}, ${fromClassifier?.name})');

    if (fromClassifier == null)
      throw new ArgumentError.notNull('fromClassifier');

    /**
     * TODO: need to do something much more efficient (probably code gen)
     * Lookup needs to support inheritance on both sides
     */
    final classifierRelation = packageRelation.classifierRelations
        .firstWhere((cr) => cr.from == fromClassifier);

    if (classifierRelation is ValueClassRelation) {
//      final toBuilder = context.builderFor(classifierRelation.to);
      final ValueClassRelation classRelation = classifierRelation;
      classRelation.propertyRelations.forEach((pr) {
        _transformProperty(fromClassifier, classifierRelation.to, pr, context);
      });
    }
//    classifierRelation.
  }

  void _transformProperty(ValueClass fromClassifier, ValueClass toClassifier,
      PropertyRelation pr, _TransformationContext context) {
    final Property sourceProperty = _resolvePath(fromClassifier, pr.fromPath);
    if (sourceProperty == null) {
      print('No property found for path ${pr.fromPath.join('.')} '
          'on $fromClassifier');
      // ignore. Is that correct or an error?
    } else {
      final Property targetProperty = _resolvePath(toClassifier, pr.toPath);
      // can't be null
      if (targetProperty.isCollection != sourceProperty.isCollection) {
        String _m(Property p) =>
            'a property that is ${p.isCollection ? "" : "not "}a collection';
        throw new ArgumentError('Can only map collections to collections. '
            'Tried to map ${_m(sourceProperty)} to ${_m(targetProperty)}');
      }
      if (sourceProperty.isCollection) {
        print('TODO: support mapping collections');
      } else {
        final sourceValue = context.lookupSourceValue(pr.fromPath);
        if (sourceValue == null) {
          return;
        } else {
          final targetValue = (sourceProperty.type == targetProperty.type)
              ? sourceValue
              : _transformTo(sourceValue, sourceProperty.type, context);
          context.setTargetValue(pr.toPath, targetValue);
        }
      }
    }
  }

  Property _resolvePath(ValueClass fromClassifier, BuiltList<String> fromPath) {
    _log.finest('_resolvePath(${fromClassifier.name}, $fromPath)');
    final property =
        fromClassifier.properties.firstWhere((p) => p.name == fromPath.first);
    if (property == null || fromPath.length == 1) {
      return property;
    } else {
      if (property.type is! ValueClass) {
        throw new ArgumentError(
            'Attempt to resolve path "${fromPath.sublist(1).join('.')}" '
            'on non ValueClass ${property.type}');
      }
      return _resolvePath(property.type as ValueClass, fromPath.sublist(1));
    }
  }
}

class _TransformationContext {
  final ValueClassBuilder _targetBuilder;
  _TransformationContext(Classifier targetClassifier)
      : _targetBuilder = targetClassifier.toBuilder() as ValueClassBuilder;

  ClassifierBuilder builderFor(Classifier to) {}

  lookupSourceValue(BuiltList<String> fromPath) {
    //    e.g. schema.id
  }

  void setTargetValue(BuiltList<String> toPath, value) {}
}

//typedef Classifier Transform(Classifier classifier);
//Built<PackageRelation, PackageRelationBuilder>

//typedef T Transform2<F, T>(F from, Type fromType, Type toType);

abstract class TransformationContext {
//  /*=T*/ transform/*<F, T>*/(/*=F*/ from, Type fromType, Type toType);
  Option<Transform/*<F, T>*/ > lookupTransform/*<F, T>*/(
      Type fromType, Type toType);
}

abstract class AbstractTransformation<
    F extends Built<F, FB>,
    FB extends Builder<F, FB>,
    T extends Built<T, TB>,
    TB extends Builder<T, TB>> {
  final F from;
  final TB toBuilder;
  final TransformationContext context;

  AbstractTransformation(this.from, this.context, this.toBuilder);

  void mapProperties();

  T transform() {
    _log.fine(() => 'transform for $runtimeType');

    mapProperties();

    _log.fine(() => 'building $runtimeType');

    return toBuilder.build();
  }
}

abstract class BaseTransformationContext implements TransformationContext {
  BuiltMap<TransformKey, TransformFactory> transformers;

//
//  TransformLookup/*<F, T>*/ transformLookup/*<F, T>*/() =>
//    lookupTransform/*<F, T>*/;

  Option<Transform/*<F, T>*/ > lookupTransform/*<F, T>*/(
      Type fromType, Type toType) {
    return _lookupTransformFactory(fromType, toType)
        .map((TransformFactory/*<F, T>*/ f) {
      /*=T*/ transform/*<F, T>*/(/*=F*/ from) {
        final Transform/*<F, T>*/ t = f();
        return t(from);
      }
      return transform;
    }) as Option<Transform/*<F, T>*/ >;
  }

  Option<TransformFactory/*<F, T>*/ > _lookupTransformFactory/*<F, T>*/(
      Type fromType, Type toType) {
    return new Option<TransformFactory/*<F, T>*/ >(
        transformers[new TransformKey((b) => b
          ..from = fromType
          ..to = toType)] as TransformFactory/*<F, T>*/);
  }
}
