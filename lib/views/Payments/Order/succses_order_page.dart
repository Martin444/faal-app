import 'package:faal/utils/styles_context.dart';
import 'package:faal/utils/text_styles.dart';
import 'package:faal/views/Payments/Order/qr_viewer.dart';
import 'package:faal/views/Payments/Order/widget/pr_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Models/order_model.dart';
import '../../../controllers/order_controller.dart';
import '../../../widgets/button_primary.dart';

// ignore: must_be_immutable
class SuccesOrderPage extends StatefulWidget {
  OrderModel? order;

  SuccesOrderPage({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SuccesOrderPageState createState() => _SuccesOrderPageState();
}

class _SuccesOrderPageState extends State<SuccesOrderPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        getEstafeta() {
          return widget.order!.deliveryType != 'estafeta';
        }

        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: systemDart,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              '¡Gracias por tu compra!',
              style: titleAppBar,
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            height: Get.height - 100,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Articulo:',
                      style: titleDetail,
                    ),
                    ProductAr(
                      detail: widget.order!.products![0],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Datos de compra:',
                      style: titleDetail,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'N° de pedido: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.order!.id!.substring(30),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Envío: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              getEstafeta()
                                  ? Text(
                                      '${widget.order!.deliveryType}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/estafeta.png',
                                      height: 18,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Dirección: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${widget.order!.deliveryAddress}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Pago: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    getEstafeta()
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: QrViewerData(
                                orde: widget.order,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: ',
                                style: titleProduct,
                              ),
                              Text(
                                '${widget.order!.amount} MXN',
                                style: titleProduct,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    ButtonPrimary(
                      title: 'Finalizar',
                      onPressed: () {
                        // _.newOrder();
                        Get.back();
                      },
                      load: _.isLoadingOrder,
                      disabled: _.isLoadingOrder,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}