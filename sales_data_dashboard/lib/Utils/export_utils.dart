// import 'dart:io';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:excel/excel.dart';
// import 'package:file_saver/file_saver.dart';
// import 'package:path_provider/path_provider.dart';

// Future<void> exportToPDF(
//     List<Map<String, dynamic>> data, List<String> headers) async {
//   final pdf = pw.Document();
//   pdf.addPage(
//     pw.Page(
//       build: (context) => pw.TableHelper.fromTextArray(
//         headers: headers,
//         data: data
//             .map((e) => headers.map((h) => e[h]?.toString() ?? '').toList())
//             .toList(),
//       ),
//     ),
//   );
//   final bytes = await pdf.save();
//   final dir = await getTemporaryDirectory();
//   final file = File('${dir.path}/customer_data.pdf');
//   await file.writeAsBytes(bytes);
//   await FileSaver.instance.saveFile(
//     bytes: bytes,
//     mimeType: MimeType.pdf,
//     name: 'customer_data_pdf',
//   );
// }

// Future<void> exportToExcel(
//     List<Map<String, dynamic>> data, List<String> headers) async {
//   final excel = Excel.createExcel();
//   final sheet = excel['Sheet1'];
//   sheet.appendRow(headers);
//   for (var row in data) {
//     sheet.appendRow(headers.map((h) => row[h]?.toString() ?? '').toList());
//   }
//   final fileBytes = excel.encode()!;
//   await FileSaver.instance.saveFile(
//       bytes: fileBytes,
//       mimeType: MimeType.microsoftExcel,
//       name: "customer_data_excel");
// }
