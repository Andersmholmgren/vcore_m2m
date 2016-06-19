abstract class SourceGenerator {
  void generate(StringSink sink);
}

class StaticGenerator implements SourceGenerator {
  final String content;

  StaticGenerator(this.content);

  @override
  void generate(StringSink sink) {
    sink.write(content);
  }
}

class VariableGenerator implements SourceGenerator {
  final SourceGenerator typeGenerator, nameGenerator;
  final bool includeFinal;

  VariableGenerator(this.typeGenerator, this.nameGenerator,
      {this.includeFinal: true});

  @override
  void generate(StringSink sink) {
    if (includeFinal) sink.write('final ');

    typeGenerator.generate(sink);
    sink.write(' ');
    nameGenerator.generate(sink);
    sink.write(';');
  }
}

class FunctionGenerator extends SourceGenerator {
  final SourceGenerator returnTypeGenerator,
      bodyGenerator,
      functionNameGenerator;
  final Iterable<SourceGenerator> parameterGenerators;

  FunctionGenerator(this.returnTypeGenerator, this.functionNameGenerator,
      this.parameterGenerators, this.bodyGenerator);

  FunctionGenerator.std(
      SourceGenerator returnTypeGenerator,
      String functionName,
      Iterable<SourceGenerator> parameterGenerators,
      SourceGenerator bodyGenerator)
      : this(returnTypeGenerator, new StaticGenerator(functionName),
            parameterGenerators, bodyGenerator);

  void generate(StringSink sink) {
    returnTypeGenerator.generate(sink);
    sink.write(' ');
    functionNameGenerator.generate(sink);
    sink.write('(');
    final sb = new StringBuffer();
    final params = parameterGenerators.map((pg) => pg.generate(sb)).join(', ');
    sink.write(params);
    sink.writeln(') {');
    bodyGenerator.generate(sink);
    sink.writeln('}');
  }
}
