
import 'dart:developer';

import 'package:blog_news_api/util/constants.dart';
import 'package:http/http.dart' as http;

class Request {
  final String url;
  final dynamic body;
  final dynamic headers;

  Request({required this.url, this.body,this.headers});

  Future<http.Response> post() {
    return http.post(Uri.parse(urlBase+ url), headers: headers,body: body).timeout(Duration(minutes: 2),);
  }
  Future<http.Response> get() {
    return http.get(Uri.parse(urlBase + url),headers: headers).timeout(Duration(minutes: 2));
  }
}