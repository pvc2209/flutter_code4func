import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/base/base_widget.dart';
import 'package:bai29_flutter_app_bookstore/data/remote/order_service.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/order_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/confirm_order_event.dart';
import 'package:bai29_flutter_app_bookstore/event/pop_event.dart';
import 'package:bai29_flutter_app_bookstore/event/update_cart_event.dart';
import 'package:bai29_flutter_app_bookstore/module/checkout/checkout_bloc.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/order.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/rest_error.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/app_color.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: "Checkout",
      di: [
        Provider<OrderService>(
          create: (context) => OrderService(),
        ),
        ProxyProvider<OrderService, OrderRepo>(
          update: (context, orderService, _) =>
              OrderRepo(orderService: orderService),
        ),
      ],
      bloc: [],
      // ignore: prefer_const_literals_to_create_immutables

      child: const ShoppingCartInfoWidget(),
    );
  }
}

class ShoppingCartInfoWidget extends StatefulWidget {
  const ShoppingCartInfoWidget({Key? key}) : super(key: key);

  @override
  _ShoppingCartInfoWidgetState createState() => _ShoppingCartInfoWidgetState();
}

class _ShoppingCartInfoWidgetState extends State<ShoppingCartInfoWidget> {
  void handleEvent(BaseEvent event) {
    if (event is ShouldPopEvent) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    String orderId = ModalRoute.of(context)!.settings.arguments.toString();

    return Provider<CheckoutBloc>(
      create: (context) => CheckoutBloc(
        orderRepo: Provider.of<OrderRepo>(context, listen: false),
        orderId: orderId,
      ),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<CheckoutBloc>(
        builder: (context, bloc, child) => BlocListener<CheckoutBloc>(
          listener: handleEvent,
          child: ShoppingCart(orderId: orderId, bloc: bloc),
        ),
      ),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({
    Key? key,
    required this.orderId,
    required this.bloc,
  }) : super(key: key);

  final String orderId;
  final CheckoutBloc bloc;

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getOrderDetail(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Object?>(
      initialData: null,
      create: (context) => widget.bloc.orderStream,
      catchError: (context, err) {
        return err;
      },
      child: Consumer<Object?>(builder: (context, data, child) {
        if (data == null) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.yellow,
            ),
          );
        }

        if (data is RestError) {
          return Center(
            child: Text(
              data.message,
              style: const TextStyle(fontSize: 20),
            ),
          );
        }

        if (data is Order) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ProductListWidget(data.items),
              ),
              ConfirmInfoWidget(data.total),
            ],
          );
        }

        return Container();
      }),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  final List<Product> productList;

  const ProductListWidget(this.productList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CheckoutBloc>(context, listen: false);
    productList.sort((p1, p2) => p1.price.compareTo(p2.price));

    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) => CheckoutItem(productList[index], bloc),
    );
  }
}

class CheckoutItem extends StatelessWidget {
  final Product product;
  final CheckoutBloc bloc;

  const CheckoutItem(this.product, this.bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.0,
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ClipRRect(
                child: Image.network(product.productImage),
                borderRadius: BorderRadius.circular(10),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        "Giá: ${product.price.toStringAsFixed(0)} vnđ",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CartAction(product, bloc),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CartAction extends StatelessWidget {
  final Product product;
  final CheckoutBloc bloc;

  const CartAction(this.product, this.bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonCartAction(
          title: "+",
          onPressed: () {
            product.quantity += 1;
            bloc.event.add(UpdateCartEvent(product));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "${product.quantity}",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ButtonCartAction(
          title: "-",
          onPressed: () {
            if (product.quantity == 1) {
              return;
            }

            product.quantity -= 1;
            bloc.event.add(UpdateCartEvent(product));
          },
        ),
      ],
    );
  }
}

class ButtonCartAction extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const ButtonCartAction({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: ElevatedButton(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
      ),
    );
  }
}

class ConfirmInfoWidget extends StatelessWidget {
  final double total;

  const ConfirmInfoWidget(this.total, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutBloc>(
      builder: (context, bloc, child) => SizedBox(
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${total.toStringAsFixed(0)} vnđ",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                bloc.event.add(ConfirmOrderEvent());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: AppColor.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
