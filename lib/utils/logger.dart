import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final logger = Logger('FLUTTER_CHIME')
  ..level = kReleaseMode ? Level.WARNING : Level.ALL
  ..onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
      sequenceNumber: record.sequenceNumber,
    );
  });

StackTrace? castStackTrace(StackTrace? trace, [int lines = 3]) {
  if (trace != null) {
    final errors = trace.toString().split('\n');
    return StackTrace.fromString(
      errors.sublist(0, math.min(lines, errors.length)).join('\n'),
    );
  }
  return null;
}

extension StackTraceExt on StackTrace {
  StackTrace cast(int lines) {
    return castStackTrace(this, lines)!;
  }
}
