library transform;

import 'package:built_json/built_json.dart';
import 'package:built_value/built_value.dart';
import 'package:vcore/vcore.dart';
import 'package:built_collection/built_collection.dart';

part 'transform.g.dart';

typedef Classifier VCoreMirrorSystem(Type type);

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
  static final Serializer<PackageRelation> serializer =
      _$packageRelationSerializer;
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
      ..classifierRelations = (new SetBuilder<ClassifierRelation>()
        ..addAll(classifierRelations.map((pr) => pr.reversed()))));
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

typedef Classifier Transform(Classifier);

abstract class ClassifierRelation<
        V extends Classifier<V, B>,
        B extends ClassifierBuilder<V, B>,
        V2 extends Classifier<V2, B2>,
        B2 extends ClassifierBuilder<V2, B2>>
    implements
        Relation<V, V2, ClassifierRelation<V, B, V2, B2>,
            ClassifierRelation<V2, B2, V, B>> {
  V get from;
  V2 get to;

  ClassifierRelation<V2, B2, V, B> reversed();
}

abstract class ClassifierRelationBuilder<
    V extends Classifier<V, B>,
    B extends ClassifierBuilder<V, B>,
    V2 extends Classifier<V2, B2>,
    B2 extends ClassifierBuilder<V2, B2>> {
  V from;
  V2 to;
}

abstract class ValueClassRelation
    implements
        Built<ValueClassRelation, ValueClassRelationBuilder>,
        ClassifierRelation<ValueClass, ValueClassBuilder, ValueClass,
            ValueClassBuilder>,
        SymmetricallyTypedRelation<ValueClass, ValueClassRelation> {
  static final Serializer<ValueClassRelation> serializer =
      _$valueClassRelationSerializer;

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
  static final Serializer<PropertyRelation> serializer =
      _$propertyRelationSerializer;

  BuiltList<String> get fromPath;
  BuiltList<String> get toPath;
  NameRelation get nameRelation;

  PropertyRelation._();

  factory PropertyRelation([updates(PropertyRelationBuilder b)]) =
      _$PropertyRelation;

  @override
  PropertyRelation reversed() {
    return new PropertyRelation((PropertyRelationBuilder b) => b
      ..fromPath = toPath.toBuilder()
      ..toPath = fromPath.toBuilder());
  }
}

abstract class PropertyRelationBuilder
    implements Builder<PropertyRelation, PropertyRelationBuilder> {
  PropertyRelationBuilder._();

  ListBuilder<String> fromPath = new ListBuilder<String>();
  ListBuilder<String> toPath = new ListBuilder<String>();
  NameRelation nameRelation;

  factory PropertyRelationBuilder() = _$PropertyRelationBuilder;
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
  static final Serializer<SchemeBasedNameRelation> serializer =
      _$schemeBasedNameRelationSerializer;

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

//abstract class NamingScheme {
//  String convert(String input);
//}
//
//class CamelCaseNamingScheme implements NamingScheme {
//
//  @override
//  String convert(String input) {
//    // TODO: implement convert
//  }
//}

typedef String NameConversion(String input);

String toCamelCase(String input) {}

String toSnakeCase(String input) {}

//class CamelCaseNamingScheme implements NamingScheme {
//
//  @override
//  String convert(String input) {
//    // TODO: implement convert
//  }
//}
