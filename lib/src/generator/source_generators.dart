import 'package:option/option.dart';

typedef void SourceGenerator(StringSink sink);

abstract class _SourceGenerator {
  void generate(StringSink sink);
  void call(StringSink sink) {
    generate(sink);
  }
}

class StaticGenerator extends _SourceGenerator {
  final String content;

  StaticGenerator(this.content);

  @override
  void generate(StringSink sink) {
    sink.write(content);
  }
}

class GenericTypeGenerator extends _SourceGenerator {
  final SourceGenerator typeGenerator;

  GenericTypeGenerator(this.typeGenerator);

  @override
  void generate(StringSink sink) {
    sink..write('<')..write(typeGenerator)..write('>');
  }
}

class VariableGenerator extends _SourceGenerator {
  final SourceGenerator typeGenerator, nameGenerator;
  final bool includeFinal;

  VariableGenerator(this.typeGenerator, this.nameGenerator,
      {this.includeFinal: true});

  @override
  void generate(StringSink sink) {
    if (includeFinal) sink.write('final ');

    typeGenerator(sink);
    sink.write(' ');
    nameGenerator(sink);
    sink.write(';');
  }
}

class FunctionGenerator extends _SourceGenerator {
  final SourceGenerator returnTypeGenerator,
      bodyGenerator,
      functionNameGenerator;
  final Iterable<SourceGenerator> parameterGenerators;
  final bool useArrow;

  FunctionGenerator(this.returnTypeGenerator, this.functionNameGenerator,
      this.parameterGenerators, this.bodyGenerator,
      {this.useArrow: false});

  FunctionGenerator.std(
      SourceGenerator returnTypeGenerator,
      String functionName,
      Iterable<SourceGenerator> parameterGenerators,
      SourceGenerator bodyGenerator)
      : this(returnTypeGenerator, new StaticGenerator(functionName),
            parameterGenerators, bodyGenerator);

  void generate(StringSink sink) {
    returnTypeGenerator(sink);
    sink.write(' ');
    functionNameGenerator(sink);
    sink.write('(');
    final sb = new StringBuffer();
    final params = parameterGenerators.map((pg) => pg(sb)).join(', ');
    sink.write(params);
    sink.write(') ');
    if (useArrow)
      sink.writeln('=>');
    else
      sink.writeln('{');

    bodyGenerator(sink);
    sink.writeln('}');
  }
}

class ClassGenerator extends _SourceGenerator {
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
    nameGenerator(sink);

    if (superClassGenerator is Some) {
      sink.write('extends ');
      superClassGenerator.get()(sink);
      sink.write(' ');
    }

    if (interfaceGenerators.isNotEmpty) {
      sink.write('implements ');

      final sb = new StringBuffer();
      final interfaces = interfaceGenerators.map((ig) => ig(sb)).join(', ');
      sink.write(interfaces);
    }
    sink.writeln(' {');

    propertyGenerators.forEach((g) {
      g(sink);
      sink.writeln(';');
    });

    constructorGenerators.forEach((g) {
      g(sink);
      sink.writeln('');
    });

    methodGenerators.forEach((g) {
      g(sink);
      sink.writeln('');
    });

    sink.writeln('}');
  }
}
