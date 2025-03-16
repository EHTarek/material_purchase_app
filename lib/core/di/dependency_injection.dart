import 'package:material_purchase_app/core/api/api_client.dart';
import 'package:material_purchase_app/core/extra/network_info.dart';
import 'package:material_purchase_app/core/cached/preferences.dart';
import 'package:material_purchase_app/core/extra/token_service.dart';
import 'package:material_purchase_app/features/authentication/data/data_source/authentication_local_data_source.dart';
import 'package:material_purchase_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:material_purchase_app/features/authentication/domain/use_case/authentication_use_case.dart';
import 'package:material_purchase_app/features/authentication/domain/use_case/user_usecase.dart';
import 'package:material_purchase_app/features/authentication/presentation/business_logic/authentication_bloc/authentication_bloc.dart';
import 'package:material_purchase_app/features/authentication/presentation/business_logic/authentication_cubit/authentication_cubit.dart';
import 'package:material_purchase_app/features/dashboard/data/data_source/dashboard_local_data_source.dart';
import 'package:material_purchase_app/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:material_purchase_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:material_purchase_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:material_purchase_app/features/dashboard/domain/use_cases/cart_usecase.dart';
import 'package:material_purchase_app/features/dashboard/domain/use_cases/products_usecase.dart';
import 'package:material_purchase_app/features/dashboard/domain/use_cases/purchase_usecase.dart';
import 'package:material_purchase_app/features/dashboard/presentation/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:material_purchase_app/features/dashboard/presentation/business_logic/cart_cubit/cart_cubit.dart';
import 'package:material_purchase_app/core/extra/log.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:material_purchase_app/features/dashboard/presentation/business_logic/purchase_bloc/purchase_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/data_source/authentication_remote_data_source.dart';
import '../../features/authentication/data/repository/authentication_repository_impl.dart';

part 'parts/use_cases.dart';
part 'parts/repositories.dart';
part 'parts/data_sources.dart';
part 'parts/blocs.dart';
part 'parts/core.dart';
part 'parts/externals.dart';
part 'parts/services.dart';


GetIt sl = GetIt.instance;

void diInit() {
  ///! External
  _externals();

  ///! Core
  _core();

  ///! Service
  _services();

  ///! Use Case
  _useCases();

  ///! Repository
  _repositories();

  ///! Data Source
  _dataSources();

  ///! Blocs
  _blocs();
}
