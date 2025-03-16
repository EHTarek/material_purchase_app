import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_purchase_app/app_config.dart';
import 'package:material_purchase_app/common/widgets/custom_image_widget.dart';
import 'package:material_purchase_app/core/di/dependency_injection.dart';
import 'package:material_purchase_app/core/navigation/routes.dart';
import 'package:material_purchase_app/core/theme/Images.dart';
import 'package:material_purchase_app/core/theme/style.dart';
import 'package:material_purchase_app/core/theme/theme.dart';
import 'package:material_purchase_app/features/authentication/presentation/business_logic/authentication_cubit/authentication_cubit.dart';
import 'package:material_purchase_app/features/on_boarding/presentation/business_logic/splash_bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final prefs = sl<Preferences>();

  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(SplashEventFetch());
  }

  @override
  void dispose() {
    SplashBloc().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            navigateToDashboard();
          }
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            color: context.color.primary,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImage(image: Images.appIcon, height: 200),

              const SizedBox(height: Dimensions.paddingSizeLarge),
              Text(AppConfig.appName, style: fontBold.copyWith(
                fontSize: 24,
                color: context.color.primary,
              )),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToDashboard() async {
    bool isLoggedIn = await sl<AuthenticationCubit>().isUserLoggedIn();
    if(isLoggedIn) {
      context.pushReplacementNamed(Routes.homeTab);
    } else {
      context.pushReplacementNamed(Routes.login);
    }
  }
}
