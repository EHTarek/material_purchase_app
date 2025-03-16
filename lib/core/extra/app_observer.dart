import 'package:material_purchase_app/core/di/dependency_injection.dart';
import 'package:material_purchase_app/core/extra/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    final Log log = sl<Log>();
    log.blocObserver(
      title: change.toString(),
      msg: '${change.currentState} -> ${change.nextState}',
    );
  }
}
