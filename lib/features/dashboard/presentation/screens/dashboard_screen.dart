import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_purchase_app/common/widgets/custom_snackbar_widget.dart';
import 'package:material_purchase_app/common/widgets/custom_textfield_widget.dart';
import 'package:material_purchase_app/core/di/dependency_injection.dart';
import 'package:material_purchase_app/core/extentions/go_router_extension.dart';
import 'package:material_purchase_app/core/navigation/routes.dart';
import 'package:material_purchase_app/core/theme/style.dart';
import 'package:material_purchase_app/core/theme/theme.dart';
import 'package:material_purchase_app/features/authentication/presentation/business_logic/authentication_bloc/authentication_bloc.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/material_purchase_entity.dart';
import 'package:material_purchase_app/features/dashboard/presentation/business_logic/purchase_bloc/purchase_bloc.dart';
import 'package:material_purchase_app/features/dashboard/presentation/widgets/purchase_add_dialog_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();
  List<DataEntity> purchaseData = [];
  MaterialPurchaseEntity materialPurchaseEntity = MaterialPurchaseEntity();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<PurchaseBloc>().add(GetPurchaseDataEvent(page: 1));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
        if(materialPurchaseEntity.materialPurchaseList?.nextPageUrl != null
            && materialPurchaseEntity.materialPurchaseList?.nextPageUrl != ''){
          context.read<PurchaseBloc>().add(GetPurchaseDataEvent(
            page: (materialPurchaseEntity.materialPurchaseList?.currentPage ?? 0) + 1,
          ));
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    sl<PurchaseBloc>().close();
    super.dispose();
  }

  bool _isMenuOpen = false;

  void _showBlurEffect() {
    if(mounted) {
      _isMenuOpen = true;
      setState(() {});
    }
  }

  void _hideBlurEffect() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if(mounted) {
        _isMenuOpen = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const PurchaseAddDialogWidget(),
          );
        },
        child: Icon(Icons.add_circle),
      ),
      body: Stack(children: [
        RefreshIndicator(
          onRefresh: () async {
            context.read<PurchaseBloc>().add(GetPurchaseDataEvent(page: 1));
            purchaseData.clear();
            materialPurchaseEntity = MaterialPurchaseEntity();
          },
          child: Scrollbar(
            controller: _scrollController,
            radius: const Radius.circular(10),
            thickness: 5,
            interactive: true,
            child: CustomScrollView(controller: _scrollController, slivers: [

              SliverAppBar(
                pinned: true,
                backgroundColor: context.color.scaffoldBackground,
                centerTitle: true,
                title: const Text('Material Purchase'),
                actions: [
                  PopupMenuButton(
                    onOpened: _showBlurEffect,
                    onCanceled: _hideBlurEffect,
                    onSelected: (value) => _hideBlurEffect(),
                    color: context.color.primary,
                    iconColor: context.color.primary,
                    icon: const Icon(Icons.more_vert_sharp),
                    padding: EdgeInsets.all(2),
                    menuPadding: EdgeInsets.all(2),
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          context.pushNamedAndRemoveUntil(Routes.login);
                          context.read<AuthenticationBloc>().add(LogoutRequested());
                        },
                        padding: EdgeInsets.zero,
                        height: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.color.primary,
                          ),
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.logout, color: Colors.white),
                              const SizedBox(width: 10),
                              const Text('Logout', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomTextField(
                    controller: _searchController,
                    hintText: 'Item, Store, Runner\'s Name ...',
                    labelText: 'Search',
                    labelTextSize: 14,
                    style: fontRegular.copyWith(fontSize: 14),
                    hintStyle: fontRegular.copyWith(fontSize: 14),
                    showLabelText: true,
                    suffixChild: IconButton(
                      icon: Icon(Icons.search, size: 20, color: context.color.gray),
                      onPressed: () {
                        context.read<PurchaseBloc>().add(SearchPurchaseEvent(query: _searchController.text.trim()));
                        _searchController.clear();
                      },
                    ),
                    onChanged: (_) {
                      context.read<PurchaseBloc>().add(SearchPurchaseEvent(query: _searchController.text.trim()));
                    },
                    onSubmit: (_) {
                      context.read<PurchaseBloc>().add(SearchPurchaseEvent(query: _searchController.text.trim()));
                      _searchController.clear();
                    },
                  ),
                ),
              ),

              BlocConsumer<PurchaseBloc, PurchaseState>(
                listener: (context, state) {
                  if (state is PurchaseSessionOut) {
                    context.pushNamedAndRemoveUntil(Routes.login);
                  } else if (state is PurchaseNoInternet) {
                    showCustomSnackBar('No Internet Connection');
                  } else if (state is PurchaseError) {
                    showCustomSnackBar(state.message);
                  }
                },
                buildWhen: (previous, current) {
                  return current is PurchaseLoaded || current is PurchaseSearchLoaded;
                },
                builder: (context, state) {
                    if (state is PurchaseLoaded) {
                      materialPurchaseEntity = state.materialPurchaseEntity;
                      purchaseData.addAll(state.materialPurchaseEntity.materialPurchaseList?.data ?? []);
                    } else if (state is PurchaseSearchLoaded) {
                      purchaseData = state.searchResult;
                    }

                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: DataTableTheme(
                              data: DataTableThemeData(
                                headingRowHeight: 35, // Header row height
                                dataRowMinHeight: 35, // Minimum data row height
                                dataRowMaxHeight: 35, // Maximum data row height
                                headingRowColor: WidgetStateProperty.all(context.color.primary),
                                headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: DataTable(
                                    border: TableBorder(
                                      horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300), // Row separators
                                      verticalInside: BorderSide(width: 1, color: Colors.grey.shade400), // Column separators
                                      left: BorderSide(width: 1, color: Colors.grey.shade400), // Left border
                                      right: BorderSide(width: 1, color: Colors.grey.shade400), // Right border
                                      bottom: BorderSide(width: 1, color: Colors.grey.shade400), // Bottom border
                                    ),
                                    columns: const [
                                      DataColumn(label: Text('SL')),
                                      DataColumn(label: Text('Item')),
                                      DataColumn(label: Text('Store')),
                                      DataColumn(label: Text("Runner's Name")),
                                      DataColumn(label: Text('Amount')),
                                      DataColumn(label: Text('Card No')),
                                      DataColumn(label: Text('Date')),
                                    ],
                                    rows: List.generate(purchaseData.length, (index) {
                                      return DataRow(
                                        color: WidgetStateProperty.all(index.isEven ? Colors.white : Colors.grey.shade200),
                                        cells: [
                                          DataCell(Text('${index + 1}')),
                                          DataCell(Text(purchaseData[index].lineItemName ?? '')),
                                          DataCell(Text(purchaseData[index].store ?? '')),
                                          DataCell(Text(purchaseData[index].runnersName ?? '')),
                                          DataCell(Text('\$${purchaseData[index].amount ?? ''}')),
                                          DataCell(Text(purchaseData[index].cardNumber ?? '')),
                                          DataCell(Text(purchaseData[index].transactionDate?.split(' ').first ?? '')),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          if(materialPurchaseEntity.materialPurchaseList?.nextPageUrl != null
                              && materialPurchaseEntity.materialPurchaseList?.nextPageUrl != '')
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    );
                },
              ),

            ]),
          ),
        ),

        // Blurred background when the menu is open
        if (_isMenuOpen)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(color: Colors.black.withAlpha(20)), // Light dim effect
            ),
          ),
      ]),
    );
  }
}
