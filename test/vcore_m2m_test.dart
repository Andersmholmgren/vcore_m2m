// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:test/test.dart';
import 'package:vcore_m2m/src/model/transform.dart';
import 'package:vcore_ecore/vcore_ecore.dart';
import 'package:vcore_ecore/vcore_ecore_meta.dart' as e;
import 'package:vcore/vcore.dart';

void main() {
  group('A group of tests', () {
    test('First Test', () {
      new ValueClassRelation(
          (ValueClassRelationBuilder b) => b..from = e.EClass);
    });
  });
}

foo() {
  VPackageRelationHelper pb;

  pb.relate(EClass).to(ValueClass).by((PropertyRelationHelper b) {
    b.relate((EClass f) => f.name).to((ValueClass t) => t.name);
    b.relate((EClass f) => f.abstract).to((ValueClass t) => t.isAbstract);

    b
        .relate((EClass f) => f.eStructuralFeatures)
        .to((ValueClass t) => t.properties);
  });
}

abstract class VPackageRelationHelper {
  VClassRelationHelper relate(Type type) => new _Z(type);
}

abstract class VClassRelationHelper {
  VClassRelationHelper2 to(Type toType);
}

abstract class VClassRelationHelper2 {
  by(updates(b));
}

class _Z<F, T> implements VClassRelationHelper, VClassRelationHelper2 {
  Type fromType;
  Type toType;

  _Z(this.fromType);

  VClassRelationHelper2 to(Type toType) {
    this.toType = toType;
    return this;
  }

  by(updates(PropertyRelationHelper<F, T> b));
}

abstract class PropertyRelationHelper<F, T> {
  relate(properties(F from));
}
