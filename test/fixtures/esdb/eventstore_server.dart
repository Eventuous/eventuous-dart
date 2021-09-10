import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';

abstract class EventStoreServer {
  EventStoreServer({
    required this.secure,
    required this.grpcPort,
    required this.imageTag,
    required this.gossipPort,
    required this.withTestData,
    required this.hostCertificatePath,
  });

  final bool secure;
  final int grpcPort;
  final int gossipPort;
  final String imageTag;
  final bool withTestData;
  final String hostCertificatePath;

  Future<void> start({bool Function(String)? isReady});
  Future<void> stop();
  void verifyCertificatesExist() {
    if (secure) {
      final certificateFiles = [
        p.join(hostCertificatePath, 'ca', 'ca.crt'),
        p.join(hostCertificatePath, 'ca', 'ca.key'),
        p.join(hostCertificatePath, 'node', 'node.crt'),
        p.join(hostCertificatePath, 'node', 'node.key'),
      ];

      for (var path in certificateFiles) {
        final file = File(path);
        if (!file.existsSync()) {
          print(
            '${file.parent} exists: ${file.parent.existsSync()}',
          );
          print(
            '${file.parent.path} exists: ${file.parent.parent.existsSync()}',
          );
          print(
            '${file.parent.parent.path} exists: ${file.parent.parent.parent.existsSync()}',
          );

          throw Exception(
            'Could not locate the certificates file ${file.absolute.path} needed '
            "to run EventStoreDB node. \nPlease run '. tool/gencert.sh test'"
            'from the repo root.',
          );
        }
      }
    }
  }
}
