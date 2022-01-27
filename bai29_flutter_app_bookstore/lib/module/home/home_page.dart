import 'package:badges/badges.dart';
import 'package:bai29_flutter_app_bookstore/base/base_widget.dart';
import 'package:bai29_flutter_app_bookstore/data/remote/order_service.dart';
import 'package:bai29_flutter_app_bookstore/data/remote/product_service.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/order_repo.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/product_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/add_to_cart_event.dart';
import 'package:bai29_flutter_app_bookstore/module/home/home_bloc.dart';
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
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) => StreamProvider<AddToCartEvent>(
          initialData: AddToCartEvent(0),
          create: (context) => bloc.shoppingCartStream,
          child: Consumer<AddToCartEvent>(
            builder: (context, cart, child) => Container(
              margin: const EdgeInsets.only(top: 15, right: 20),
              child: Badge(
                badgeContent: Text(
                  "${cart.count}",
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
  final images = const [
    'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/i/m/image_176880.jpg',
    'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/9/7/9786047732524-1.jpg',
    'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/9/7/9786047732555.jpg',
    'https://cdn0.fahasa.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/8/9/8936037710327.jpg',
  ];

  const ProductListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => HomeBloc.getInstance(
        productRepo: Provider.of<ProductRepo>(context, listen: false),
        orderRepo: Provider.of<OrderRepo>(context, listen: false),
      ),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) => Container(
          color: AppColor.white,
          child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) => BookCard(
              bloc: bloc,
              imageUrl: images[index],
            ),
          ),
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final HomeBloc bloc;
  final String imageUrl;

  const BookCard({Key? key, required this.imageUrl, required this.bloc})
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
                child: Image.network(imageUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Học tiếng anh cùng Pokémon",
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "30 quyển",
                        style: TextStyle(color: AppColor.blue, fontSize: 17),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "100.000 vnđ",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  bloc.event.add(AddToCartEvent(0));
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
