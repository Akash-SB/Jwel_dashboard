import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sales_data_dashboard/screens/party_details/store/party_details_screen_store.dart';

import '../../../widgets/common_dropdown.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/normal_button.dart';

class PartyDetailsFormWidget extends StatefulWidget {
  const PartyDetailsFormWidget({
    super.key,
    required this.partyStore,
  });
  final PartyDetailsStore partyStore;

  @override
  State<PartyDetailsFormWidget> createState() => _PartyDetailsFormWidgetState();
}

class _PartyDetailsFormWidgetState extends State<PartyDetailsFormWidget> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();

  String partyType = 'Agent';
  String firmType = 'Sahajanand';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(24.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        label: 'Id',
                        enabled: false,
                        initialValue: idController.text,
                      ),
                    ),
                    SizedBox(width: 16.dp),
                    Expanded(
                      child: CommonTextField(
                        label: 'Name',
                        controller: nameController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.dp),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        label: 'Address',
                        controller: addressController,
                      ),
                    ),
                    SizedBox(width: 16.dp),
                    Expanded(
                      child: CommonTextField(
                        label: 'Mobile Number',
                        controller: mobileController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.dp),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        label: 'GST Number',
                        controller: gstController,
                      ),
                    ),
                    SizedBox(width: 16.dp),
                    Expanded(
                      child: CommonDropdown(
                        label: 'Party Type',
                        options: [
                          PartyTypeEnum.agent.name,
                          PartyTypeEnum.company.name,
                        ],
                        onChanged: (final value) {
                          setState(() {
                            partyType = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16.dp),
                    Expanded(
                      child: CommonDropdown(
                        label: 'Firm Type',
                        options: [
                          Firm.sahajanand.name,
                          Firm.harikrishnaEnterprise.name,
                        ],
                        onChanged: (final value) {
                          setState(() {
                            firmType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.dp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IntrinsicWidth(
                      child: NormalButton(
                        text: 'Cancle',
                        textColor: const Color(0xFF374151),
                        filledColor: const Color(0xFFF3F4F6),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(
                      width: 16.dp,
                    ),
                    IntrinsicWidth(
                      child: NormalButton(
                        text: 'Create User',
                        onPressed: () {
                          final party = Party(
                              id: idController.text,
                              name: nameController.text,
                              address: addressController.text,
                              mobileNumber: mobileController.text,
                              partyType: partyType,
                              firm: firmType,
                              gstNumber: gstController.text.isEmpty
                                  ? null
                                  : gstController.text);
                          widget.partyStore.addParty(party);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
