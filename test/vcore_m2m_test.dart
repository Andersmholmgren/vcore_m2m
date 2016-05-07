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
  final eClassToVClassRelation = relate(EClass).to(ValueClass).by((b) {
    b
        .relate((EClass a) => a.eStructuralFeatures)
        .to((ValueClass b) => b.properties);
  });
}

X relate(Type type) => new _Z(type);

abstract class X {
//  Type get fromType;
//  Type get toType;

  Y to(Type toType);
}

abstract class Y {
  by(updates(b));
}

class _Z implements X, Y {
  Type fromType;
  Type toType;

  _Z(this.fromType);

  Y to(Type toType) {
    this.toType = toType;
    return this;
  }

  by(updates(b));
}
