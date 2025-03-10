import 'package:flutter/material.dart';

import '../utils/datasource.dart'; // Assuming this contains necessary utilities

class VacationListItem extends StatelessWidget {
  final int index;
  final String dateString;
  final int tenure;
  final int days;
  final int nights;

  const VacationListItem(
      this.index, this.dateString, this.tenure, this.days, this.nights);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        margin: EdgeInsets.all(5),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              children: [
                Image.asset(
                  'images/price_tag.png',
                  height: 30,
                  width: 55,
                ),
                Positioned(
                  top: 8,
                  left: 22,
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
            // Left side date (current year)
            buildDateContainer(context, 0),
            Image.asset(
              'images/arrow_final.png',
              width: 60,
              height: 40,
              color: primaryColor,
            ),
            // Right side date (next year)
            buildDateContainer(context, 1),
            // Nights and Days Info
            Text(
              getNightsAndDaysInfo(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            // Booking, Feedback, or Availability Info
            buildBookingInfo(context),
          ],
        ),
      ),
    );
  }

  // Builds a date container for the left or right side based on the year offset
  Widget buildDateContainer(BuildContext context, int yearOffset) {
    DateTime displayDate = getDate(yearOffset);

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: primaryColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getMonthName(displayDate.month),
            style: TextStyle(fontSize: 13),
          ),
          Text(
            "${displayDate.day}",
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
          Text(
            "${displayDate.year}",
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // Gets the date based on yearOffset
  DateTime getDate(int yearOffset) {
    try {
      List<String> dateParts = dateString.split(' ');

      // Extract the year, month, and day from the dateString
      int baseYear = int.parse(dateParts[0]); // Year part
      int month = getMonthNumber(dateParts[1]); // Month part (MMM)
      int day = int.parse(dateParts[2]); // Day part

      // Calculate the year for this specific item
      int displayYear = baseYear + index + yearOffset;

      // Return the date with the updated year
      return DateTime(displayYear, month, day);
    } catch (e) {
      print('Error parsing date: $dateString');
      print(e);
      // Return a default date in case of an error
      return DateTime.now();
    }
  }

  // Helper to return the month name from the month number
  String getMonthName(int monthNumber) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[monthNumber - 1];
  }

  // Helper to convert month abbreviation to month number
  int getMonthNumber(String monthAbbreviation) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months.indexOf(monthAbbreviation) + 1;
  }

  // Function to display nights and days info
  String getNightsAndDaysInfo() {
    if ((getYearFromDateString() + index) == getCurrentYear()) {
      return '$nights Night \n and \n $days Days';
    } else {
      return '6 Night \n and \n 7 Days';
    }
  }

  // Function to build the booking/feedback/available status column
  Widget buildBookingInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/book_holiday');
              },
              child: Visibility(
                  visible:
                      (getYearFromDateString() + index + 1) == getCurrentYear(),
                  child: Image.asset(
                    'images/play.png',
                    width: 50,
                    height: 25,
                    color: primaryColor,
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/feedback_screen');
              },
              child: Visibility(
                  visible:
                      (getYearFromDateString() + index + 1) < getCurrentYear(),
                  child: Image.asset(
                    'images/feedback.png',
                    width: 50,
                    height: 25,
                  )),
            ),
            Visibility(
                visible:
                    (getYearFromDateString() + index + 1) > getCurrentYear(),
                child: Icon(
                  Icons.event_available,
                  size: 30,
                  color: Colors.green,
                )),
          ],
        ),
        Text(
          "${(() {
            if ((getYearFromDateString() + index + 1) == getCurrentYear()) {
              return 'Book now';
            } else if ((getYearFromDateString() + index + 1) <
                getCurrentYear()) {
              return 'Feedback';
            } else if ((getYearFromDateString() + index + 1) >
                getCurrentYear()) {
              return 'Available';
            }
          }())}",
          style: TextStyle(
              fontSize: 10,
              color: (() {
                if ((getYearFromDateString() + index + 1) == getCurrentYear()) {
                  return Colors.yellow.shade900; // 'Book now'
                } else if ((getYearFromDateString() + index + 1) <
                    getCurrentYear()) {
                  return Colors.blue; // 'Feedback'
                } else if ((getYearFromDateString() + index + 1) >
                    getCurrentYear()) {
                  return Colors.green; // 'Available'
                }
              }()),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  // Gets the year from dateString
  int getYearFromDateString() {
    return int.parse(dateString.split(' ')[0]); // Correctly gets the year
  }

  // Function to get the current year
  int getCurrentYear() {
    var currentDate = DateTime.now();
    return currentDate.year;
  }
}
