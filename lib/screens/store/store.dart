import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonapp/screens/store/cubit/store_data_cubit.dart';
import 'package:salonapp/utils/app_color.dart';
import 'package:salonapp/utils/helper.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  StoreType _selectedValue = StoreType.service;
  final _storeDataCubit = StoreDataCubit();
  @override
  void initState() {
    super.initState();

    _storeDataCubit.getServiceOrProduct(StoreType.service);
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButton<StoreType>(
            dropdownColor: Colors.white,
            underline: SizedBox(),
            value: _selectedValue,
            onChanged: (StoreType? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedValue = newValue;
                });
              }
            },
            items: StoreType.values.map((StoreType item) {
              return DropdownMenuItem<StoreType>(
                value: item,
                child: Text(
                  capitalizeFirst(item.name),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
            child: BlocBuilder<StoreDataCubit, StoreDataState>(
                bloc: _storeDataCubit,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case StoreDataFetched:
                      final successState = state as StoreDataFetched;
                      return GridView.builder(
                        padding: EdgeInsets.all(10.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 200,
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24.0,
                          mainAxisSpacing: 24.0,
                        ),
                        itemCount: successState.data.length,
                        itemBuilder: (context, index) {
                          final service = successState.data[index];
                          return Column(
                            children: [
                              Container(
                                // width: 150,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          'https://img.freepik.com/free-photo/female-hairdresser-using-hairbrush-hair-dryer_329181-1929.jpg?size=626&ext=jpg&ga=GA1.1.1845240027.1705814115&semt=ais_user',
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                              ),
                                              Text(
                                                service.rating.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          service.discountedPrice != null
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      '\u{20B9}${service.price}',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      '\u{20B9}${service.discountedPrice}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  '\u{20B9}${service.price}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 16),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColor.primaryButton,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          'ADD',
                                          style: TextStyle(
                                              color: AppColor.primaryButton,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
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
