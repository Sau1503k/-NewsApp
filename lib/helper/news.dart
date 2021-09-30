import 'dart:convert';

import 'package:newsapp/model/article.dart';
import 'package:http/http.dart'as http;

class News{
  List<Article> news=[];
  Future<void> getnews()async{
    // String url="https://newsapi.org/v2/top-headlines?country"
    //     "=in&category=business&apiKey=ef36b834010b46d8b21c47012d21bd32";
    String url="http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow."
        "com&sortBy=publishedAt&language=en&apiKey=ef36b834010b46d8b21c47012d21bd32";
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    if(jsondata["status"]=="ok"){
      jsondata["articles"].forEach((element){
        if(element["urlToImage"]!= null && element["description"]!=null){
          Article article= Article(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],

          );
          news.add(article);

        }
      });
    }
  }
}
class CategoryNewsClass{
  List<Article> Categorynews=[];
  Future<void> getCategorynews(String category)async{
    // String url="https://newsapi.org/v2/top-headlines?country"
    //     "=in&category=business&apiKey=ef36b834010b46d8b21c47012d21bd32";
    String url="http://newsapi.org/v2/top-headlines?"
        "country=in&category=$category&apiKey=ef36b834010b46d8b21c47012d21bd32";
    var response=await http.get(url);
    var jsondata=jsonDecode(response.body);
    if(jsondata["status"]=="ok"){
      jsondata["articles"].forEach((element){
        if(element["urlToImage"]!= null && element["description"]!=null){
          Article article= Article(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],

          );
          Categorynews.add(article);

        }
      });
    }
  }
}