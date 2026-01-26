import 'package:flutter/material.dart';
import 'movie_data.dart';
import 'api_key.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieData movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title,style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 236, 16, 0),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: [
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            child: Image.network(
            ApiKey.imageUrl + movie.image,
              height: MediaQuery.of(context).size.height*0.45,
              width:double.infinity,
              fit: BoxFit.cover,
            ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Padding(
                  padding: EdgeInsets.all(16.0),
                  child:Column(
                   
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                 
                  if(movie.rating>=7)
                   Text("Rating: ${movie.rating} (highly rated)",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 244, 46, 32)))
                  else
                    Text("Rating: ${movie.rating}",style:TextStyle(fontSize: 18)),
                  
                  SizedBox(height: 12),
                  Text("Release Date: ${movie.date}",style:TextStyle(fontSize: 18)),
                  SizedBox(height: 6),
                  Text("Movie Description: ${movie.description}", textAlign: TextAlign.justify,style:TextStyle(fontSize: 18)),]))
                
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}