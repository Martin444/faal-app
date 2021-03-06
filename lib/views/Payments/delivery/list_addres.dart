import 'package:faal/controllers/address_controller.dart';
import 'package:faal/controllers/order_controller.dart';
import 'package:faal/views/Payments/delivery/delivery_method.dart';
import 'package:faal/widgets/anim/delayed_reveal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/text_styles.dart';

class ListAddres extends StatefulWidget {
  const ListAddres({Key? key}) : super(key: key);

  @override
  State<ListAddres> createState() => _ListAddresState();
}

class _ListAddresState extends State<ListAddres> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (order) {
      return GetBuilder<AddressController>(
        builder: (_) {
          if (_.myAddresses.isEmpty) {
            return SizedBox(
              height: Get.height * 0.44,
              child: Container(
                child: Text(
                  'Aun no haz agregado ninguna dirección',
                  style: titleAppBar,
                ),
              ),
            );
          }

          return SizedBox(
            height: Get.height * 0.44,
            child: ListView.builder(
              itemCount: _.myAddresses.length,
              itemBuilder: (context, index) {
                return DelayedReveal(
                  delay: Duration(milliseconds: index * 300),
                  child: DeliveryTile(
                    selected: order.isEqualAddres(_.myAddresses[index]),
                    brand: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_.myAddresses[index].address}',
                          style: order.isEqualAddres(_.myAddresses[index])
                              ? titleAppBarWithe
                              : titleAppBar,
                        ),
                        Text(
                          '${_.myAddresses[index].codepostal}',
                          style: order.isEqualAddres(_.myAddresses[index])
                              ? titleAppBarWithe
                              : titleAppBar,
                        ),
                      ],
                    ),
                    onTaper: () {
                      order.selectMyAddress(_.myAddresses[index]);
                    },
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }
}
