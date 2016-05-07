// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:test/test.dart';
import 'package:vcore_m2m/src/model/transform.dart';
import 'package:vcore_ecore/vcore_ecore.dart';
import 'package:vcore_ecore/vcore_ecore_meta.dart' as e;
import 'package:vcore/vcore.dart';
import 'package:built_collection/built_collection.dart';

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
}

abstract class VPackageRelationHelper {
  VClassRelationHelper relate(Type type) => new _VClassRelationHelper(type);
}

abstract class VClassRelationHelper {
  VClassRelationHelper2 to(Type toType);
}

abstract class VClassRelationHelper2 {
  by(updates(b));
}

class _VClassRelationHelper<F, T> implements VClassRelationHelper, VClassRelationHelper2 {
  Type fromType;
  Type toType;

  _VClassRelationHelper(this.fromType);

  VClassRelationHelper2 to(Type toType) {
    this.toType = toType;
    return this;
  }

  by(updates(PropertyRelationHelper<F, T> b));
}

abstract class PropertyRelationHelper<F, T> {
  PropertyRelationHelper2<T, F> relate(properties(F from));
}

abstract class PropertyRelationHelper2<F, T> {
  to(properties(T toType));
}

class _PropertyRelationHelper<F, T>
    implements PropertyRelationHelper<F, T>, PropertyRelationHelper2<F, T> {
  BuiltList<String> _fromPath;
  BuiltList<String> _toPath;

  @override
  PropertyRelationHelper2<F, T> relate(properties(F from)) {
    final capture = new PathExpressionCapturer();
    properties(capture as F);
    _fromPath = new BuiltList<String>(capture._segments);
    return this;
  }

  @override
  to(properties(T toType)) {
    final capture = new PathExpressionCapturer();
    properties(capture as T);
    _toPath = new BuiltList<String>(capture._segments);
  }
}

class PathExpressionCapturer {
  final List<Sting> _segments = <String>[];

  noSuchMethod(Invocation i) {
    if (!i.isGetter) {
      throw new ArgumentError('can only reference getters in path expressions');
    }
    _segments.add(i.memberName);
    return this;
  }
}
