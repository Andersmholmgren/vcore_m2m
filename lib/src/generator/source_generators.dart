abstract class SourceGenerator {
  final StringSink sink;

  SourceGenerator(this.sink);

  void generate();
}

class FunctionGenerator extends SourceGenerator {
  final SourceGenerator returnTypeGenerator, bodyGenerator;
  final Iterable<SourceGenerator> parameterGenerators;

  FunctionGenerator(StringSink sink, this.returnTypeGenerator,
      this.bodyGenerator, this.parameterGenerators)
      : super(sink);

  void generate() {

  }
}
