library test_model;

part 'test_model.g.dart';

import 'package:built_value/built_value.dart';
import 'package:built_json/built_json.dart';

abstract class Car
  implements Built<Car, CarBuilder> {
  static final Serializer<Car> serializer = _$carSerializer;


  Car._();

  factory Car([updates(CarBuilder b)]) = _$Car;
}

abstract class CarBuilder
  implements Builder<Car, CarBuilder> {

  CarBuilder._();

  factory CarBuilder() = _$CarBuilder;
}
