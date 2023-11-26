import 'dart:convert';

import '../utils/logger.dart';

typedef Json = Map<String, dynamic>;
typedef JsonList = List<dynamic>;

const emptyJson = <String, dynamic>{};

T? as<T>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  if (value == null) {
    return defaultValue;
  }

  // num 强转
  if (value is num) {
    dynamic result;
    if (T == double) {
      result = value.toDouble();
    } else if (T == int) {
      result = value.toInt() as T;
    } else if (T == BigInt) {
      result = BigInt.from(value) as T;
    } else if (T == bool) {
      result = (value != 0) as T;
    } else if (T == DateTime) {
      if (value < 10000000000) {
        value *= 1000;
      }
      result = DateTime.fromMillisecondsSinceEpoch(value.toInt()) as T;
    }
    if (result != null) {
      return result as T;
    }
  } else

  // String parse
  if (value is String) {
    if (value.isEmpty) {
      return defaultValue;
    }
    dynamic result;
    if (T == int) {
      result = int.tryParse(value);
    } else if (T == double) {
      result = double.tryParse(value);
    } else if (T == BigInt) {
      result = BigInt.tryParse(value);
    } else if (T == DateTime) {
      // DateTime.parse不支持 /
      if (value.contains('/')) {
        value = value.replaceAll('/', '-');
      }
      result = DateTime.tryParse(value)?.toLocal();
    } else if (T == bool) {
      return {'1', '-1', 'true', 'yes'}.contains(value.toLowerCase()) as T;
    } else if (T == JsonList || T == Json) {
      try {
        return jsonDecode(value) as T;
      } catch (e) {
        logger.warning(
          'Json decode error: $e',
          StackTrace.current.cast(3),
        );
      }
    } else {
      logger.warning(
        'Unsupported type cast from $value (${value.runtimeType}) to $T.',
        StackTrace.current.cast(3),
      );
      return defaultValue;
    }
    if (result == null) {
      logger.fine(
        'Cast $value(${value.runtimeType}) to $T failed',
        StackTrace.current.cast(3),
      );
    }
    return result as T? ?? defaultValue;
  }

  // String 强转
  if (T == String) {
    logger.info(
      'Force cast $value(${value.runtimeType}) to $T',
      StackTrace.current,
    );
    return '$value' as T;
  }
  logger.warning(
    'Type $T cast error: $value (${value.runtimeType})',
    StackTrace.current,
  );

  return defaultValue;
}
