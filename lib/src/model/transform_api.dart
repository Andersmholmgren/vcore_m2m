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
