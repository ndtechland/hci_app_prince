import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Resorts.dart';
import '../utils/datasource.dart';

class HotelDetails extends StatelessWidget {
  final Resorts resorts;
  const HotelDetails({Key? key, required this.resorts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Ensure that all the fields used are non-nullable or provide default values
    final imageUrl = LOCATION_IMAGE_BASE_URL + (resorts.imageName ?? 'default_image.jpg');
    final placeName = resorts.placeName ?? 'No Place Name';
    final description = resorts.description ?? 'No Description';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back,color: Colors.white,),),
        backgroundColor: primaryColor,
        title: Text(
          resorts.desinationName ?? 'No Destination Name',
          style: GoogleFonts.roboto(
              fontSize: size.height * 0.02, fontWeight: FontWeight.bold,
          color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                )),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  placeName,
                  style: GoogleFonts.aBeeZee(
                      backgroundColor: Colors.blueGrey,
                      fontSize: size.height * 0.014,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
