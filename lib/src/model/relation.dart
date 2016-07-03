library relation;

import 'package:built_collection/built_collection.dart';
import 'package:built_json/built_json.dart';
import 'package:built_value/built_value.dart';
import 'package:vcore/vcore.dart';

import 'transform.dart';

part 'relation.g.dart';

abstract class Relation<A, B, R1 extends Relation<A, B, R1, R2>,
    R2 extends Relation<B, A, R2, R1>> {
  R2 reversed();
}

abstract class SymmetricallyTypedRelation<A,
        R extends SymmetricallyTypedRelation<A, R>>
    implements
        Relation<A, A, SymmetricallyTypedRelation<A, R>,
            SymmetricallyTypedRelation<A, R>> {}

abstract class PackageRelation
    implements
        Built<PackageRelation, PackageRelationBuilder>,
        SymmetricallyTypedRelation<Package, PackageRelation> {
  Package get from;
  Package get to;

  VCoreMirrorSystem get reflectFrom;
  VCoreMirrorSystem get reflectTo;

  BuiltSet<ClassifierRelation> get classifierRelations;

  PackageRelation._();

  factory PackageRelation([updates(PackageRelationBuilder b)]) =
      _$PackageRelation;

  PackageRelation reversed() {
    return new PackageRelation((PackageRelationBuilder b) => b
      ..from = to
      ..to = from
      ..reflectFrom = reflectTo
      ..reflectTo = reflectFrom
      ..classifierRelations = (new SetBuilder<ClassifierRelation>()
        ..addAll(classifierRelations.map/*<ClassifierRelation>*/(
            (pr) => pr.reversed() as ClassifierRelation))));
  }
}

abstract class PackageRelationBuilder
    implements Builder<PackageRelation, PackageRelationBuilder> {
  PackageRelationBuilder._();
  Package from;
  Package to;
  VCoreMirrorSystem reflectFrom;
  VCoreMirrorSystem reflectTo;

  SetBuilder<ClassifierRelation> classifierRelations =
      new SetBuilder<ClassifierRelation>();

  factory PackageRelationBuilder() = _$PackageRelationBuilder;
}

abstract class ClassifierRelation<
        V extends TypedClassifier<V, B>,
        B extends TypedClassifierBuilder<V, B>,
        V2 extends TypedClassifier<V2, B2>,
        B2 extends TypedClassifierBuilder<V2, B2>>
    implements
        Relation<V, V2, ClassifierRelation<V, B, V2, B2>,
            ClassifierRelation<V2, B2, V, B>> {
  V get from;
  V2 get to;

  ClassifierRelation<V2, B2, V, B> reversed();
}

abstract class ClassifierRelationBuilder<
    V extends TypedClassifier<V, B>,
    B extends TypedClassifierBuilder<V, B>,
    V2 extends TypedClassifier<V2, B2>,
    B2 extends TypedClassifierBuilder<V2, B2>> {
  V from;
  V2 to;
}

abstract class ValueClassRelation
    implements
        Built<ValueClassRelation, ValueClassRelationBuilder>,
        ClassifierRelation<ValueClass, ValueClassBuilder, ValueClass,
            ValueClassBuilder>,
        SymmetricallyTypedRelation<ValueClass, ValueClassRelation> {
  ValueClass get from;
  ValueClass get to;
  BuiltSet<PropertyRelation> get propertyRelations;

  ValueClassRelation._();

  factory ValueClassRelation([updates(ValueClassRelationBuilder b)]) =
      _$ValueClassRelation;

  ValueClassRelation reversed() {
    return new ValueClassRelation((ValueClassRelationBuilder b) => b
      ..from = to
      ..to = from
      ..propertyRelations = (new SetBuilder<PropertyRelation>()
        ..addAll(propertyRelations.map((pr) => pr.reversed()))));
  }

  /// When transforming from [from] to [to] is [this] relation applicable
  bool isApplicableTo(ValueClass from, ValueClass to) =>
      from.isSubTypeOf(this.from) && to.isSubTypeOf(this.to);

  /// ??
  bool isSubTypeOf(ValueClass from, ValueClass to) =>
      this.from.isSubTypeOf(from) && this.to.isSubTypeOf(to);
}

abstract class ValueClassRelationBuilder
    implements
        Builder<ValueClassRelation, ValueClassRelationBuilder>,
        ClassifierRelationBuilder<ValueClass, ValueClassBuilder, ValueClass,
            ValueClassBuilder> {
  ValueClassRelationBuilder._();

  ValueClass from;
  ValueClass to;
  SetBuilder<PropertyRelation> propertyRelations =
      new SetBuilder<PropertyRelation>();

  factory ValueClassRelationBuilder() = _$ValueClassRelationBuilder;
}

// TODO: maybe rename a FeatureRelation
abstract class PropertyRelation
    implements
        Built<PropertyRelation, PropertyRelationBuilder>,
        SymmetricallyTypedRelation<Property, PropertyRelation> {
  PropertyRelationEnd get from;
  PropertyRelationEnd get to;
  @nullable
  @deprecated
  NameRelation get nameRelation;

  /// Optional explicit transform pair
  @nullable
  BidirectionalTransform get transform;

  PropertyRelation._();

  factory PropertyRelation([updates(PropertyRelationBuilder b)]) =
      _$PropertyRelation;

  @override
  PropertyRelation reversed() {
    return new PropertyRelation((PropertyRelationBuilder b) => b
      ..to = from.toBuilder()
      ..from = to.toBuilder()
      ..transform = transform?.reversed());
  }
}

abstract class PropertyRelationBuilder
    implements Builder<PropertyRelation, PropertyRelationBuilder> {
  PropertyRelationBuilder._();

  PropertyRelationEndBuilder from = new PropertyRelationEndBuilder();
  PropertyRelationEndBuilder to = new PropertyRelationEndBuilder();

  @nullable
  NameRelation nameRelation;

  @nullable
  BidirectionalTransform transform;

  factory PropertyRelationBuilder() = _$PropertyRelationBuilder;
}

abstract class PropertyRelationEnd
    implements Built<PropertyRelationEnd, PropertyRelationEndBuilder> {
  BuiltList<String> get path;
  Property get property;

  PropertyRelationEnd._();

  factory PropertyRelationEnd([updates(PropertyRelationEndBuilder b)]) =
      _$PropertyRelationEnd;
}

abstract class PropertyRelationEndBuilder
    implements Builder<PropertyRelationEnd, PropertyRelationEndBuilder> {
  BuiltList<String> path;
  Property property;

  PropertyRelationEndBuilder._();

  factory PropertyRelationEndBuilder() = _$PropertyRelationEndBuilder;
}

abstract class NameRelationContext {}

/// TODO: Need to formalise how identifier names are mapped
/// - needs to work with schema id -> value class names
///   - note we may need to populate id's in each schema when we parse them
///   as otherwise we need to do it in the translation
///   - names are namespaced (package.name => fully qualified name)
/// - needs to support custom name mappings in bv property <-> json property
///   .e.g @jsonName("fred_flintstone")
/// - we should also support transformation wide snake case to camel case etc
///
abstract class NameRelation {
  String deriveForwards(String from, NameRelationContext context);
  String deriveBackwards(String to, NameRelationContext context);
}

abstract class SchemeBasedNameRelation
    implements
        Built<SchemeBasedNameRelation, SchemeBasedNameRelationBuilder>,
        NameRelation {
  NameConversion get forwardConversion;
  NameConversion get reverseConversion;

  SchemeBasedNameRelation._();

  factory SchemeBasedNameRelation([updates(SchemeBasedNameRelationBuilder b)]) =
      _$SchemeBasedNameRelation;

  @override
  String deriveBackwards(String to, NameRelationContext context) =>
      forwardConversion(to);

  @override
  String deriveForwards(String from, NameRelationContext context) =>
      reverseConversion(from);
}

abstract class SchemeBasedNameRelationBuilder
    implements
        Builder<SchemeBasedNameRelation, SchemeBasedNameRelationBuilder> {
  NameConversion forwardConversion;
  NameConversion reverseConversion;

  SchemeBasedNameRelationBuilder._();

  factory SchemeBasedNameRelationBuilder() = _$SchemeBasedNameRelationBuilder;
}
