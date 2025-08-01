import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/party_details/view/party_details_form_widget.dart';
import 'package:sales_data_dashboard/screens/party_details/view/show_party_info_widget.dart';
import '../../../models/firm_model.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/custom_image_button.dart';
import '../../../widgets/custom_searchbar.dart';
import '../../../widgets/normal_button.dart';
import '../../products/view/products_screen.dart';
import '../store/party_details_screen_store.dart';

final getIt = GetIt.instance;

class PartyDetailsScreen extends StatefulWidget {
  const PartyDetailsScreen({super.key});

  @override
  State<PartyDetailsScreen> createState() => _PartyDetailsScreenState();
}

class _PartyDetailsScreenState extends State<PartyDetailsScreen> {
  late PartyDetailsStore partyDetailsStore;
  late UserDataStore userDataStore;

  @override
  void initState() {
    super.initState();
    if (!getIt.isRegistered<UserDataStore>(
      instanceName: 'UserDataStore',
    )) {
      getIt.registerSingleton<UserDataStore>(UserDataStore(),
          instanceName: 'UserDataStore');
    }
    userDataStore = getIt<UserDataStore>(
      instanceName: 'UserDataStore',
    );
    if (!getIt.isRegistered<PartyDetailsStore>()) {
      getIt.registerFactory<PartyDetailsStore>(
          () => PartyDetailsStore(userDataStore: userDataStore));
    }
    partyDetailsStore = getIt<PartyDetailsStore>();
    partyDetailsStore.setPartiesList(userDataStore.partiesList);
    partyDetailsStore.calculateTotalPages();
  }

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Id', key: 'id'),
      TableColumn(label: 'Name', key: 'name', isSortable: true),
      TableColumn(label: 'Mobile Number', key: 'mobileNumber'),
      TableColumn(label: 'GST Number', key: 'gstNumber'),
      TableColumn(label: 'Party Type', key: 'partyType', isSortable: true),
      TableColumn(label: 'Firm', key: 'firm', isSortable: true),
      TableColumn(label: 'Actions', key: 'actions', isAction: true),
    ];
    return Observer(builder: (context) {
      return partyDetailsStore.showPartyInfo.value
          ? ShowPartyInfoWidget(
              partyDetailsStore: partyDetailsStore,
            )
          : Container(
              color: Colors.white,
              padding: EdgeInsets.all(24.dp),
              child: Column(
                children: [
                  Observer(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Party Details Management',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(
                              0xFF111827,
                            ),
                          ),
                        ),
                        IntrinsicWidth(
                          child: NormalButton(
                            text: 'Create New Customer',
                            onPressed: () => _openPartyForm(context),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 12.dp),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(
                      thickness: 1.dp,
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                  SizedBox(height: 24.dp),
                  Observer(builder: (context) {
                    return SizedBox(
                      child: Row(
                        children: [
                          IntrinsicWidth(
                            child: CommonDropdown(
                              label: 'Firm Type',
                              value: partyDetailsStore.selectedFilterFirm,
                              onChanged: (p0) {
                                partyDetailsStore.setSelectedFilterFirm(p0!);
                                partyDetailsStore.isFiltersApplied();
                              },
                              options: [
                                Firm.sahajanand.name,
                                Firm.harikrishnaEnterprise.name
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12.dp,
                          ),
                          IntrinsicWidth(
                            child: CommonDropdown(
                              label: 'Party Type',
                              value: partyDetailsStore.selectedFilterPartyType,
                              onChanged: (p0) {
                                partyDetailsStore
                                    .setSelectedFilterPartyType(p0!);
                                partyDetailsStore.isFiltersApplied();
                              },
                              options: [
                                PartyTypeEnum.agent.name,
                                PartyTypeEnum.company.name,
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12.dp,
                          ),
                          SizedBox(
                            width: 300.dp,
                            child: CustomSearchBar(
                              controller: partyDetailsStore.searchcontroller,
                              onChanged: (final value) {
                                partyDetailsStore.setSearchText(value);
                                partyDetailsStore.isFiltersApplied();
                                partyDetailsStore.calculateTotalPages();
                              },
                              hintText:
                                  'Search By Name, Mobile Number, GST Number',
                            ),
                          ),
                          const Spacer(),
                          CustomImageButton(
                            imagePath: 'assets/icons/pdf_icon.png',
                            text: 'PDF',
                            borderColor: const Color(0xffE5E7EB),
                            buttonColor: Colors.white,
                            onClicked: () {},
                            // onClicked: widget.onExportPDF,
                          ),
                          SizedBox(
                            width: 12.dp,
                          ),
                          CustomImageButton(
                            imagePath: 'assets/icons/excel_icon.png',
                            text: 'Excel',
                            borderColor: const Color(0xffE5E7EB),
                            buttonColor: Colors.white,
                            onClicked: () {},
                            // onClicked: widget.onExportPDF,
                          ),
                          SizedBox(
                            width: 12.dp,
                          ),
                          Container(
                            height: 30.dp,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: partyDetailsStore.isFilterApplied
                                      ? Colors.red
                                      : Colors.grey,
                                )),
                            child: IconButton(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              icon: Image.asset(
                                'assets/icons/cross_icon.png',
                                color: partyDetailsStore.isFilterApplied
                                    ? Colors.red
                                    : Colors.grey,
                                width: 30.dp,
                                height: 30.dp,
                              ),
                              tooltip: 'Clear All Filters',
                              onPressed: partyDetailsStore.clearAllFilters,
                              // onPressed: _clearAllFilters,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 12.dp),
                  Observer(builder: (context) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.dp),
                              border: Border.all(
                                color: const Color(0xFFE5E7EB),
                                width: 1.5.dp,
                              ),
                            ),
                            child: DataTable(
                              dividerThickness: 0.1.dp,
                              headingRowHeight: 48,
                              dataRowMinHeight: 48,
                              headingRowColor: WidgetStateProperty.all(
                                  const Color(0xFFF9FAFB)),
                              dataRowColor: WidgetStateProperty.resolveWith(
                                  (states) => Colors.white),
                              showBottomBorder: false,
                              columns: columns.map((col) {
                                return DataColumn(
                                  label: InkWell(
                                    onTap: col.isSortable
                                        ? () => partyDetailsStore
                                            .setSortKey(col.key)
                                        : null,
                                    child: Row(
                                      children: [
                                        Text(
                                          col.label,
                                          style: TextStyle(
                                            fontSize: 16.dp,
                                            color: const Color(
                                              0xFF4B5563,
                                            ),
                                          ),
                                        ),
                                        if (col.isSortable &&
                                            partyDetailsStore.sortKey ==
                                                col.key)
                                          Icon(
                                            partyDetailsStore.sortAsc
                                                ? Icons.arrow_upward
                                                : Icons.arrow_downward,
                                            size: 14.dp,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              rows: partyDetailsStore.paginatedData.map((row) {
                                return DataRow(
                                  cells: columns.map((col) {
                                    if (col.isAction) {
                                      return DataCell(Row(
                                        children: [
                                          IconButton(
                                            icon: Image.asset(
                                              'assets/icons/edit_icon.png',
                                            ),
                                            onPressed: () {
                                              _openPartyForm(
                                                context,
                                                row,
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Image.asset(
                                              'assets/icons/delete_icon.png',
                                            ),
                                            onPressed: () {
                                              _confirmDelete(context, row);
                                            },
                                          ),
                                        ],
                                      ));
                                    }
                                    return DataCell(
                                      Observer(builder: (context) {
                                        return InkWell(
                                          onTap: () {
                                            partyDetailsStore
                                                .setSelectedParty(row);
                                            partyDetailsStore
                                                .togglePartyInfo(true);
                                          },
                                          child: Text(
                                            _getCellValue(row, col.key),
                                            style: TextStyle(
                                              fontSize: 14.dp,
                                              color: const Color(0xFF111827),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  }).toList(),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  Observer(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: partyDetailsStore.currentTablePage > 0
                              ? () => partyDetailsStore.setCurrentPageIndex(
                                  partyDetailsStore.currentTablePage - 1)
                              : null,
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text(
                            'Page ${partyDetailsStore.currentTablePage + 1} of ${partyDetailsStore.totalPages}'),
                        IconButton(
                          onPressed: partyDetailsStore.currentTablePage <
                                  partyDetailsStore.totalPages - 1
                              ? () => partyDetailsStore.setCurrentPageIndex(
                                  partyDetailsStore.currentTablePage + 1)
                              : null,
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            );
    });
  }

  void _openPartyForm(BuildContext context, [Party? existingParty]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        // scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          existingParty != null ? 'Edit Customer' : 'Create Customer',
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w600,
            color: const Color(
              0xFF111827,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: PartyDetailsFormWidget(
            partyStore: partyDetailsStore,
            party: existingParty,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Party party) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          'Delete Invoice',
          style: TextStyle(
            fontSize: 20.dp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete invoice ${party.id}?',
              style: TextStyle(
                fontSize: 14.dp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A4A4A),
              ),
            ),
            SizedBox(
              height: 32.dp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(ctx),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFF3F4F6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.dp),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.dp,
                      horizontal: 16.dp,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14.dp,
                        fontWeight: FontWeight.w600,
                        color: const Color(
                          0xFF374151,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.dp,
                ),
                InkWell(
                  onTap: () {
                    partyDetailsStore
                        .deletePartyDetails(party.id)
                        .then((final onValue) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invoice ${party.id} deleted')),
                      );
                    });
                    Navigator.pop(ctx);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.dp),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.dp,
                      horizontal: 16.dp,
                    ),
                    child: Text(
                      'Yes, Delete',
                      style: TextStyle(
                        fontSize: 14.dp,
                        fontWeight: FontWeight.w700,
                        color: const Color(
                          0xFFFFFFFF,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getCellValue(Party party, String key) {
    switch (key) {
      case 'id':
        return party.id;
      case 'name':
        return party.name;
      case 'mobileNumber':
        return party.mobileNumber;
      case 'gstNumber':
        return party.gstNumber ?? '';
      case 'partyType':
        return party.partyType == PartyTypeEnum.agent.name
            ? 'Agent'
            : 'Company';
      case 'firm':
        return party.firm == Firm.sahajanand.name
            ? Firm.sahajanand.name
            : Firm.harikrishnaEnterprise.name;
      default:
        return '';
    }
  }
}
