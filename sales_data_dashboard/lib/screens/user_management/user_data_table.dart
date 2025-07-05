import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/models/customer_model.dart';

class UsersDataTable extends StatelessWidget {
  final List<CustomerModel> data;
  final void Function(CustomerModel) onEdit;
  final void Function(CustomerModel) onDelete;
  final VoidCallback onExportPDF;
  final VoidCallback onExportExcel;

  const UsersDataTable({
    Key? key,
    required this.data,
    required this.onEdit,
    required this.onDelete,
    required this.onExportPDF,
    required this.onExportExcel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: onExportPDF,
              icon: Icon(Icons.picture_as_pdf),
              label: Text('Export PDF'),
            ),
            SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: onExportExcel,
              icon: Icon(Icons.table_chart),
              label: Text('Export Excel'),
            ),
          ],
        ),
        SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Mobile')),
                DataColumn(label: Text('GST Number')),
                DataColumn(label: Text('User Type')),
                DataColumn(label: Text('Address')),
                DataColumn(label: Text('Actions')),
              ],
              rows: data.map((customer) {
                return DataRow(
                  cells: [
                    DataCell(Text(customer.id?.toString() ?? '-')),
                    DataCell(Text(customer.custName)),
                    DataCell(Text(customer.mobileNumber)),
                    DataCell(Text(customer.gstNumber)),
                    DataCell(Text(customer.usertype.name)),
                    DataCell(Text(customer.address ?? '-')),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => onEdit(customer),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => onDelete(customer),
                        ),
                      ],
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
