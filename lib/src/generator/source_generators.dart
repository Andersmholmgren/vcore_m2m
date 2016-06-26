import 'package:option/option.dart';

typedef void SourceGenerator(StringSink sink);

abstract class _SourceGenerator {
  void generate(StringSink sink);
  void call(StringSink sink) {
    generate(sink);
  }
}

void commaSeparated(Iterable<SourceGenerator> generators, StringSink sink) {
  final sb = new StringBuffer();
  final joined = generators.map((pg) => pg(sb)).join(', ');
  sink.write(joined);
}

SourceGenerator commaSeparatedGenerator(Iterable<SourceGenerator> generators) {
  return (StringSink sink) {
    commaSeparated(generators, sink);
  };
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

class VariableBuilder {
  SourceGenerator _name, _type;
  bool includeFinal = true;

  void set name(String name) {
    _name = new StaticGenerator(name);
  }

  void set genName(SourceGenerator name) {
    _name = name;
  }

  void set type(String type) {
    _type = new StaticGenerator(type);
  }

  void set genType(SourceGenerator type) {
    _type = type;
  }

  VariableGenerator build() =>
      new VariableGenerator(_type, _name, includeFinal: includeFinal);
}

foo() {
  VariableBuilder vb;
  (vb
        ..name = 'foo'
        ..type = 'String')
      .build();

  dynamic fb;
  fb
    ..name = 'convert'
    ..returnType.name = 'String'
    ..parameters.add((b) {
      b
        ..name = 'num'
        ..type = 'int';
    })
    ..body((b) {
      b.writeln('_log.info("hola);');

      b.local((vb) {
        vb
          ..name = 'foo'
          ..type = 'num';
      });
    });
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
    commaSeparated(parameterGenerators, sink);
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

  ClassGenerator(this.nameGenerator,
      {this.isAbstract: false,
      this.interfaceGenerators: const [],
      this.propertyGenerators: const [],
      this.constructorGenerators: const [],
      this.methodGenerators: const [],
      SourceGenerator superClassGenerator})
      : this.superClassGenerator =
            new Option<SourceGenerator>(superClassGenerator);

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
      commaSeparated(interfaceGenerators, sink);
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
