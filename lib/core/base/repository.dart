
import 'package:material_purchase_app/core/base/response_model.dart';
import 'package:material_purchase_app/core/error/failure.dart';
import 'package:material_purchase_app/core/extra/log.dart';

import '../di/dependency_injection.dart';

abstract base class Repository<T> {
  Future<T> request(
      Future<dynamic> Function() request, {
        Function(String?, {String? code}) onError = _defaultErrorHandler,
      }) async {
    try {
      return await request();
    }
    // on Failure catch (e, stackTrace) {
    //   final log = sl<Log>();
    //   log.error(title: 'Request', msg: e);
    //   log.error(title: 'Request stackTrace', msg: stackTrace);
    //   ErrorModel? error = ResponseModel.fromJson(e).error;
    //   return onError.call(error?.message, code: error?.code);
    // }
    catch (e, stackTrace) {
      final log = sl<Log>();
      log.error(title: 'Request', msg: e);
      log.error(title: 'Request stackTrace', msg: stackTrace);
      return onError.call('Something went wrong!');
    }
  }

  static Future _defaultErrorHandler(String? message, {String? code}) {
    return Future.error(message as Object);
  }
}
