import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonapp/screens/cart/cubit/cart_cubit.dart';
import 'package:salonapp/screens/cart/domain/model/cart_model.dart';
import 'package:salonapp/screens/home/domain/model/service_type_model.dart';
import 'package:salonapp/utils/app_color.dart';

class HorizontalProductserviceCardSection extends StatelessWidget {
  final headerText;
  final List<ServiceTypesModel> data;
  const HorizontalProductserviceCardSection(
      {super.key, this.headerText, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            headerText,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          height: 140,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final service = data[index];
              return Container(
                width: 220,
                height: 140,
                margin: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 18),
                child: Column(
                  children: [
                    Container(
                      width: 220,
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                              image: CachedNetworkImageProvider(
                                'https://i.pinimg.com/1200x/2e/e4/e9/2ee4e98652ad496be99c5d65749e78a2.jpg',
                              ),
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.5)
                              ]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              service.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            // SizedBox(
                            //   height: 2,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Icon(
                                    //       Icons.star,
                                    //       size: 14,
                                    //     ),
                                    //     Text(
                                    //       service.rating.toString(),
                                    //       style: TextStyle(
                                    //           color: Colors.white,
                                    //           fontSize: 14,
                                    //           fontWeight: FontWeight.normal),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 2,
                                    // ),
                                    service.discountedPrice != null
                                        ? Row(
                                            children: [
                                              Text(
                                                '\u{20B9}${service.discountedPrice}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                '\u{20B9}${service.price}',
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            '\u{20B9}${service.price}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
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
                                              price: service.price.toDouble(),
                                              discountedPrice: service
                                                      .discountedPrice
                                                      ?.toDouble() ??
                                                  service.price.toDouble());
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
                                                  ? addedItems.first.quantity
                                                      .toString()
                                                  : 'ADD',
                                              style: TextStyle(
                                                  color: AppColor.primaryButton,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            addedItems.isNotEmpty
                                                ? GestureDetector(
                                                    onTap: () {
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
        ),
      ],
    );
  }
}
