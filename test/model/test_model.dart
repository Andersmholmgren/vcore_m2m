library test_model;

import 'package:built_value/built_value.dart';
import 'package:built_json/built_json.dart';
import 'package:built_collection/built_collection.dart';

part 'test_model.g.dart';

abstract class Car implements Built<Car, CarBuilder> {
  static final Serializer<Car> serializer = _$carSerializer;

  BuiltSet<Wheel> get wheels;

  Car._();

  factory Car([updates(CarBuilder b)]) = _$Car;
}

abstract class CarBuilder implements Builder<Car, CarBuilder> {
  SetBuilder<Wheel> wheels = new SetBuilder<Wheel>();

  CarBuilder._();

  factory CarBuilder() = _$CarBuilder;
}

abstract class Wheel
  implements Built<Wheel, WheelBuilder> {
  static final Serializer<Wheel> serializer = _$wheelSerializer;


  Wheel._();

  factory Wheel([updates(WheelBuilder b)]) = _$Wheel;
}

abstract class WheelBuilder
  implements Builder<Wheel, WheelBuilder> {

  WheelBuilder._();

  factory WheelBuilder() = _$WheelBuilder;
}


abstract class Engine
  implements Built<Engine, EngineBuilder> {
  static final Serializer<Engine> serializer = _$engineSerializer;


  Engine._();

  factory Engine([updates(EngineBuilder b)]) = _$Engine;
}

abstract class EngineBuilder
  implements Builder<Engine, EngineBuilder> {

  EngineBuilder._();

  factory EngineBuilder() = _$EngineBuilder;
}
