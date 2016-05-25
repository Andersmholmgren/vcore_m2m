// GENERATED CODE - DO NOT MODIFY BY HAND
// 2016-05-25T02:32:42.314682Z

part of test_model;

// **************************************************************************
// Generator: BuiltJsonGenerator
// Target: library test_model
// **************************************************************************

Serializer<Car> _$carSerializer = new _$CarSerializer();
Serializer<Wheel> _$wheelSerializer = new _$WheelSerializer();
Serializer<Engine> _$engineSerializer = new _$EngineSerializer();
Serializer<Piston> _$pistonSerializer = new _$PistonSerializer();

class _$CarSerializer implements StructuredSerializer<Car> {
  final Iterable<Type> types = new BuiltList<Type>([Car, _$Car]);
  final String wireName = 'Car';

  @override
  Iterable serialize(Serializers serializers, Car object,
      {FullType specifiedType: FullType.unspecified}) {
    return [
      'wheels',
      serializers.serialize(object.wheels,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(Wheel)])),
      'engine',
      serializers.serialize(object.engine,
          specifiedType: const FullType(Engine)),
    ];
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
          case 'wheels':
            result.wheels.replace(serializers.deserialize(value,
                specifiedType:
                    const FullType(BuiltSet, const [const FullType(Wheel)])));
            break;
          case 'engine':
            result.engine.replace(serializers.deserialize(value,
                specifiedType: const FullType(Engine)));
            break;
        }
      }
    }

    return result.build();
  }
}

class _$WheelSerializer implements StructuredSerializer<Wheel> {
  final Iterable<Type> types = new BuiltList<Type>([Wheel, _$Wheel]);
  final String wireName = 'Wheel';

  @override
  Iterable serialize(Serializers serializers, Wheel object,
      {FullType specifiedType: FullType.unspecified}) {
    return [];
  }

  @override
  Wheel deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new WheelBuilder();

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

class _$EngineSerializer implements StructuredSerializer<Engine> {
  final Iterable<Type> types = new BuiltList<Type>([Engine, _$Engine]);
  final String wireName = 'Engine';

  @override
  Iterable serialize(Serializers serializers, Engine object,
      {FullType specifiedType: FullType.unspecified}) {
    return [
      'capacity',
      serializers.serialize(object.capacity,
          specifiedType: const FullType(double)),
      'piston',
      serializers.serialize(object.piston,
          specifiedType: const FullType(Piston)),
    ];
  }

  @override
  Engine deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new EngineBuilder();

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
          case 'capacity':
            result.capacity = serializers.deserialize(value,
                specifiedType: const FullType(double));
            break;
          case 'piston':
            result.piston.replace(serializers.deserialize(value,
                specifiedType: const FullType(Piston)));
            break;
        }
      }
    }

    return result.build();
  }
}

class _$PistonSerializer implements StructuredSerializer<Piston> {
  final Iterable<Type> types = new BuiltList<Type>([Piston, _$Piston]);
  final String wireName = 'Piston';

  @override
  Iterable serialize(Serializers serializers, Piston object,
      {FullType specifiedType: FullType.unspecified}) {
    return [
      'colour',
      serializers.serialize(object.colour,
          specifiedType: const FullType(String)),
    ];
  }

  @override
  Piston deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new PistonBuilder();

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
          case 'colour':
            result.colour = serializers.deserialize(value,
                specifiedType: const FullType(String));
            break;
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
  final BuiltSet<Wheel> wheels;
  final Engine engine;
  _$Car._({this.wheels, this.engine}) : super._() {
    if (wheels == null) throw new ArgumentError('null wheels');
    if (engine == null) throw new ArgumentError('null engine');
  }
  factory _$Car([updates(CarBuilder b)]) =>
      (new CarBuilder()..update(updates)).build();
  Car rebuild(updates(CarBuilder b)) => (toBuilder()..update(updates)).build();
  _$CarBuilder toBuilder() => new _$CarBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! Car) return false;
    return wheels == other.wheels && engine == other.engine;
  }

  int get hashCode {
    return hashObjects([wheels, engine]);
  }

  String toString() {
    return 'Car {'
        'wheels=${wheels.toString()}\n'
        'engine=${engine.toString()}\n'
        '}';
  }
}

class _$CarBuilder extends CarBuilder {
  _$CarBuilder() : super._();
  void replace(Car other) {
    super.wheels = other.wheels?.toBuilder();
    super.engine = other.engine?.toBuilder();
  }

  void update(updates(CarBuilder b)) {
    if (updates != null) updates(this);
  }

  Car build() {
    if (wheels == null) throw new ArgumentError('null wheels');
    if (engine == null) throw new ArgumentError('null engine');
    return new _$Car._(wheels: wheels?.build(), engine: engine?.build());
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Wheel
// **************************************************************************

class _$Wheel extends Wheel {
  _$Wheel._() : super._() {}
  factory _$Wheel([updates(WheelBuilder b)]) =>
      (new WheelBuilder()..update(updates)).build();
  Wheel rebuild(updates(WheelBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$WheelBuilder toBuilder() => new _$WheelBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! Wheel) return false;
    return true;
  }

  int get hashCode {
    return 133697385;
  }

  String toString() {
    return 'Wheel {}';
  }
}

class _$WheelBuilder extends WheelBuilder {
  _$WheelBuilder() : super._();
  void replace(Wheel other) {}
  void update(updates(WheelBuilder b)) {
    if (updates != null) updates(this);
  }

  Wheel build() {
    return new _$Wheel._();
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Engine
// **************************************************************************

class _$Engine extends Engine {
  final double capacity;
  final Piston piston;
  _$Engine._({this.capacity, this.piston}) : super._() {
    if (capacity == null) throw new ArgumentError('null capacity');
    if (piston == null) throw new ArgumentError('null piston');
  }
  factory _$Engine([updates(EngineBuilder b)]) =>
      (new EngineBuilder()..update(updates)).build();
  Engine rebuild(updates(EngineBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$EngineBuilder toBuilder() => new _$EngineBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! Engine) return false;
    return capacity == other.capacity && piston == other.piston;
  }

  int get hashCode {
    return hashObjects([capacity, piston]);
  }

  String toString() {
    return 'Engine {'
        'capacity=${capacity.toString()}\n'
        'piston=${piston.toString()}\n'
        '}';
  }
}

class _$EngineBuilder extends EngineBuilder {
  _$EngineBuilder() : super._();
  void replace(Engine other) {
    super.capacity = other.capacity;
    super.piston = other.piston?.toBuilder();
  }

  void update(updates(EngineBuilder b)) {
    if (updates != null) updates(this);
  }

  Engine build() {
    if (capacity == null) throw new ArgumentError('null capacity');
    if (piston == null) throw new ArgumentError('null piston');
    return new _$Engine._(capacity: capacity, piston: piston?.build());
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Piston
// **************************************************************************

class _$Piston extends Piston {
  final String colour;
  _$Piston._({this.colour}) : super._() {
    if (colour == null) throw new ArgumentError('null colour');
  }
  factory _$Piston([updates(PistonBuilder b)]) =>
      (new PistonBuilder()..update(updates)).build();
  Piston rebuild(updates(PistonBuilder b)) =>
      (toBuilder()..update(updates)).build();
  _$PistonBuilder toBuilder() => new _$PistonBuilder()..replace(this);
  bool operator ==(other) {
    if (other is! Piston) return false;
    return colour == other.colour;
  }

  int get hashCode {
    return hashObjects([colour]);
  }

  String toString() {
    return 'Piston {'
        'colour=${colour.toString()}\n'
        '}';
  }
}

class _$PistonBuilder extends PistonBuilder {
  _$PistonBuilder() : super._();
  void replace(Piston other) {
    super.colour = other.colour;
  }

  void update(updates(PistonBuilder b)) {
    if (updates != null) updates(this);
  }

  Piston build() {
    if (colour == null) throw new ArgumentError('null colour');
    return new _$Piston._(colour: colour);
  }
}
