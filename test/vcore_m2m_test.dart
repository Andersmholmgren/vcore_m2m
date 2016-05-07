// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:vcore/vcore.dart';
import 'package:vcore_ecore/vcore_ecore.dart';
import 'package:vcore_ecore/vcore_ecore_meta.dart' as e;
import 'package:vcore_m2m/src/model/transform.dart';
import 'package:vcore_m2m/src/model/transform_api.dart';
import 'package:vcore_m2m/vcore_m2m.dart';

void main() {
  group('A group of tests', () {
    test('First Test', () {
      new ValueClassRelation(
          (ValueClassRelationBuilder b) => b..from = e.EClass);
    });
  });
}

foo() {
  // TODO: relating ecore to ecore here :/
  final packageRelation = relateModels(e.vCoreModelPackage, e.vCoreModelPackage,
      (VPackageRelationHelper pb) {
    pb.relate(EClass).to(ValueClass).by((PropertyRelationHelper b) {
      b.relate((EClass f) => f.name).to((ValueClass t) => t.name);
      b.relate((EClass f) => f.abstract).to((ValueClass t) => t.isAbstract);

      b
          .relate((EClass f) => f.eStructuralFeatures)
          .to((ValueClass t) => t.properties);
    });

    /**
     * TODO: need to figure out how we would create instances of ecore model
     * Since we won't generate code directly from an ecore model then presumably
     * we need a dynamic instance model for ecore. i.e. like
     *
     * _properties[eReference.containment] = true
     *
     * where eReference.containment is representing the 'containment' property of eReference
     *
     * If we do that then EBoolean to bool should really end up as bool to bool somehow??
     * and we don't need to relate EBoolean to bool??? i.e. runtimeType both bool???
     */
    pb.relate(EBoolean).to(bool);
  });
}
