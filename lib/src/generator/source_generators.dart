import 'package:option/option.dart';

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

class GenericTypeGenerator implements SourceGenerator {
  final SourceGenerator typeGenerator;

  GenericTypeGenerator(this.typeGenerator);

  @override
  void generate(StringSink sink) {
    sink..write('<')..write(typeGenerator)..write('>');
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

class ClassGenerator extends SourceGenerator {
  final SourceGenerator nameGenerator;
  final bool isAbstract;

  final Option<SourceGenerator> superClassGenerator;

  final Iterable<SourceGenerator> interfaceGenerators,
      propertyGenerators,
      constructorGenerators,
      methodGenerators;

  ClassGenerator(
      this.nameGenerator,
      this.superClassGenerator,
      this.interfaceGenerators,
      this.propertyGenerators,
      this.constructorGenerators,
      this.methodGenerators,
      {this.isAbstract: false});

  @override
  void generate(StringSink sink) {
    if (isAbstract) sink.write('abstract ');

    sink.write('class ');
    nameGenerator.generate(sink);

    if (superClassGenerator is Some) {
      sink.write('extends ');
      superClassGenerator.get().generate(sink);
      sink.write(' ');
    }

    if (interfaceGenerators.isNotEmpty) {
      sink.write('implements ');

      final sb = new StringBuffer();
      final interfaces =
          interfaceGenerators.map((ig) => ig.generate(sb)).join(', ');
      sink.write(interfaces);
    }
    sink.writeln(' {');

    propertyGenerators.forEach((g) {
      g.generate(sink);
      sink.writeln(';');
    });

    constructorGenerators.forEach((g) {
      g.generate(sink);
      sink.writeln('');
    });

    methodGenerators.forEach((g) {
      g.generate(sink);
      sink.writeln('');
    });

    sink.writeln('}');
  }
}
