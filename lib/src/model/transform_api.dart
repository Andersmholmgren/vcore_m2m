import 'transform_api_impl.dart' as impl;
import 'package:vcore_m2m/src/model/transform.dart';
import 'package:vcore/vcore.dart';

PackageRelation relateModels(
        Package from, Package to, updates(VPackageRelationHelper h)) =>
    impl.relateModels(from, to, updates);

abstract class VPackageRelationHelper {
  VClassRelationHelper/*<F, T>*/ relate/*<F, T>*/(Type type);
}

abstract class VClassRelationHelper<F, T> {
  VClassRelationHelper2<F, T> to(Type toType);
}

abstract class VClassRelationHelper2<F, T> {
  by(updates(PropertyRelationHelper<F, T> b));
}

abstract class PropertyRelationHelper<F, T> {
  PropertyRelationHelper2<F, T> relate(properties(F from));
}

abstract class PropertyRelationHelper2<F, T> {
  to(properties(T toType));
}

