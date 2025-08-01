import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/screens/party_details/store/party_details_screen_store.dart';

class ShowPartyInfoWidget extends StatelessWidget {
  const ShowPartyInfoWidget({
    super.key,
    required this.partyDetailsStore,
  });

  final PartyDetailsStore partyDetailsStore;

  @override
  Widget build(BuildContext context) {
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
                  'Item Information',
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
            return Container(
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
                    _infoTile('Firm Type',
                        partyDetailsStore.selectedParty?.value.firm ?? 'N/A'),
                    SizedBox(height: 16.dp),
                    SizedBox(height: 16.dp),
                  ]),
                ],
              ),
            );
          }),
          SizedBox(height: 16.dp),
          Text(
            'Party History',
            style: TextStyle(
              fontSize: 18.dp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: 8.dp),
          // Observer(builder: (context) {
          //   return Expanded(
          //     child: SingleChildScrollView(
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: DataTable(
          //           showBottomBorder: false,
          //           headingRowColor: WidgetStateProperty.all(
          //             const Color(0xffF8FAFC),
          //           ),
          //           columns: columns.map((col) {
          //             return DataColumn(
          //               label: InkWell(
          //                 onTap: col.isSortable
          //                     ? () => invoiceStore.setSortKey(col.key)
          //                     : null,
          //                 child: Row(
          //                   children: [
          //                     Text(col.label),
          //                     if (col.isSortable &&
          //                         invoiceStore.sortKey == col.key)
          //                       Icon(
          //                         invoiceStore.sortAsc
          //                             ? Icons.arrow_upward
          //                             : Icons.arrow_downward,
          //                         size: 14.dp,
          //                       ),
          //                   ],
          //                 ),
          //               ),
          //             );
          //           }).toList(),
          //           rows: invoiceStore.paginatedData
          //               .where(
          //                   (data) => data.custName == widget.customer.custName)
          //               .map((row) {
          //             return DataRow(
          //               cells: columns.map((col) {
          //                 return DataCell(
          //                   Text(
          //                     _getFieldValue(row, col.key),
          //                   ),
          //                 );
          //               }).toList(),
          //             );
          //           }).toList(),
          //         ),
          //       ),
          //     ),
          //   );
          // }),
        ],
      ),
    );
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
