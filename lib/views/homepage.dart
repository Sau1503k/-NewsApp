import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/category_model.dart';
import 'package:newsapp/views/article_view.dart';
import 'package:newsapp/views/category_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categorie = new List<CategoryModel>();
  List<Article> articles = new List<Article>();
  bool _loading = true;

  @override
  void initState() {
    categorie = getcategoryModel();
    getnews();


    super.initState();
  }

  getnews() async {
    News newsClass = News();
    await newsClass.getnews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading?Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Container(

                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categorie.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        imageUrl: categorie[index].imageUrl,
                        categoryname: categorie[index].categoryName,
                      );
                    }),
              ),



              Container(
              height: MediaQuery.of(context).size.height,
                child: ListView.builder(scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BlogTile(
                          imageUrl: articles[index].urlToImage,
                          desc: articles[index].description,
                          title: articles[index].title,
                      url: articles[index].url,);
                    })
              )
            ],
          ),
        ),
      )
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryname;

  CategoryTile({this.imageUrl, this.categoryname});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(category: categoryname.toLowerCase(),)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(imageUrl:
                  imageUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                "${categoryname}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, desc, title,url;

  BlogTile(
      {@required this.imageUrl, @required this.desc, @required this.title,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ArticleView(BlogUrl: url);

        }));
      },
      child: Container(padding: EdgeInsets.only(top: 16),margin: EdgeInsets.only(bottom: 5),
        child: Column(
          children: [ClipRRect(borderRadius:BorderRadius.circular(15),child: Image.network(imageUrl)),
            SizedBox(height: 5,),
            Text(title,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5

            ),),
            SizedBox(height: 5,),
            Text(desc,
            style: TextStyle(
              color: Colors.black54
            ),)],
        ),
      ),
    );
  }
}
