import 'package:beritaku/model/newsmodel.dart';
import 'package:beritaku/ui/screens/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewsList extends StatelessWidget {

  List<NewsModel> news;

  NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: news==null ? 0 : news.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5,)]
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                Get.to(DetailPage(newsModel: news[index],));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                        child: Hero(
                            tag: news[index].newsId,
                            child: Image.network(
                              news[index].newsBanner,
                              height: 130,
                              width: 120,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                if(loadingProgress==null) return child;
                                return Container(
                                  height: 130,
                                  width: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                );
                              },
                            )
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )),
                        child: Text(news[index].newsCategory.categoryName, style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 7),
                          child: Text(
                            news[index].newsTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            news[index].newsContent,
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
