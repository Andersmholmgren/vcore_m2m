library transform;

import 'package:built_collection/built_collection.dart';
import 'package:built_json/built_json.dart';
import 'package:built_value/built_value.dart';
import 'package:option/option.dart';
import 'package:vcore/vcore.dart';

part 'transform.g.dart';

typedef Classifier VCoreMirrorSystem(Type type);

//typedef Classifier Transform(Classifier classifier);

//typedef T Transform<F, T>(F from, Type fromType, Type toType);
typedef T Transform<F, T>(F from);

typedef Option<Transform<F, T>> TransformLookup<F, T>(
    Type fromType, Type toType);

typedef Transform<F, T> TransformFactory<F, T>();

// Like a codec

abstract class BidirectionalTransform<F, T>
    implements
        Built<BidirectionalTransform<F, T>,
            BidirectionalTransformBuilder<F, T>>,
        Relation<F, T, BidirectionalTransform<F, T>,
            BidirectionalTransform<T, F>> {
  Transform<F, T> get forwards;
  Transform<T, F> get backwards;

  BidirectionalTransform._();

//  factory BidirectionalTransform([updates(BidirectionalTransformBuilder b)]) =
//      _$BidirectionalTransform;

  factory BidirectionalTransform(
          [updates(BidirectionalTransformBuilder<F, T> b)]) =
      _$BidirectionalTransform;

  @override
  BidirectionalTransform<T, F> reversed() =>
      new BidirectionalTransform<T, F>((b) {
        b.backwards = forwards;
        b.forwards = backwards;
      });
}

abstract class BidirectionalTransformBuilder<F, T>
    implements
        Builder<BidirectionalTransform<F, T>,
            BidirectionalTransformBuilder<F, T>> {
  BidirectionalTransformBuilder._();
  Transform<F, T> forwards;
  Transform<T, F> backwards;

  factory BidirectionalTransformBuilder() = _$BidirectionalTransformBuilder;
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

/// TODO This is an impl class. Being lazy and putting it here as I want to
/// benefit from built_value hashCode / equals
abstract class TransformKey
    implements Built<TransformKey, TransformKeyBuilder> {
  Type get from;
  Type get to;

  TransformKey._();

  factory TransformKey([updates(TransformKeyBuilder b)]) = _$TransformKey;
}

abstract class TransformKeyBuilder
    implements Builder<TransformKey, TransformKeyBuilder> {
  Type from;
  Type to;

  TransformKeyBuilder._();

  factory TransformKeyBuilder() = _$TransformKeyBuilder;
}
