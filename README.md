# Material Purchase App

Material Purchase app with Flutter BloC and Clean Architecture.

## Screenshot

![1](https://res.cloudinary.com/dp3tzm2wz/image/upload/v1742152496/1_nq0cxx.png)
![2](https://res.cloudinary.com/dp3tzm2wz/image/upload/v1742152497/2_tonxq4.png)

## App Access

- **Login**: Use the following credentials to login:
    - Email: interview@gmail.com
    - Password: 12345678

## Technologies Used

- **Flutter**: 3.27.4 (Stable Channel)
- **Dart**: 3.6.2
- **BloC**: For state management
- **GoRouter**: For route management

## Project Structure
```
 lib
  ├─ app_config.dart
  ├─ common
  │  └─ widgets
  │     ├─ code_picker_widget.dart
  │     ├─ custom_button_widget.dart
  │     ├─ custom_image_widget.dart
  │     ├─ custom_snackbar_widget.dart
  │     └─ custom_textfield_widget.dart
  ├─ core
  │  ├─ api
  │  │  ├─ api_checker.dart
  │  │  ├─ api_client.dart
  │  │  └─ api_endpoints.dart
  │  ├─ base
  │  │  ├─ empty_param.dart
  │  │  ├─ repository.dart
  │  │  ├─ response_model.dart
  │  │  └─ use_case.dart
  │  ├─ cached
  │  │  ├─ preferences.dart
  │  │  └─ preferences_key.dart
  │  ├─ di
  │  │  ├─ dependency_injection.dart
  │  │  └─ parts
  │  │     ├─ blocs.dart
  │  │     ├─ core.dart
  │  │     ├─ data_sources.dart
  │  │     ├─ externals.dart
  │  │     ├─ repositories.dart
  │  │     ├─ services.dart
  │  │     └─ use_cases.dart
  │  ├─ error
  │  │  ├─ exception.dart
  │  │  └─ failure.dart
  │  ├─ extentions
  │  │  └─ go_router_extention.dart
  │  ├─ extra
  │  │  ├─ app_observer.dart
  │  │  ├─ enums.dart
  │  │  ├─ log.dart
  │  │  ├─ network_info.dart
  │  │  ├─ token_service.dart
  │  │  └─ validator.dart
  │  ├─ navigation
  │  │  ├─ parts
  │  │  │  ├─ authentication_routes.dart
  │  │  │  ├─ dashboard_routes.dart
  │  │  │  └─ on_boarding_routes.dart
  │  │  ├─ router.dart
  │  │  └─ routes.dart
  │  └─ theme
  │     ├─ app_theme.dart
  │     ├─ src
  │     │  ├─ part
  │     │  │  ├─ app_bar_theme.dart
  │     │  │  ├─ bottom_navigation_bar_theme_data.dart
  │     │  │  ├─ button_theme_data.dart
  │     │  │  ├─ dropdown_menu_theme_data.dart
  │     │  │  └─ input_decoration_theme.dart
  │     │  ├─ theme_data.dart
  │     │  └─ theme_extensions
  │     │     ├─ extensions.dart
  │     │     └─ src
  │     │        ├─ colors.dart
  │     │        └─ text_style.dart
  │     ├─ style.dart
  │     └─ theme.dart
  ├─ features
  │  ├─ authentication
  │  │  ├─ data
  │  │  │  ├─ data_source
  │  │  │  │  ├─ authentication_local_data_source.dart
  │  │  │  │  └─ authentication_remote_data_source.dart
  │  │  │  ├─ model
  │  │  │  │  ├─ login_model.dart
  │  │  │  │  └─ sign_up_model.dart
  │  │  │  └─ repository
  │  │  │     └─ authentication_repository_impl.dart
  │  │  ├─ domain
  │  │  │  ├─ entity
  │  │  │  │  ├─ login_entity.dart
  │  │  │  │  └─ sign_up_entity.dart
  │  │  │  ├─ repository
  │  │  │  │  └─ authentication_repository.dart
  │  │  │  └─ use_case
  │  │  │     ├─ authentication_use_case.dart
  │  │  │     └─ user_usecase.dart
  │  │  └─ presentation
  │  │     ├─ business_logic
  │  │     │  ├─ authentication_bloc
  │  │     │  │  ├─ authentication_bloc.dart
  │  │     │  │  ├─ authentication_event.dart
  │  │     │  │  └─ authentication_state.dart
  │  │     │  └─ authentication_cubit
  │  │     │     ├─ authentication_cubit.dart
  │  │     │     └─ authentication_state.dart
  │  │     ├─ screens
  │  │     │  ├─ login_screen.dart
  │  │     │  └─ registration_screen.dart
  │  │     └─ widget
  │  │        └─ link_text_widget.dart
  │  ├─ dashboard
  │  │  ├─ data
  │  │  │  ├─ data_source
  │  │  │  │  ├─ dashboard_local_data_source.dart
  │  │  │  │  └─ dashboard_remote_data_source.dart
  │  │  │  ├─ models
  │  │  │  │  ├─ material_purchase_model.dart
  │  │  │  └─ repositories
  │  │  │     └─ dashboard_repository_impl.dart
  │  │  ├─ domain
  │  │  │  ├─ entities
  │  │  │  │  ├─ material_purchase_entity.dart
  │  │  │  ├─ repositories
  │  │  │  │  └─ dashboard_repository.dart
  │  │  │  └─ use_cases
  │  │  │     └─ purchase_usecase.dart
  │  │  └─ presentation
  │  │     ├─ business_logic
  │  │     │  ├─ purchase_bloc
  │  │     │  │  ├─ purchase_bloc.dart
  │  │     │  │  ├─ purchase_event.dart
  │  │     │  │  └─ purchase_state.dart
  │  │     ├─ screens
  │  │     │  └─ dashboard_screen.dart
  │  │     └─ widgets
  │  │        ├─ purchase_add_dialog_widget.dart
  │  └─ on_boarding
  │     └─ presentation
  │        ├─ business_logic
  │        │  └─ splash_bloc
  │        │     ├─ splash_bloc.dart
  │        │     ├─ splash_event.dart
  │        │     └─ splash_state.dart
  │        └─ screens
  │           └─ splash_screen.dart
  └─ main.dart
```

## Installation

To run this app on your local machine, follow these steps:

1. Clone the repository:
```bash
  git clone https://github.com/EHTarek/material_purchase_app.git
```
2. Navigate to the project directory:
```bash
  cd material_purchase_app
```
3. Clean and get dependencies:
```bash
  flutter clean
```
```bash
  flutter pub get
```
4. Run the app:
```bash
  flutter run
```
