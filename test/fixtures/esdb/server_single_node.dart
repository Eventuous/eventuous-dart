import 'dart:io';

import 'package:docker_process/docker_process.dart';
import 'package:eventstore_client/eventstore_client.dart';
import 'package:logging/logging.dart';

import 'eventstore_server.dart';

class EventStoreServerSingleNode extends EventStoreServer {
  EventStoreServerSingleNode({
    bool secure = false,
    bool withTestData = false,
    String imageTag = ImageTags.LTS,
    int grpcPort = Defaults.GrpcPort,
    int gossipPort = Defaults.GossipPort,
    String hostCertificatePath = 'certs',
  }) : super(
          secure: secure,
          grpcPort: grpcPort,
          imageTag: imageTag,
          gossipPort: gossipPort,
          withTestData: withTestData,
          hostCertificatePath: hostCertificatePath,
        );

  final Logger logger = Logger('$EventStoreServerSingleNode');

  late DockerProcess _server;

  @override
  Future<void> start({
    bool enableGossip = false,
    bool Function(String)? isReady,
    bool? startSystemProjections,
    String runProjections = 'none',
  }) async {
    verifyCertificatesExist();
    final failures = <String>[];
    _server = await DockerProcess.start(
      dockerExecutable: 'docker',
      name: 'eventstore-client-dart-test',
      image: withTestData
          ? 'ghcr.io/eventstore/'
              'eventstore-client-grpc-testdata:$imageTag'
          : 'ghcr.io/eventstore/eventstore:$imageTag',
      ports: [
        '1113:1113/tcp',
        '1114:1114/tcp',
        '$grpcPort:2113/tcp',
        '$gossipPort:2114/tcp',
      ],
      environment: {
        'EVENTSTORE_LOG_LEVEL': 'Verbose',
        // Please note that the GossipOnSingleNode option has been deprecated
        // will be removed in version 21.10.0. The gossip endpoint is now
        // unconditionally available for any deployment topology.
        'EVENTSTORE_GOSSIP_ON_SINGLE_NODE': enableGossip ? 'True' : 'False',
        'EVENTSTORE_INSECURE': secure ? 'False' : 'True',
        if (withTestData)
          'EVENTSTORE_DB': '/data/integration-tests'
        else
          'EVENTSTORE_MEM_DB': 'True',
        if (secure) ...{
          'EVENTSTORE_CERTIFICATE_FILE': '/etc/eventstore/certs/node/node.crt',
          'EVENTSTORE_CERTIFICATE_PRIVATE_KEY_FILE':
              '/etc/eventstore/certs/node/node.key',
          'EVENTSTORE_TRUSTED_ROOT_CERTIFICATES_PATH':
              '/etc/eventstore/certs/ca',
        },
        'EVENTSTORE_LOG_HTTP_REQUESTS': 'True',
        'EVENTSTORE_RUN_PROJECTIONS': runProjections,
        if (startSystemProjections != null)
          'EVENTSTORE_START_SYSTEM_PROJECTIONS':
              startSystemProjections ? 'True' : 'False',
      },
      dockerArgs: secure
          ? [
              '--mount',
              'type=bind,source=${File(hostCertificatePath).absolute.path},target=/etc/eventstore/certs',
            ]
          : [],
      cleanup: true,
      readySignal: (line) {
        logger.info(line);
        if (line.contains('Error response from daemon')) {
          failures.add(line);
        }
        return failures.isNotEmpty || isReady == null
            ? line.contains('All components started for Instance')
            : isReady(line);
      },
    );
    if (failures.isNotEmpty) {
      throw Exception(failures.join('\n'));
    }
  }

  @override
  Future<void> stop() => _server.stop();
}
