import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonapp/screens/address/cubit/address_cubit.dart';
import 'package:salonapp/screens/address/domain/model/address_model.dart';
import 'package:salonapp/screens/address/presentation/address_page.dart';
import 'package:salonapp/screens/cart/cubit/cart_cubit.dart';
import 'package:salonapp/screens/cart/domain/model/cart_model.dart';
import 'package:salonapp/utils/app_color.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

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
          "My Cart",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CartCubit, List<CartItem>>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.primaryButton.withOpacity(0.05),
                  ),
                  width: double.infinity,
                  height: 80,
                  margin: EdgeInsets.only(top: index == 0 ? 12 : 0, bottom: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                                image: CachedNetworkImageProvider(
                                  'https://i.pinimg.com/1200x/2e/e4/e9/2ee4e98652ad496be99c5d65749e78a2.jpg',
                                ),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // gradient: LinearGradient(
                            //     begin: Alignment.topCenter,
                            //     end: Alignment.bottomCenter,
                            //     colors: [
                            //       Colors.black.withOpacity(0.0),
                            //       Colors.black.withOpacity(0.5)
                            //     ]),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state[index].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '\u{20B9}${state[index].discountedPrice}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<CartCubit, List<CartItem>>(
                                    builder: (context, state) {
                                      final addedItems = state
                                          .where((element) =>
                                              element.id == state[index].id)
                                          .toList();

                                      return GestureDetector(
                                        onTap: () {
                                          if (addedItems.isEmpty) {
                                            final item = CartItem(
                                                id: state[index].id,
                                                name: state[index].name,
                                                quantity: 1,
                                                price: state[index]
                                                    .price
                                                    .toDouble(),
                                                discountedPrice: state[index]
                                                    .discountedPrice
                                                    .toDouble());
                                            context
                                                .read<CartCubit>()
                                                .addItem(item);
                                          }
                                        },
                                        child: Container(
                                          width: 60,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColor.primaryButton,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              addedItems.isNotEmpty
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<CartCubit>()
                                                            .removeItem(
                                                                state[index]
                                                                    .id);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 12,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              Text(
                                                addedItems.isNotEmpty
                                                    ? addedItems.first.quantity
                                                        .toString()
                                                    : 'ADD',
                                                style: TextStyle(
                                                    color:
                                                        AppColor.primaryButton,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              addedItems.isNotEmpty
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        final item = CartItem(
                                                            id: state[index].id,
                                                            name: state[index]
                                                                .name,
                                                            quantity: 1,
                                                            price: state[index]
                                                                .price
                                                                .toDouble(),
                                                            discountedPrice: state[
                                                                    index]
                                                                .discountedPrice
                                                                .toDouble());
                                                        context
                                                            .read<CartCubit>()
                                                            .addItem(item);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 12,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    '\u{20B9}${state[index].discountedPrice * state[index].quantity}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      )),
      bottomNavigationBar: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, state) {
          final totalAmountWithDiscount =
              context.read<CartCubit>().getTotalAmountWithDiscount();

          final totalAmountMrp = context.read<CartCubit>().getTotalAmountMrp();
          return BlocBuilder<AddressCubit, List<AddressModel>>(
            builder: (context, addressState) {
              final d = context
                  .read<AddressCubit>()
                  .state
                  .where((element) => element.isSelected)
                  .toList();

              final title = d.isNotEmpty ? d.first.title : "";

              final address = d.isNotEmpty ? d.first.address : "";
              return Container(
                height: d.isNotEmpty ? 160 : 124,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (d.isEmpty) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddressPage()));
                        }
                      },
                      child: Container(
                        height: d.isNotEmpty ? 88 : 52,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          color: AppColor.primaryButton.withOpacity(0.25),
                        ),
                        child: d.isNotEmpty
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            address,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddressPage()));
                                          },
                                          child: Container(
                                            height: 36,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        AppColor.primaryButton,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Change',
                                              style: TextStyle(
                                                  color: AppColor.primaryButton,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_rounded),
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 72,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(color: Color(0xffdddddd)))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                                totalAmountWithDiscount == totalAmountMrp
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\u{20B9}${totalAmountWithDiscount}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  totalAmountWithDiscount == totalAmountMrp
                                      ? SizedBox()
                                      : Text(
                                          '\u{20B9}${totalAmountMrp}',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.black45,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                              totalAmountWithDiscount == totalAmountMrp
                                  ? SizedBox()
                                  : SizedBox(
                                      height: 4,
                                    ),
                              totalAmountWithDiscount == totalAmountMrp
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        Text(
                                          'Save ',
                                          style: TextStyle(
                                              color: AppColor.successButton,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '\u{20B9}${totalAmountMrp - totalAmountWithDiscount}',
                                          style: TextStyle(
                                              color: AppColor.successButton,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              context.read<CartCubit>().createCart();
                            },
                            child: Container(
                              width: 140,
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColor.primaryButton,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                'Book Service',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
