import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/Utils/common_utils.dart';
import 'package:sales_data_dashboard/models/payment_model.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/party_details/store/party_details_screen_store.dart';
import 'package:sales_data_dashboard/screens/party_details/view/ledger_preview_screen.dart';
import 'package:sales_data_dashboard/screens/party_details/view/party_ledger.dart';
import 'package:sales_data_dashboard/widgets/custom_data_table.dart';

import '../../../models/party_model.dart';
import '../../payment/store/payment_screen_store.dart';

class ShowPartyInfoWidget extends StatelessWidget {
  const ShowPartyInfoWidget({
    super.key,
    required this.partyDetailsStore,
    required this.userDataStore,
    required this.paymentScreenStore,
  });

  final PartyDetailsStore partyDetailsStore;
  final UserDataStore userDataStore;
  final PaymentScreenStore paymentScreenStore;

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Transaction ID', key: 'transId', isSortable: true),
      TableColumn(
          label: 'Transaction Date', key: 'transDate', isSortable: true),
      TableColumn(label: 'Product Id', key: 'prodId', isSortable: true),
      TableColumn(label: 'Amount', key: 'amount', isSortable: true),
      TableColumn(
        label: 'Payment Type',
        key: 'paymentType',
      ),
      TableColumn(
        label: 'Payment Nature',
        key: 'paymentNature',
      ),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Observer(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => partyDetailsStore.togglePartyInfo(false),
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                  ),
                ),
                SizedBox(
                  width: 16.dp,
                ),
                Text(
                  'Party Information',
                  style: TextStyle(
                    fontSize: 20.dp,
                    fontWeight: FontWeight.bold,
                    color: const Color(
                      0xFF111827,
                    ),
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            height: 16.dp,
          ),
          Observer(builder: (context) {
            return InkWell(
              onTap: () {
                showLedgerPreview(
                  context,
                  partyDetailsStore.selectedParty!.value,
                  partyDetailsStore.paymentList,
                );
              },
              child: Container(
                padding: EdgeInsets.all(16.dp),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12.dp),
                ),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(children: [
                      _infoTile('Party ID',
                          partyDetailsStore.selectedParty?.value.id ?? 'N/A'),
                      _infoTile('Party Name',
                          partyDetailsStore.selectedParty?.value.name ?? 'N/A'),
                      _infoTile(
                          'Mobile Number',
                          partyDetailsStore.selectedParty?.value.mobileNumber ??
                              'N/A'),
                      _infoTile(
                          'GST Number',
                          partyDetailsStore.selectedParty?.value.gstNumber ??
                              'N/A'),
                    ]),
                    TableRow(children: [
                      SizedBox(height: 16.dp),
                      SizedBox(height: 16.dp),
                      SizedBox(height: 16.dp),
                      SizedBox(height: 16.dp),
                    ]),
                    TableRow(children: [
                      _infoTile(
                          'Party Type',
                          partyDetailsStore.selectedParty?.value.partyType ??
                              'N/A'),
                      SizedBox(height: 16.dp),
                      SizedBox(height: 16.dp),
                      SizedBox(height: 16.dp),
                    ]),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 16.dp),
          Text(
            'Party Ledger',
            style: TextStyle(
              fontSize: 18.dp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: 24.dp),
          // Observer(builder: (context) {
          //   return SizedBox(
          //     child: Row(
          //       children: [
          //         // IntrinsicWidth(
          //         //   child: CommonDropdown(
          //         //     label: 'Payment Type',
          //         //     value: partyDetailsStore.selectedTransType,
          //         //     onChanged: (p0) {
          //         //       partyDetailsStore.setSelectedTransType(p0!);
          //         //       partyDetailsStore.isInfoFilterAppliedCheck();
          //         //     },
          //         //     options: [
          //         //       PaymentTypeEnum.all.name,
          //         //       PaymentTypeEnum.cash.name,
          //         //       PaymentTypeEnum.cheque.name,
          //         //       PaymentTypeEnum.online.name,
          //         //     ],
          //         //   ),
          //         // ),
          //         // SizedBox(
          //         //   width: 12.dp,
          //         // ),
          //         // IntrinsicWidth(
          //         //   child: CommonDropdown(
          //         //     label: 'Payment Nature',
          //         //     value: partyDetailsStore.selectedTransStatus,
          //         //     onChanged: (p0) {
          //         //       partyDetailsStore.setSelectedTransStatus(p0!);
          //         //       partyDetailsStore.isInfoFilterAppliedCheck();
          //         //     },
          //         //     options: [
          //         //       PaymentNature.credit.name,
          //         //       PaymentNature.debit.name,
          //         //     ],
          //         //   ),
          //         // ),
          //         const Spacer(),
          //         // CustomImageButton(
          //         //   imagePath: 'assets/icons/excel_icon.png',
          //         //   text: 'Excel',
          //         //   borderColor: const Color(0xffE5E7EB),
          //         //   buttonColor: Colors.white,
          //         //   onClicked: () {},
          //         // ),
          //         // SizedBox(
          //         //   width: 12.dp,
          //         // ),
          //         Observer(builder: (context) {
          //           return Container(
          //             height: 30.dp,
          //             decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 border: Border.all(
          //                   color: partyDetailsStore.isInfoFilterApplied
          //                       ? Colors.red
          //                       : Colors.grey,
          //                 )),
          //             child: IconButton(
          //               splashColor: Colors.transparent,
          //               hoverColor: Colors.transparent,
          //               highlightColor: Colors.transparent,
          //               focusColor: Colors.transparent,
          //               padding: EdgeInsets.zero,
          //               onPressed: partyDetailsStore.clearInfoFilter,
          //               icon: Image.asset(
          //                 'assets/icons/cross_icon.png',
          //                 color: partyDetailsStore.isInfoFilterApplied
          //                     ? Colors.red
          //                     : Colors.grey,
          //                 width: 30.dp,
          //                 height: 30.dp,
          //               ),
          //               tooltip: 'Clear All Filters',
          //             ),
          //           );
          //         }),
          //       ],
          //     ),
          //   );
          // }),
          // SizedBox(height: 8.dp),
          Observer(builder: (context) {
            return Expanded(
              child: partyDetailsStore.paymentList.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/no_data_found.png',
                            width: 200.dp,
                            height: 200.dp,
                          ),
                          SizedBox(
                            height: 12.dp,
                          ),
                          Text(
                            'No Data Found',
                            style: TextStyle(
                                fontSize: 16.dp,
                                color: const Color(0xFF111827)),
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
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
                                      ? () =>
                                          paymentScreenStore.setSortKey(col.key)
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
                                          paymentScreenStore.sortKey == col.key)
                                        Icon(
                                          paymentScreenStore.sortAsc
                                              ? Icons.arrow_upward
                                              : Icons.arrow_downward,
                                          size: 14.dp,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            rows:
                                partyDetailsStore.paginatedInfoData.map((row) {
                              return DataRow(
                                cells: columns.map((col) {
                                  return DataCell(
                                    Text(
                                      getCellValue(
                                        col.key,
                                        row,
                                      ),
                                      style: TextStyle(
                                        fontSize: 14.dp,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
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
                  onPressed: partyDetailsStore.currentInfoTablePage > 0
                      ? () => partyDetailsStore.setCurrentInfoTablePage(
                          partyDetailsStore.currentInfoTablePage - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                    'Page ${partyDetailsStore.currentInfoTablePage + 1} of ${partyDetailsStore.totalinfoPages}'),
                IconButton(
                  onPressed: partyDetailsStore.currentInfoTablePage <
                          partyDetailsStore.totalinfoPages - 1
                      ? () => partyDetailsStore.setTotalinfoPages(
                          partyDetailsStore.currentInfoTablePage + 1)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  String getCellValue(String key, [PaymentModel? info]) {
    switch (key) {
      case 'transId':
        return info?.id ?? '';
      case 'transDate':
        return CommonUtils.formatDate(info?.date ?? DateTime.now());
      case 'prodId':
        return info?.stockDetails.itemId ?? 'N/A';
      case 'amount':
        return info?.amount.toString() ?? 'N/A';
      case 'paymentType':
        return info?.paymentType.name ?? 'N/A';
      case 'paymentNature':
        return info?.paymentNature.name ?? 'N/A';
      default:
        return '';
    }
  }

  Widget _infoTile(String title, String value) {
    return SizedBox(
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 4.dp),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showLedgerPreview(
    BuildContext context, Party party, List<PaymentModel> payments) {
  final ledgerMap = LedgerCalculator.calculateLedger(payments);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black,
    builder: (_) => LedgerPreviewScreen(
      party: party,
      ledgerMap: ledgerMap,
    ),
  );
}
