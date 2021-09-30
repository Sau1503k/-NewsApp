import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/article.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<Article> articles= new List<Article>();
  bool _loading=true;

  @override
  void initState() {
    getCategorynews();
    // TODO: implement initState
    super.initState();
  }
  getCategorynews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getCategorynews(widget.category);
    articles = newsClass.Categorynews;
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
        actions: [
          Opacity(
            opacity: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0),
              child: Icon(Icons.save),
            ),
          )
        ],
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
