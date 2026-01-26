import 'package:flutter/material.dart';
import 'movie_data.dart';
import 'movie_detail_page.dart';
import 'api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState(){
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{

  List<MovieData> movies = [];
  bool loading = true;
  String searchText = "";

  @override
  void initState(){
    super.initState();
    getMovies();
}

void getMovies() async{
  try{
  String url;

  if(searchText.isEmpty){
    url="${ApiKey.baseUrl}/movie/popular?api_key=${ApiKey.key}";
  }
  else{
    url="${ApiKey.baseUrl}/search/movie?api_key=${ApiKey.key}&query=$searchText";
  }
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        movies.clear();

      if (data["results"] != null) {
        for (var item in data["results"]) {
          movies.add(MovieData.fromJson(item));
        }
      }
      loading = false;
      });
    } else {
      print("API Error: ${response.statusCode}");
      setState(() {
        loading = false;
      });
    }

  } catch(e){
  print("Error fetching movies: $e");
  setState(() {
    loading = false;
  });
  }


 

}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text("Movies"),titleTextStyle: TextStyle(color: Colors.white),backgroundColor: const Color.fromARGB(255, 236, 16, 0),),
    body: Column(children: [
      Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Search Movies',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onChanged: (value){
            setState((){
            searchText=value;
            loading=true;});
            getMovies();
          },
        ),

      ),
      Expanded(
        child: loading
        ? Center(child: CircularProgressIndicator())
        :movies.isEmpty
        ? Center(child: Text("No movies found"))

        : ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context,index){

            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movies[index]),),
                );
              },
              
              child:Card(
                
                margin:EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: const Color.fromARGB(255, 254, 5, 5)),
                ),

                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children:[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                         child: movies[index].image != null
                          ? Image.network(
                              ApiKey.imageUrl +
                              movies[index].image!,
                              width: 80,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 80,
                              height: 120,
                              color: Colors.redAccent,
                              child: const Icon(
                                Icons.movie,
                                size: 40,
                              ),
                            ),
                        
                      ),

                      SizedBox(width:15),
                      
                      Expanded(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(movies[index].title,style:TextStyle(fontSize:18,fontWeight:FontWeight.bold),
                            maxLines:2,
                            overflow:TextOverflow.ellipsis),

                            Text(movies[index].description,style:TextStyle(fontSize:14),
                            maxLines:3,
                            overflow:TextOverflow.ellipsis,),
                            SizedBox(height: 8),

                            
                          ],
                        )
                      )

                    ]
                  ),
              ),
              ),
            );
          }
          ),
      ),
    ],
    ),
    );
  }


}