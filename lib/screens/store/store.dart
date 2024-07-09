import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonapp/screens/cart/cubit/cart_cubit.dart';
import 'package:salonapp/screens/cart/domain/model/cart_model.dart';
import 'package:salonapp/screens/home/cubit/home_service_cubit.dart';
import 'package:salonapp/screens/store/cubit/store_data_cubit.dart';
import 'package:salonapp/utils/app_color.dart';
import 'package:salonapp/utils/helper.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> with SingleTickerProviderStateMixin {
  final _storeDataCubit = StoreDataCubit();
  // List<String> categories = ['Hair', 'Makeup', 'Massage', 'Nails', 'Skin'];
  int selectedCategoryIndex = 0;
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    context.read<StoreDataCubit>().getCategories();
    // _storeDataCubit.getCategories();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      print(controller.index);
    });

    context.read<StoreDataCubit>().getServiceOrProduct("");
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    var screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on screen width
    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 2;
    } else if (screenWidth < 900) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(controller: controller, tabs: [
          Tab(
            text: capitalizeFirst(StoreType.values[0].name),
          ),
          Tab(
            text: capitalizeFirst(StoreType.values[1].name),
          )
        ]),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: DropdownButton<StoreType>(
        //     dropdownColor: Colors.white,
        //     underline: SizedBox(),
        //     value: _selectedValue,
        //     onChanged: (StoreType? newValue) {
        //       if (newValue != null) {
        //         setState(() {
        //           _selectedValue = newValue;
        //         });
        //       }
        //     },
        //     items: StoreType.values.map((StoreType item) {
        //       return DropdownMenuItem<StoreType>(
        //         value: item,
        //         child: Text(
        //           capitalizeFirst(item.name),
        //           style: TextStyle(
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // ),
        BlocBuilder<StoreDataCubit, StoreDataState>(
          builder: (context, state) {
            final categories = context.read<StoreDataCubit>().categories;

            return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width,
                height: 32,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedCategoryIndex = index;

                        context
                            .read<StoreDataCubit>()
                            .getServiceOrProduct(categories[index].id);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: index == 0 ? 16 : 0, right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: index == selectedCategoryIndex
                                ? Colors.black
                                : Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          categories[index].text,
                          style: TextStyle(
                              fontSize: 12,
                              color: index == selectedCategoryIndex
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  },
                ));
          },
        ),
        Expanded(child: BlocBuilder<StoreDataCubit, StoreDataState>(
            builder: (context, state) {
          switch (state.runtimeType) {
            case StoreDataFetched:
              final successState = state as StoreDataFetched;
              final data = successState.data;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final service = data[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.primaryButton.withOpacity(0.05),
                      ),
                      width: double.infinity,
                      height: 120,
                      margin:
                          EdgeInsets.only(top: index == 0 ? 12 : 0, bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
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
                              padding: EdgeInsets.all(8),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.title,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Reload already in progress, ignoring request",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          service.discountedPrice != null
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      '\u{20B9}${service.discountedPrice}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      '\u{20B9}${service.price}',
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.8),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationColor:
                                                              Colors.black,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  '\u{20B9}${service.price}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                        ],
                                      ),
                                      BlocBuilder<CartCubit, List<CartItem>>(
                                        builder: (context, state) {
                                          final addedItems = state
                                              .where((element) =>
                                                  element.id == service.id)
                                              .toList();

                                          return GestureDetector(
                                            onTap: () {
                                              if (addedItems.isEmpty) {
                                                final item = CartItem(
                                                    id: service.id,
                                                    name: service.title,
                                                    quantity: 1,
                                                    price: service.price
                                                        .toDouble(),
                                                    discountedPrice: service
                                                            .discountedPrice
                                                            ?.toDouble() ??
                                                        service.price
                                                            .toDouble());
                                                context
                                                    .read<CartCubit>()
                                                    .addItem(item);
                                              }
                                            },
                                            child: Container(
                                              width: 70,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 6, horizontal: 8),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: AppColor
                                                          .primaryButton,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  addedItems.isNotEmpty
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    CartCubit>()
                                                                .removeItem(
                                                                    service.id);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 12,
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                  Text(
                                                    addedItems.isNotEmpty
                                                        ? addedItems
                                                            .first.quantity
                                                            .toString()
                                                        : 'ADD',
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .primaryButton,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  addedItems.isNotEmpty
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            final item = CartItem(
                                                                id: service.id,
                                                                name: service
                                                                    .title,
                                                                quantity: 1,
                                                                price: service
                                                                    .price
                                                                    .toDouble(),
                                                                discountedPrice: service
                                                                        .discountedPrice
                                                                        ?.toDouble() ??
                                                                    service
                                                                        .price
                                                                        .toDouble());
                                                            context
                                                                .read<
                                                                    CartCubit>()
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
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );

            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        })),
      ],
    );
  }
}
