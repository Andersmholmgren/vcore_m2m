library test_model;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'test_model.g.dart';

abstract class Car implements Built<Car, CarBuilder> {
  BuiltSet<Wheel> get wheels;
  Engine get engine;

  Car._();

  factory Car([updates(CarBuilder b)]) = _$Car;
}

abstract class CarBuilder implements Builder<Car, CarBuilder> {
  SetBuilder<Wheel> wheels = new SetBuilder<Wheel>();
  EngineBuilder engine = new EngineBuilder();

  CarBuilder._();

  factory CarBuilder() = _$CarBuilder;
}

abstract class Wheel implements Built<Wheel, WheelBuilder> {
  Wheel._();

  factory Wheel([updates(WheelBuilder b)]) = _$Wheel;
}

abstract class WheelBuilder implements Builder<Wheel, WheelBuilder> {
  WheelBuilder._();

  factory WheelBuilder() = _$WheelBuilder;
}

abstract class Engine implements Built<Engine, EngineBuilder> {
  double get capacity;
  Piston get piston;

  Engine._();

  factory Engine([updates(EngineBuilder b)]) = _$Engine;
}

abstract class EngineBuilder implements Builder<Engine, EngineBuilder> {
  double capacity;
  PistonBuilder piston = new PistonBuilder();

  EngineBuilder._();

  factory EngineBuilder() = _$EngineBuilder;
}

abstract class Piston implements Built<Piston, PistonBuilder> {
  String get colour;

  Piston._();

  factory Piston([updates(PistonBuilder b)]) = _$Piston;
}

abstract class PistonBuilder implements Builder<Piston, PistonBuilder> {
  PistonBuilder._();

  String colour;

  factory PistonBuilder() = _$PistonBuilder;
}
