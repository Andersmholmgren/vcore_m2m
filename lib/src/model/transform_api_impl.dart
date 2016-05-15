import 'dart:mirrors';

import 'package:built_collection/built_collection.dart';
import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/src/model/transform.dart';
import 'package:vcore_m2m/src/model/transform_api.dart';
import 'package:vcore_m2m/vcore_m2m.dart';

PackageRelation relateModels(
    Package from, Package to, updates(VPackageRelationHelper h)) {
  final packageHelper = new _VPackageRelationHelper();
  updates(packageHelper);

  return new PackageRelation((PackageRelationBuilder b) {
    b
      ..from = from
      ..to = to
      ..classifierRelations.addAll(packageHelper.classifierRelations
          .build()
          .map((h) => h.classRelation));
  });
}

class _VPackageRelationHelper implements VPackageRelationHelper {
  final ListBuilder<_VClassRelationHelper> classifierRelations =
      new ListBuilder<_VClassRelationHelper>();

  @override
  VClassRelationHelper relate(Type fromType) {
    final helper = new _VClassRelationHelper(fromType);
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
  ValueClassRelation classRelation;

  _VClassRelationHelper(this.fromType);

  VClassRelationHelper2 to(Type toType) {
    this.toType = toType;
    return this;
  }

  by(updates(PropertyRelationHelper<F, T> b)) {
    final propRels = new _PropertyRelationsHelper<F, T>();
    updates(propRels);

    classRelation = new ValueClassRelation((b) => b
      ..from = e.reflectVClass(fromType)
      ..to = e.reflectVClass(toType)
      ..propertyRelations
          .addAll(propRels._props.map((h) => h.builder.build())));
  }
}

class _PropertyRelationsHelper<F, T> implements PropertyRelationHelper<F, T> {
  final List<_PropertyRelationHelper<F, T>> _props = [];

  @override
  PropertyRelationHelper2<F, T> relate(properties(F from)) {
    final ph = new _PropertyRelationHelper<F, T>();
    _props.add(ph);
    return ph.relate(properties);
  }
}

class _PropertyRelationHelper<F, T>
    implements PropertyRelationHelper<F, T>, PropertyRelationHelper2<F, T> {
  final PropertyRelationBuilder builder = new PropertyRelationBuilder();

  @override
  PropertyRelationHelper2<F, T> relate(properties(F from)) {
    final capture = new PathExpressionCaptor();
    properties(capture as F);
    builder.fromPath = capture._segments;
    return this;
  }

  @override
  to(properties(T toType)) {
    final capture = new PathExpressionCaptor();
    properties(capture as T);
    builder.toPath = capture._segments;
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
