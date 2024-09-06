// part of 'common_parts.dart';
//
// abstract class NTemplates {
//   /// Title of Messages Notifications
//
//   static String newMessagesTitle({
//     required int howMany,
//     required DateTime? atTime,
//     bool htmlFormat = false,
//   }) {
//     final prepend = L10nR.newMessageNPrepend(howMany, htmlFormat);
//     final atTimeFormatted = DateFormat.jm().format(atTime!);
//     return '$prepend ${htmlFormat ? "<b>atTimeFormatted</b>" : atTimeFormatted}';
//   }
//
//   static String newMessagesSubtitle({required List<String> messages}) {
//     final length = messages.length;
//     if (length > 4) {
//       return messages.getRange(messages.length - 4, messages.length).fold(
//           '', (previousValue, element) => previousValue.isEmpty ? element : '$previousValue\n$element');
//     } else {
//       return messages
//           // .getRange(messages.length - 4, messages.length)
//           .fold('',
//               (previousValue, element) => previousValue.isEmpty ? element : '$previousValue\n$element');
//     }
//   }
//
//   /// Common subtitle that is used among booking notification
//   static String to({required String destination}) => '${L10nR.bookingNToSubtitle} $destination';
// }
