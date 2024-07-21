import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/scrapDataPreovider.dart';

class ScrapData extends StatefulWidget {
  const ScrapData({super.key});

  @override
  State<ScrapData> createState() => _ScrapDataState();
}

class _ScrapDataState extends State<ScrapData> {


   ScrapView_Model? scrapView_Model;
 
 void initState() {
    // TODO: implement initState
    scrapView_Model = Provider.of<ScrapView_Model>(context, listen: false);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Scrap Data"),
          leading: 
            IconButton(onPressed: (){
              scrapView_Model!.WebViewScreen();

            }, icon: Icon(Icons.arrow_back_ios))
          
        ),

        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor: Colors.grey,
                color: Colors.grey[80],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child:
                        scrapView_Model!.imgUrl!=null?
                         Image.network(
                          "${scrapView_Model!.imgUrl}",
                          height: 300,
                          width: 300,
                        ):Text("No Data Found "),
                      ),
                       scrapView_Model!.title!=null?
                      Text(
                        "${scrapView_Model!.title}",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w300), 
                      ):
                      Text("Data not Found"),
                      SizedBox(
                        height: 10,
                      ),
                       // ignore: unnecessary_null_comparison
                       scrapView_Model!.price!=null?
                      Text(
                        "Price : ${scrapView_Model!.price}",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ):Text("data no found"),
                      SizedBox(
                        height: 10,
                      ),
                        scrapView_Model!.intrestPrice!=null?
                      Text(
                        "Intrest Price : ${scrapView_Model!.intrestPrice}",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ):Text(""),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
       
        //     ),

        );
 
  }
}