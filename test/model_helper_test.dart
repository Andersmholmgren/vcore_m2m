import 'model/test_model.dart';
import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:vcore/vcore.dart';
import 'package:built_collection/built_collection.dart';

foo() {
  // resolve car.engine.capacity and set to 10
  ValueClassRelation vcr;
  var prs = vcr.propertyRelations;
  var pr = prs.first;
  pr.toPath;

  final cb = new CarBuilder();
  if (cb.engine == null) {
    cb.engine = new EngineBuilder();
  }
  final engineBuilder = cb.engine;
  engineBuilder.capacity = 10.0;

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