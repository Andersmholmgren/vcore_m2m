// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-05-25T02:02:20.889569Z

part of test_model;

// **************************************************************************
// Generator: BuiltJsonGenerator
// Target: library test_model
// **************************************************************************

Serializer<Car> _$carSerializer = new _$CarSerializer();

class _$CarSerializer implements StructuredSerializer<Car> {
  final Iterable<Type> types = new BuiltList<Type>([Car, _$Car]);
  final String wireName = 'Car';

  @override
  Iterable serialize(Serializers serializers, Car object,
      {FullType specifiedType: FullType.unspecified}) {
    return [];
  }

  @override
  Car deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new CarBuilder();

    var key;
    var value;
    var expectingKey = true;
    for (final item in serialized) {
      if (expectingKey) {
        key = item;
        expectingKey = false;
      } else {
        value = item;
        expectingKey = true;

        switch (key as String) {
        }
      }
    }

    return result.build();
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Car
// **************************************************************************

class _$Car extends Car {
  _$Car._() : super._() {}
  factory _$Car([updates(CarBuilder b)]) =>
      (new CarBuilder()..update(updates)).build();
  Car rebuild(updates(CarBuilder b)) => (toBuilder()..update(updates)).build();
  _$CarBuilder toBuilder() => new _$CarBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! Car) return false;
    return true;
  }

  int get hashCode {
    return 194915866;
  }

  String toString() {
    return 'Car {}';
  }
}

class _$CarBuilder extends CarBuilder {
  _$CarBuilder() : super._();
  void replace(Car other) {}
  void update(updates(CarBuilder b)) {
    if (updates != null) updates(this);
  }

  Car build() {
    return new _$Car._();
  }
}
