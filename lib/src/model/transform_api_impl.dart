import 'dart:mirrors';

import 'package:built_collection/built_collection.dart';
import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/src/model/transform.dart';
import 'package:vcore_m2m/src/model/transform_api.dart';
import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:vcore_m2m/src/model/relation.dart';
import 'dart:convert';

PackageRelation relateModels(
    Package from,
    Package to,
    VCoreMirrorSystem reflectFrom,
    VCoreMirrorSystem reflectTo,
    updates(VPackageRelationHelper h)) {
  final packageHelper = new _VPackageRelationHelper(reflectFrom, reflectTo);
  updates(packageHelper);

  return new PackageRelation((PackageRelationBuilder b) {
    b
      ..from = from
      ..to = to
      // TODO: not sure we need the mirrors on the model itself??
      ..reflectFrom = reflectFrom
      ..reflectTo = reflectTo
      ..classifierRelations.addAll(packageHelper.classifierRelations
          .build()
          .map/*<ClassifierRelation>*/(
              (h) => h.classRelation as ClassifierRelation));
  });
}

class _VPackageRelationHelper implements VPackageRelationHelper {
  final VCoreMirrorSystem reflectFrom;
  final VCoreMirrorSystem reflectTo;

  final ListBuilder<_VClassRelationHelper> classifierRelations =
      new ListBuilder<_VClassRelationHelper>();

  _VPackageRelationHelper(this.reflectFrom, this.reflectTo) {
    if (reflectFrom == null) throw new ArgumentError.notNull('reflectFrom');
    if (reflectTo == null) throw new ArgumentError.notNull('reflectTo');
  }

  @override
  VClassRelationHelper/*<F, T>*/ relate/*<F, T>*/(Type fromType) {
    final helper =
        new _VClassRelationHelper/*<F, T>*/(fromType, reflectFrom, reflectTo);
    classifierRelations.add(helper);
    return helper;
  }

  PackageRelation build() {
    final PackageRelationBuilder builder = new PackageRelationBuilder();
    builder.classifierRelations = new SetBuilder<ClassifierRelation>(
        classifierRelations.build().map((h) => h.classRelation));
    return builder.build();
  }
}

class _VClassRelationHelper<F, T>
    implements VClassRelationHelper<F, T>, VClassRelationHelper2<F, T> {
  Type fromType;
  Type toType;
  ValueClassRelationBuilder _classRelationBuilder =
      new ValueClassRelationBuilder();
  ValueClassRelation get classRelation => _classRelationBuilder.build();
  VCoreMirrorSystem reflectFrom;
  VCoreMirrorSystem reflectTo;

  _VClassRelationHelper(this.fromType, this.reflectFrom, this.reflectTo);

  VClassRelationHelper2<F, T> to(Type toType) {
    this.toType = toType;

    _classRelationBuilder
      ..from = reflectFrom(fromType) as ValueClass
      ..to = reflectTo(toType) as ValueClass;

    return this;
  }

  by(updates(PropertyRelationHelper<F, T> b)) {
    final propRels = new _PropertyRelationsHelper<F, T>(
        _classRelationBuilder.from, _classRelationBuilder.to);
    updates(propRels);

    _classRelationBuilder
      ..propertyRelations.addAll(propRels._props.map((h) => h.builder.build()));
  }
}

class _PropertyRelationsHelper<F, T> implements PropertyRelationHelper<F, T> {
  final List<_PropertyRelationHelper<F, T>> _props = [];
  final ValueClass from;
  final ValueClass to;

  _PropertyRelationsHelper(this.from, this.to);

  @override
  PropertyRelationHelper2<F, T> relate(properties(F from)) {
    final ph = new _PropertyRelationHelper<F, T>(from, to);
    _props.add(ph);
    return ph.relate(properties);
  }
}

class _PropertyRelationHelper<F, T>
    implements
        PropertyRelationHelper<F, T>,
        PropertyRelationHelper2<F, T>,
        PropertyRelationHelper3<F, T> {
  final PropertyRelationBuilder builder = new PropertyRelationBuilder();

  final ValueClass from;
  final ValueClass toCls;

  _PropertyRelationHelper(this.from, this.toCls);

  @override
  PropertyRelationHelper2<F, T> relate(properties(F from)) {
    final capture = new PathExpressionCaptor();
    properties(capture as F);

    _setEnd(capture._segments.build(), from, builder.from);

    return this;
  }

  @override
  PropertyRelationHelper3<F, T> to(properties(T toType)) {
    final capture = new PathExpressionCaptor();
    properties(capture as T);
    _setEnd(capture._segments.build(), toCls, builder.to);
    return this;
  }

  void _setEnd(Iterable<String> path, ValueClass cls,
      PropertyRelationEndBuilder endBuilder) {
    final endProperty = cls.lookupPropertyByPath(path).getOrElse(() =>
        throw new StateError(
            'failed to resolve path $path on class ${cls.name}'));
    endBuilder
      ..path = path
      ..property = endProperty;
  }

  @override
  withNameRelation(NameRelation nameRelation) {
    builder.nameRelation = nameRelation;
  }

  via2/*<A,V>*/(updates(BidirectionalTransformBuilder/*<A,V>*/ b)) {
    final tb = new BidirectionalTransformBuilder/*<A,V>*/();
    updates(tb);
    builder.transform = tb.build();
  }

  @override
  via/*<A,V>*/(Codec/*<A,V>*/ codec) {
    // TODO: implement via
  }
}

class PathExpressionCaptor {
  final ListBuilder<String> _segments = new ListBuilder<String>();

  noSuchMethod(Invocation i) {
    if (!i.isGetter) {
      throw new ArgumentError('can only reference getters in path expressions');
    }
    _segments.add(MirrorSystem.getName(i.memberName));
    return this;
  }
}
