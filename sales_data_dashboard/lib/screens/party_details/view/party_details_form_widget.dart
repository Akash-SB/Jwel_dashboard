import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    this.party,
    required this.partyStore,
  });
  final PartyDetailsStore partyStore;
  final Party? party;

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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final party = widget.party;
    if (party != null) {
      idController.text = party.id;
      nameController.text = party.name;
      addressController.text = party.address ?? '';
      mobileController.text = party.mobileNumber;
      gstController.text = party.gstNumber ?? '';
      widget.partyStore.selectedFormPartyType = party.partyType;
      widget.partyStore.selectedFormFirmType = party.firm;
    } else {
      idController.text = widget.partyStore.setPartyId(
        itemNameController.text,
        widget.partyStore.selectedFormPartyType,
      );
    }
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    addressController.dispose();
    mobileController.dispose();
    gstController.dispose();
    itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(24.dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Observer(builder: (context) {
                    return Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            label: 'Id',
                            enabled: false,
                            controller: idController,
                          ),
                        ),
                        SizedBox(width: 16.dp),
                        Expanded(
                          child: CommonTextField(
                            label: 'Name',
                            controller: nameController,
                            onChanged: (final value) {
                              idController.text = widget.partyStore.setPartyId(
                                  value,
                                  widget.partyStore.selectedFormPartyType);
                            },
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                      ],
                    );
                  }),
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
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                                  ? 'Required'
                                  : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.dp),
                  Observer(builder: (context) {
                    return Row(
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
                            value: widget.partyStore.selectedFormPartyType,
                            options: [
                              PartyTypeEnum.agent.name,
                              PartyTypeEnum.company.name,
                            ],
                            onChanged: (final value) {
                              widget.partyStore
                                  .setSelectedFormPartyType(value!);
                              idController.text = widget.partyStore.setPartyId(
                                nameController.text,
                                value,
                              );
                            },
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                        SizedBox(width: 16.dp),
                        Expanded(
                          child: CommonDropdown(
                            label: 'Firm Type',
                            value: widget.partyStore.selectedFormFirmType,
                            options: [
                              Firm.sahajanand.name,
                              Firm.harikrishnaEnterprise.name,
                            ],
                            onChanged: (final value) {
                              widget.partyStore.setSelectedFormFirmType(value!);
                            },
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Required'
                                    : null,
                          ),
                        ),
                      ],
                    );
                  }),
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
                      Observer(builder: (context) {
                        return IntrinsicWidth(
                          child: NormalButton(
                            text: widget.party != null
                                ? 'Update User'
                                : 'Create User',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final party = Party(
                                    id: idController.text,
                                    name: nameController.text,
                                    address: addressController.text,
                                    mobileNumber: mobileController.text,
                                    partyType:
                                        widget.partyStore.selectedFormPartyType,
                                    firm:
                                        widget.partyStore.selectedFormFirmType,
                                    gstNumber: gstController.text.isEmpty
                                        ? null
                                        : gstController.text);
                                if (widget.party != null) {
                                  widget.partyStore
                                      .updatePartyDetails(party)
                                      .then((final onValue) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Party ${party.id} updated')),
                                    );
                                    Navigator.pop(context);
                                  }).onError((error, stackTrace) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Something went wrong while updating party: ${widget.partyStore.errorMessage}')),
                                    );
                                  });
                                } else {
                                  widget.partyStore
                                      .addPartyDetails(party)
                                      .then((final onValue) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Party ${party.id} created')),
                                    );
                                    Navigator.pop(context);
                                  }).onError((error, stackTrace) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Something went wrong while creating party: ${widget.partyStore.errorMessage}')),
                                    );
                                  });
                                }
                              }
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
