import 'package:badges/badges.dart';
import 'package:bai29_flutter_app_bookstore/base/base_widget.dart';
import 'package:bai29_flutter_app_bookstore/data/remote/order_service.dart';
import 'package:bai29_flutter_app_bookstore/data/remote/product_service.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/order_repo.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/product_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/add_to_cart_event.dart';
import 'package:bai29_flutter_app_bookstore/module/home/home_bloc.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/rest_error.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/shopping_cart.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: "Home",
      di: [
        Provider<ProductService>(
          create: (context) => ProductService(),
        ),
        ProxyProvider<ProductService, ProductRepo>(
          update: (context, productService, _) =>
              ProductRepo(productService: productService),
        ),
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
      actions: [
        const ShoppingCartWidget(),
      ],
      child: const ProductListWidget(),
    );
  }
}

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => HomeBloc.getInstance(
        productRepo: Provider.of<ProductRepo>(context, listen: false),
        orderRepo: Provider.of<OrderRepo>(context, listen: false),
      ),
      dispose: (context, bloc) => bloc.dispose(),
      child: const CartWidget(),
    );
  }
}

class CartWidget extends StatefulWidget {
  const CartWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var bloc = context.read<HomeBloc>();
    bloc.getShoppingCartInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(
      builder: (context, bloc, child) => StreamProvider<ShoppingCart?>(
        initialData: null,
        create: (context) => bloc.shoppingCartStream,
        child: Consumer<ShoppingCart?>(
          builder: (context, cart, child) => Container(
            margin: const EdgeInsets.only(top: 15, right: 20),
            child: (cart == null || cart.orderId == "")
                ? const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/checkout",
                              arguments: cart.orderId)
                          .then((_) {
                        context.read<HomeBloc>().getShoppingCartInfo();
                      });
                    },
                    child: Badge(
                      badgeContent: Text(
                        "${cart.total}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => HomeBloc.getInstance(
        productRepo: Provider.of<ProductRepo>(context, listen: false),
        orderRepo: Provider.of<OrderRepo>(context, listen: false),
      ),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) => StreamProvider<Object?>(
          create: (context) => bloc.getProductList(),
          initialData: null,
          catchError: (context, error) {
            return error;
          },
          child: Consumer<Object?>(
            builder: (context, data, child) {
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

              data as List<Product>;
              return Container(
                color: AppColor.white,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => BookCard(
                    bloc: bloc,
                    product: (data)[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final HomeBloc bloc;
  final Product product;

  const BookCard({Key? key, required this.product, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(product.productImage),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
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
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${product.quantity} quyển",
                        style: TextStyle(color: AppColor.blue, fontSize: 17),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${product.price.toStringAsFixed(0)} vnđ",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  bloc.event.add(AddToCartEvent(product));
                                },
                                child: const Text("Buy now"),
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
