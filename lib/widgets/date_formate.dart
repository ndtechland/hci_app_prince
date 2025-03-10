// import 'package:intl/intl.dart';
//
// // Function to parse a date string with various formats
// DateTime parseDate(String dateString) {
//   final formats = [
//     'dd/MM/yyyy', // 02/09/2020
//     'd/MMM/yyyy', // 25/Jun/2021
//     'yyyy-MM-dd', // 2021-08-25
//     'dd.MM.yy', // 29.01.21
//     'dd/MMM/yyyy', // 16/Jun/2021
//   ];
//
//   for (var format in formats) {
//     try {
//       return DateFormat(format).parse(dateString);
//     } catch (e) {
//       // Continue to the next format if parsing fails
//       continue;
//     }
//   }
//
//   // If no format matches, return a default date
//   return DateTime.now();
// }
