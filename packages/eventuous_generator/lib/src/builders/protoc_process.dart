import 'package:build/build.dart';
import 'package:file/local.dart';
import 'package:path/path.dart' as p;

import 'shell_process_builder.dart';

class ProtocProcess extends ShellProcess {
  ProtocProcess(
    Map<String, dynamic> config,
  ) : super(
          'protoc',
          'inference.json',
          config,
          ensureHint: "'protoc' not found. See "
              'https://grpc.io/docs/languages/dart/quickstart/#prerequisites '
              'for instructions on how to install protoc on your system',
        );

  static const protoSrcPath = 'proto_src_path';
  static const protoDstPath = 'proto_dst_path';
  static const protoImportPath = 'proto_import_path';

  String get srcPath => toProtoSrcPath(config);
  String get destPath => toProtoDstPath(config);
  String get importPath => toProtoImportPath(config);

  /// Get path for protobuf specification source
  String toProtoSrcPath(Map<String, Object?> config) =>
      config[protoSrcPath] as String? ?? '';

  /// Get destination path for protoc code generation
  /// (is relative to [ProtocProcess.protoSrcPath])
  String toProtoDstPath(Map<String, Object?> config) =>
      config[protoDstPath] as String? ??
      p.join(toProtoSrcPath(config), 'generated');

  /// Get protobuf import path
  /// (is relative to [ProtocProcess.protoSrcPath])
  String toProtoImportPath(Map<String, Object?> config) =>
      config[protoImportPath] as String? ?? 'protos';

  @override
  Future<void> run(
    PostProcessBuildStep buildStep,
    LocalFileSystem fs,
  ) async {
    log.info('Shell[$name]: Generating grpc to $destPath from $srcPath ...');
    await mkdir(destPath);
    final sources = findProtos(fs, srcPath);
    final imports = findProtos(fs, importPath);
    final protoc = await next().start(
      'protoc',
      arguments: [
        '--dart_out',
        'generate_kythe_info,grpc:$destPath',
        '--proto_path',
        importPath,
        ...imports,
        '--proto_path',
        srcPath,
        ...sources,
      ],
    );
    try {
      await protoc.expectZeroExit();
    } catch (e) {
      log.severe('Shell[$name]: ${await protoc.stderr.readAsString()}');
    }
  }

  Iterable<String> findProtos(LocalFileSystem fs, String path) {
    final prefix = path.endsWith('/') ? path : '$path/';
    return files(fs.directory(path), r'.*\.proto')
        .map((f) => f.path)
        .map((p) => p.startsWith(prefix) ? p.substring(prefix.length) : p);
  }
}
