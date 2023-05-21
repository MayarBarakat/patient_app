import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatelessWidget {
  double screenWedth = 0;
  @override
  Widget build(BuildContext context) {
    screenWedth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildEmployeeName(screenWidth: screenWedth,employeeName: "ميار بركات"),
                SizedBox(width: 12,),
                buildWelcomeMessage(screenWidth: screenWedth),


              ],
            ),
            SearchBarAnimation(
              isOriginalAnimation: false,
              buttonBorderColour: Colors.black45,
              textEditingController: TextEditingController(),
              trailingWidget: Icon(Icons.search),
              secondaryButtonWidget: Icon(Icons.telegram),
              buttonWidget: Icon(Icons.access_time_filled),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildWelcomeMessage({required double screenWidth}){
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        "مرحبا",
        style: TextStyle(
          color: Colors.black54,
          fontFamily: "NexaRegular",
          fontSize: screenWidth / 16,
        ),
      ),
    );
  }
  Widget buildEmployeeName({required String employeeName,required double screenWidth}){
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        employeeName,
        style: TextStyle(
          fontFamily: "NexaBold",
          fontSize: screenWidth / 14,
        ),
      ),
    );
  }
}
