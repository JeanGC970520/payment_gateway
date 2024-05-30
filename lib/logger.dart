

import 'package:logger/logger.dart';

final logger = Logger(
  filter: null,
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
  output: null,
);

// final logger = Logger(
//   printer: SimpleLogPrinter(),
// );

class SimpleLogPrinter extends LogPrinter {

  SimpleLogPrinter();


  String toTwoDigits( int value ) => value.toString().padLeft(2,'0'); 

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;
    final now = DateTime.now();
    final date = "${now.year}-${toTwoDigits(now.month)}-${toTwoDigits(now.day)}";
    final time = "${toTwoDigits(now.hour)}:${toTwoDigits(now.minute)}:${toTwoDigits(now.second)}.${now.millisecond}";
    final dateTime = "$date $time";

    return [color.toString(), ('$emoji - $dateTime :  $message')];
  }
}