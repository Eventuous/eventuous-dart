import 'dart:async';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:build/build.dart';
import 'package:shell/shell.dart';

class ShellProcessBuilder implements PostProcessBuilder {
  ShellProcessBuilder(this.processes, {this.isEnabled = true});

  final bool isEnabled;
  final List<ShellProcess> processes;

  @override
  Iterable<String> get inputExtensions =>
      processes.map((p) => p.inputExtension);

  @override
  FutureOr<void> build(PostProcessBuildStep buildStep) async {
    if (!isEnabled) return null;
    var fs = const LocalFileSystem();
    for (var process in processes) {
      try {
        if (await process.ensure(buildStep, fs)) {
          try {
            await process.run(buildStep, fs);
          } on Exception catch (e) {
            log.severe('Run failed: $e');
          }
        }
      } on Exception catch (e) {
        log.severe('Ensure failed: $e');
      }
    }
  }

  @override
  String toString() {
    return 'eventuous_generator|shell_builder';
  }
}

abstract class ShellProcess {
  const ShellProcess(
    this.name,
    this.inputExtension,
    this.config, {
    this.ensureHint = 'command not found',
  });

  final String name;
  final String ensureHint;
  final String inputExtension;
  final Map<String, dynamic> config;

  Shell next() => Shell();

  Iterable<File> files(
    Directory dir,
    String match, {
    bool recursive = true,
  }) {
    final regex = RegExp(match);
    return dir
        .listSync(recursive: recursive)
        .whereType<File>()
        .where((f) => regex.hasMatch(f.path));
  }

  Future<void> mkdir(String path) async {
    final mkdir = await next().start(
      'mkdir',
      arguments: ['-p', path],
    );
    return mkdir.expectZeroExit();
  }

  Future<bool> ensure(
    PostProcessBuildStep buildStep,
    LocalFileSystem fs,
  ) async {
    final protoc = await Shell().start(name);
    try {
      await protoc.expectZeroExit();
      return true;
    } catch (e) {
      log.severe('Shell $runtimeType - $ensureHint');
      return false;
    }
  }

  Future<void> run(
    PostProcessBuildStep buildStep,
    LocalFileSystem fs,
  );
}
