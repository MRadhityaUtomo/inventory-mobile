import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inventory_mobile/models/item.dart';
import 'package:inventory_mobile/screens/item_detail.dart';
import 'package:inventory_mobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemListPage extends StatefulWidget {
    const ItemListPage({Key? key}) : super(key: key);

    @override
    _itemPageState createState() => _itemPageState();
}

class _itemPageState extends State<ItemListPage> {
 Future<List<Item>> fetchItem(CookieRequest request) async {
  final response = await request.postJson(
                                "http://127.0.0.1:8000/get-item/",
                                jsonEncode(<String, String>{
                                    'name':'bait',
                                }));

    // melakukan konversi data json menjadi object Product
    List<Item> list_product = [];
    for (var d in response) {
        if (d != null) {
            list_product.add(Item.fromJson(d));
        }
    }
    return list_product;
}

@override
Widget build(BuildContext context) {
     final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
        title: const Text('Item'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchItem(request),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data item.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.name}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.omen}"),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.space}"),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.description}"),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.amount}"),
                                    ElevatedButton(
                                        onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailItemPage(item: snapshot.data![index]),
                                          ),
                                        );
                                      },
                                      child: const Text('Item Details'),
                                    ),
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}