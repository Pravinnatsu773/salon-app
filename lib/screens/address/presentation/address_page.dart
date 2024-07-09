import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salonapp/common_ui/custom_feild.dart';
import 'package:salonapp/screens/address/cubit/address_cubit.dart';
import 'package:salonapp/screens/address/domain/model/address_model.dart';
import 'package:salonapp/utils/app_color.dart';

class AddressPage extends StatefulWidget {
  AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();

  final _cityController = TextEditingController();

  final _postalCodeController = TextEditingController();
  @override
  void initState() {
    super.initState();

    context.read<AddressCubit>().getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: GestureDetector(child: Icon(Icons.arrow_back_rounded))),
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Address",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: BlocBuilder<AddressCubit, List<AddressModel>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  width: 24,
                  child: Checkbox(
                    value: state[index].isSelected,
                    onChanged: (value) {
                      context
                          .read<AddressCubit>()
                          .selectAddress(state[index].id, value ?? false);
                    },
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.top,
                title: Text(
                  state[index].title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: Text(
                  state[index].address,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showSheet();
          // context.read<AddressCubit>().createAddress(
          //     "Office", "fese ttsegrgs syerydr fertr 5rt44 trdyr6 tyt");
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColor.primaryButton),
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  showSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Address',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            CustomField(
              onChanged: (value) {
                setState(() {});
              },
              enabled: true,
              controller: _titleController,
              lableText: "Title",
            ),
            SizedBox(height: 16),
            CustomField(
              onChanged: (value) {
                setState(() {});
              },
              enabled: true,
              controller: _addressController,
              lableText: "Address Line 1",
            ),
            SizedBox(height: 16),
            CustomField(
              onChanged: (value) {
                setState(() {});
              },
              enabled: true,
              controller: _cityController,
              lableText: "City",
            ),
            SizedBox(height: 16),
            CustomField(
              onChanged: (value) {
                setState(() {});
              },
              enabled: true,
              controller: _postalCodeController,
              lableText: 'Postal Code',
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                context.read<AddressCubit>().createAddress(
                    _titleController.text,
                    "${_addressController.text} ${_cityController.text} ${_postalCodeController.text}"
                        .trim());

                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple),
                child: false
                    ? Center(
                        child: LoadingAnimationWidget.waveDots(
                        color: Colors.white,
                        size: 24,
                      ))
                    : Text(
                        'Save Address',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
