import 'package:material_purchase_app/common/widgets/custom_button_widget.dart';
import 'package:material_purchase_app/common/widgets/custom_image_widget.dart';
import 'package:material_purchase_app/common/widgets/custom_snackbar_widget.dart';
import 'package:material_purchase_app/common/widgets/custom_textfield_widget.dart';
import 'package:material_purchase_app/core/extentions/go_router_extension.dart';
import 'package:material_purchase_app/core/extentions/size_extension.dart';
import 'package:material_purchase_app/core/extra/validator.dart';
import 'package:material_purchase_app/core/navigation/routes.dart';
import 'package:material_purchase_app/core/theme/Images.dart';
import 'package:material_purchase_app/core/theme/style.dart';
import 'package:material_purchase_app/core/theme/theme.dart';
import 'package:material_purchase_app/features/authentication/presentation/business_logic/authentication_bloc/authentication_bloc.dart';
import 'package:material_purchase_app/features/authentication/presentation/business_logic/authentication_cubit/authentication_cubit.dart';
import 'package:material_purchase_app/features/authentication/presentation/widget/link_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/cached/preferences.dart';
import '../../../../core/cached/preferences_key.dart';
import '../../../../core/di/dependency_injection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final prefs = sl<Preferences>();
    _emailController = TextEditingController(text: prefs.getStringValue(keyName: PreferencesKey.kUserEmail));
    _passwordController = TextEditingController(text: prefs.getStringValue(keyName: PreferencesKey.kUserPass));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    sl<AuthenticationBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(children: [
           Container(
             height: context.height * 0.5,
             width: context.width,
             color: context.color.primary,
             child: CustomImage(image: Images.starBg),
           ),
            SizedBox(
              height: context.height * 0.5,
              width: context.width,
              // color: Colors.pink,
            ),
          ]),

          Positioned.fill(child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(padding: EdgeInsetsDirectional.symmetric(horizontal: 20), child: Column(children: [

              const SizedBox(height: 80),
              CustomImage(
                image: Images.appIcon,
                height: 30, width: 30,
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),

              Text('Sign in to your Account', style: fontBold.copyWith(
                fontSize: 32, color: context.color.white,
              ), textAlign: TextAlign.center),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              Text('Enter your email and password to log in', style: fontRegular.copyWith(
                fontSize: 12, color: context.color.white,
              ), textAlign: TextAlign.center),
              const SizedBox(height: Dimensions.paddingSizeExtraOverLarge),

              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.color.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: context.color.gray.withAlpha(80),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
                  child: Form(key: _formKey, child: Column(children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      labelText: 'Email',
                      inputType: TextInputType.emailAddress,
                      validator: (value)=> Validator.validateEmail(value),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      labelText: 'Password',
                      isPassword: true,
                      inputAction: TextInputAction.done,
                      validator: (value)=> Validator.validatePassword(value, null),
                    ),

                    Row(
                      children: [
                        BlocBuilder<AuthenticationCubit, AuthenticationCubitState>(
                          builder: (context, state) {
                            return Checkbox(
                              side: BorderSide(color: context.color.gray, width: 1.2),
                              visualDensity: VisualDensity.compact,
                              value: context.read<AuthenticationCubit>().isRememberMeChecked,
                              onChanged: (value) {
                                context.read<AuthenticationCubit>().toggleRememberMe(value ?? false);
                              },
                            );
                          },
                        ),
                        Text('Remember me', style: fontRegular.copyWith(fontSize: 12)),
                        Spacer(),

                        Transform.translate(
                          offset: const Offset(10, 0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text('Forgot password ?', style: fontMedium.copyWith(
                                color: context.color.primary, fontWeight: FontWeight.bold,
                                fontSize: 12,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      listenWhen: (previous, current) {
                        return current is AuthenticationLoginSuccess || current is AuthenticationFailure || current is AuthenticationNoInternet;
                      },
                      listener: (context, state) {
                        if (state is AuthenticationLoginSuccess) {
                          context.pushNamedAndRemoveUntil(Routes.homeTab);
                        } else if (state is AuthenticationFailure) {
                          showCustomSnackBar(state.message);
                        }else if (state is AuthenticationNoInternet) {
                          showCustomSnackBar('No internet connection');
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthenticationLoading) {
                          return const CircularProgressIndicator();
                        }
                        return CustomButton(
                          fontSize: 14,
                          buttonText: 'Log In',
                          onPressed: (){
                            print('Login button pressed');
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthenticationBloc>().add(LoginRequested(
                                email: _emailController.text.trim(), password: _passwordController.text.trim(),
                                isRememberMeChecked: context.read<AuthenticationCubit>().isRememberMeChecked,
                              ));
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    LinkText(
                      text: 'Don\'t have an account? ',
                      linkText: 'Sign up',
                      onTap: () {
                      },
                    ),
                  ])),
                ),
              ),

            ])),
          )),
        ],
      ),
    );
  }
}
