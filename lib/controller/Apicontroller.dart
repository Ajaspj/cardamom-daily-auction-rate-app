import 'dart:convert';

import 'package:cardamomrate/model/productmodel.dart';
import 'package:http/http.dart' as http;

Future<List<CardamomData>> fetchCardamomData() async {
  final response = await http.get(Uri.parse(
      'https://tibinsunny-indianspices-api.onrender.com/cardamom/archieve'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((dynamic item) => CardamomData.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
