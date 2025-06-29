import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

import '../../../widgets/product_data_table.dart';
import '../../../widgets/stat_card_grid_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Map<String, dynamic>> gemProductList = [
    {
      'id': '1',
      'hsnCode': '7103',
      'prodName': 'Ruby',
      'size': 'Medium',
      'carat': '5',
      'rate': '12000',
      'amount': '60000',
      'availableQty': 3,
      'minimumStock': 5,
      'description': 'Deep red natural ruby',
    },
    {
      'id': '2',
      'hsnCode': '7104',
      'prodName': 'Sapphire',
      'size': 'Large',
      'carat': '7',
      'rate': '15000',
      'amount': '105000',
      'availableQty': 7,
      'minimumStock': 4,
      'description': 'Blue star sapphire, polished',
    },
    {
      'id': '3',
      'hsnCode': '7105',
      'prodName': 'Emerald',
      'size': 'Small',
      'carat': '3',
      'rate': '18000',
      'amount': '54000',
      'availableQty': 0,
      'minimumStock': 2,
      'description': 'Natural Colombian emerald',
    },
    {
      'id': '4',
      'hsnCode': '7106',
      'prodName': 'Topaz',
      'size': 'Medium',
      'carat': '6',
      'rate': '5000',
      'amount': '30000',
      'availableQty': 6,
      'minimumStock': 5,
      'description': 'Golden yellow topaz',
    },
    {
      'id': '5',
      'hsnCode': '7107',
      'prodName': 'Amethyst',
      'size': 'Free',
      'carat': '4',
      'rate': '3000',
      'amount': '12000',
      'availableQty': 1,
      'minimumStock': 3,
      'description': 'Violet-purple quartz gem',
    },
    {
      'id': '6',
      'hsnCode': '7108',
      'prodName': 'Aquamarine',
      'size': 'Large',
      'carat': '8',
      'rate': '8000',
      'amount': '64000',
      'availableQty': 8,
      'minimumStock': 5,
      'description': 'Ocean blue aquamarine crystal',
    },
    {
      'id': '7',
      'hsnCode': '7109',
      'prodName': 'Garnet',
      'size': 'Small',
      'carat': '2',
      'rate': '2500',
      'amount': '5000',
      'availableQty': 0,
      'minimumStock': 2,
      'description': 'Dark red garnet for healing',
    },
    {
      'id': '8',
      'hsnCode': '7110',
      'prodName': 'Opal',
      'size': 'Medium',
      'carat': '3',
      'rate': '7000',
      'amount': '21000',
      'availableQty': 4,
      'minimumStock': 4,
      'description': 'Milky opal with play of color',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          SizedBox(height: 20.dp),
          Row(
            children: [
              Expanded(
                child: StatCardGridWidget(
                  cards: [
                    StatCardModel(
                      title: "Total Items",
                      value: "120",
                      subtitle: "Total items in stock",
                      iconData: Icons.home,
                      gradientColors: [
                        const Color(0xffC084FC),
                        const Color(0xffA855F7),
                      ],
                    ),
                    StatCardModel(
                      title: "Low Stock Items",
                      value: "8",
                      subtitle: "Number of items that are running low",
                      iconData: Icons.home,
                      gradientColors: [
                        const Color(0xff60A5FA),
                        const Color(0xff3B82F6),
                      ],
                    ),
                    StatCardModel(
                      title: "In Stock Items",
                      value: "40",
                      subtitle: "Number of items past their expiration date",
                      iconData: Icons.home,
                      gradientColors: [
                        const Color(0xff4ADE80),
                        const Color(0xff22C55E),
                      ],
                    ),
                    StatCardModel(
                      title: "Out of Stock Items",
                      value: "15",
                      subtitle: "Count of items currently out of stock",
                      iconData: Icons.home,
                      gradientColors: [
                        const Color(0xffF87171),
                        const Color(0xffEF4444),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.dp),
          Expanded(
              child: ProductDataTable(
            data: gemProductList,
            onEdit: (product) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Edit ${product['prodName']}')),
              );
            },
            onDelete: (product) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Delete ${product['prodName']}')),
              );
            },
            onAddProduct: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add new product tapped')),
              );
            },
          )),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Product Management",
          style: TextStyle(
            color: const Color(0xff1F2937),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {},
        //   child: const Text(
        //     "Create an Invoice",
        //   ),
        // )
      ],
    );
  }
}
