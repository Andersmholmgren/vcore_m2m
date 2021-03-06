import 'model/test_model.dart';
import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:vcore/vcore.dart';
import 'package:built_collection/built_collection.dart';

foo() {
  // resolve car.engine.piston.colour and set to 'green'
  ValueClassRelation vcr;
  var prs = vcr.propertyRelations;
  var pr = prs.first;
  pr.toPath;


  EngineBuilder engineResolver(CarBuilder carBuilder) {
    if (carBuilder.engine == null) {
      carBuilder.engine = new EngineBuilder();
    }
    return carBuilder.engine;
  }
  PistonBuilder pistonResolver(EngineBuilder engineBuilder) {
    if (engineBuilder.piston == null) {
      engineBuilder.piston = new PistonBuilder();
    }
    return engineBuilder.piston;
  }

  // TODO: maybe we just enforce that builders cannot have null properties for
  // other non primitives (i.e. for buildable stuff)
  // Then we can skip the resolving stuff and actually just do
  // car.engine.piston.colour = 'green'
  final carBuilder = new CarBuilder();
  final engineBuilder = engineResolver(carBuilder);
  final pistonBuilder = pistonResolver(engineBuilder);

//
//
//  if (carBuilder.engine == null) {
//    carBuilder.engine = new EngineBuilder();
//  }
//  final engineBuilder = carBuilder.engine;
//
//  if (engineBuilder.piston == null) {
//    engineBuilder.piston = new PistonBuilder();
//  }
//  final pistonBuilder = engineBuilder.piston;

  pistonBuilder.colour = 'green';


}



resolveSegment(StringSink sink, ValueClass vc, BuiltList<String> paths) {
  // TODO: handle end segment
  final segment = paths.first;
  final remainder = paths.sublist(1);
  final property = vc.properties.firstWhere((p) => p.name == segment);
  final propertyTypeName = property.type.name;

  sink.writeln('''
  final b = new ${vc.name}Builder();
  if (b.$segment == null) {
    b.$segment = new ${propertyTypeName}Builder();
  }

  ''');
}