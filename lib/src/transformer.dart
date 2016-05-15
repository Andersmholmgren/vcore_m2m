import 'package:vcore_m2m/src/model/transform.dart';
import 'package:vcore/vcore.dart';

typedef Classifier ClassifierMirrorSystem(Type type);

class Transformer {
  final PackageRelation packageRelation;
  final ClassifierMirrorSystem sourceMirrorSystem;
//  final ClassifierMirrorSystem targetMirrorSystem;

  Transformer(this.packageRelation, this.sourceMirrorSystem);

  /*=T*/ transform/*<F, T>*/(/*=F*/ from) {
    final fromClassifier = sourceMirrorSystem(from.runtimeType);

    /**
     * TODO: need to do something much more efficient (probably code gen)
     * Lookup needs to support inheritance on both sides
     */
    final classifierRelation = packageRelation.classifierRelations
        .firstWhere((cr) => cr.from == fromClassifier);

//    classifierRelation.
  }
}
