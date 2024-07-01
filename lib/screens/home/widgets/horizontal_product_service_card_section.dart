import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
          height: 220,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final service = data[index];
              return Container(
                width: 150,
                height: 120,
                margin: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
                child: Column(
                  children: [
                    Container(
                      width: 150,
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
                      height: 12,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontWeight: FontWeight.normal),
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
                                                    TextDecoration.lineThrough,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '\u{20B9}${service.discountedPrice}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        '\u{20B9}${service.price}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.primaryButton, width: 1),
                                  borderRadius: BorderRadius.circular(8)),
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
