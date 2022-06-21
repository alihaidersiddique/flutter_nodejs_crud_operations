import 'package:flutter/material.dart';
import 'package:flutter_nodejs_crud_operations/api_service.dart';
import 'package:flutter_nodejs_crud_operations/models/product_model.dart';
import 'package:flutter_nodejs_crud_operations/product_item.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel> products = List<ProductModel>.empty(growable: true);
  bool isAPICallProcess = false;

  @override
  void initState() {
    super.initState();

    // products.add(
    //   ProductModel(
    //     id: "1",
    //     productName: "Cake",
    //     productImage:
    //         "https://images.unsplash.com/photo-1483695028939-5bb13f8648b0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzdHJ5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    //     productPrice: 650,
    //   ),
    // );

    // products.add(
    //   ProductModel(
    //     id: "2",
    //     productName: "Pastry",
    //     productImage:
    //         "https://images.unsplash.com/photo-1483695028939-5bb13f8648b0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzdHJ5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    //     productPrice: 50,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Node-JS Crud App"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        key: UniqueKey(),
        child: loadProducts(),
        inAsyncCall: isAPICallProcess,
        opacity: 0.3,
      ),
    );
  }

  Widget loadProducts() {
    return FutureBuilder(
      future: APIService.getProducts(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductModel>?> model,
      ) {
        if (model.hasData) {
          return productList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productList(products) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Add Product button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/add-product");
                },
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.green,
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text("Add Product"),
              ),
              const SizedBox(height: 10),
              // Products list
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    model: products[index],
                    onDelete: (ProductModel model) {
                      setState(() {
                        isAPICallProcess = true;
                      });

                      APIService.deleteProduct(model.id).then((response) {
                        setState(() {
                          isAPICallProcess = false;
                        });
                      });
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
