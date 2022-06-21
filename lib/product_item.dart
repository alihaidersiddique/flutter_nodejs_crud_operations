import 'package:flutter/material.dart';
import 'package:flutter_nodejs_crud_operations/models/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  final ProductModel? model;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: productWidget(context),
      ),
    );
  }

  Widget productWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Image.network(
            (model!.productImage == null || model!.productImage == "")
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                : model!.productImage!,
            height: 70,
            fit: BoxFit.scaleDown,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.productName!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Rs.${model!.productPrice}",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.edit,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/edit-product',
                          arguments: {'model': model},
                        );
                      },
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        onDelete!(model);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}