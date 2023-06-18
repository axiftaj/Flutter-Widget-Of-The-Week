

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatesAndTimeWidget extends StatefulWidget {
  const DatesAndTimeWidget({Key? key}) : super(key: key);

  @override
  State<DatesAndTimeWidget> createState() => _DatesAndTimeWidgetState();
}

class _DatesAndTimeWidgetState extends State<DatesAndTimeWidget> {


  DateTime now = DateTime.now() ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Date & Time'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(title : 'Problem' , date: now.toString()),
                const Divider(),
                const Text('Custom Date'),
                TextWidget(title : 'Date & Time Format', date:DatesUtils().dateFormatYMDKKMM()),
                TextWidget(title: 'Date' ,date: "${DateFormat.y().format(now)}:${DateFormat.M().format(now)}:${DateFormat.d().format(now)}"),
                TextWidget(title: 'Date' ,date: "${DateFormat.y().format(now)}-${DateFormat.M().format(now)}-${DateFormat.d().format(now)}"),
                TextWidget(title: 'Date' ,date: "${DateFormat.y().format(now)}/${DateFormat.M().format(now)}/${DateFormat.d().format(now)}"),
                TextWidget(title: 'Date DMY' ,date: "${DateFormat.d().format(now)}/${DateFormat.M().format(now)}/${DateFormat.y().format(now)}"),

                const Divider(),
                TextWidget(title : 'Date' , date:DateFormat.d().format(DateTime.now())),
                TextWidget(title : 'Day name' ,date:DateFormat.EEEE().format(DateTime.now())),
                TextWidget(title : 'Short day name' ,date:DateFormat.E().format(DateTime.now())),
                const Divider(),
                TextWidget(title: 'Month', date:DateFormat.M().format(DateTime.now())),
                TextWidget(title: 'Month name',date:DateFormat.LLLL().format(DateTime.now())),
                TextWidget( title: 'Short month name',date:DateFormat.LLL().format(DateTime.now())),
                const Divider(),
                TextWidget( title: 'Year',date:DateFormat.y().format(DateTime.now())),
                const Divider(),
                TextWidget(title: 'Hour', date:DateFormat.H().format(DateTime.now())),
                TextWidget(title: '24 hour time format', date:DateFormat.Hm().format(DateTime.now())),
                TextWidget(title: 'Time in AM',  date:DateFormat.jm().format(DateTime.now().copyWith(hour: 10))),
                TextWidget(title: 'Time in PM',  date:DateFormat.jm().format(DateTime.now())),

                const Divider(),
                const Text('Day ago:' , style: TextStyle(fontWeight: FontWeight.bold),),
                Text("${DatesUtils().daysAgo(DateTime.now().microsecondsSinceEpoch.toString())},${DatesUtils().daysAgo(DateTime(now.year, now.month, now.day-1).microsecondsSinceEpoch.toString())},${DatesUtils().daysAgo(DateTime(now.year, now.month, now.day-2).microsecondsSinceEpoch.toString())},${DatesUtils().daysAgo(DateTime(now.year, now.month, now.day-3).microsecondsSinceEpoch.toString())}" ,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const Divider(),
                const Text('Minutes, hours & weeks ago:' , style: TextStyle(fontWeight: FontWeight.bold),),
                Text("${DatesUtils().timesAndMinutesAgo(DateTime(2023, 06, 18 , 15 , 20).microsecondsSinceEpoch.toString())},${DatesUtils().timesAndMinutesAgo(DateTime(2023, 06, 18 , 10 , 20).microsecondsSinceEpoch.toString())},${DatesUtils().timesAndMinutesAgo(DateTime(2023, 06, 12 , 15 , 20).microsecondsSinceEpoch.toString())},${DatesUtils().timesAndMinutesAgo(DateTime(2023, 06, 01 , 15 , 20).microsecondsSinceEpoch.toString())}"),
                const Divider(),
                const Text('Previous date Days compare to current date:'),
                TextWidget(title: 'Today date', date: DatesUtils().compareTimesForSevenDays(DateTime.now().microsecondsSinceEpoch.toString())),
                TextWidget( title: 'Yesterday',date: DatesUtils().compareTimesForSevenDays(DateTime(now.year, now.month, now.day-1).microsecondsSinceEpoch.toString())),
                TextWidget(date: DatesUtils().compareTimesForSevenDays(DateTime(2023, 06, 16).microsecondsSinceEpoch.toString())),
                TextWidget(date: DatesUtils().compareTimesForSevenDays(DateTime(2023, 06, 15).microsecondsSinceEpoch.toString())),
                TextWidget(date: DatesUtils().compareTimesForSevenDays(DateTime(2023, 06, 14).microsecondsSinceEpoch.toString())),
                TextWidget(date: DatesUtils().compareTimesForSevenDays(DateTime(2023, 06, 13).microsecondsSinceEpoch.toString())),
                TextWidget(date: DatesUtils().compareTimesForSevenDays(DateTime(2023, 06, 12).microsecondsSinceEpoch.toString())),
                TextWidget(date: DatesUtils().compareTimesForSevenDays(DateTime(2023, 06, 11).microsecondsSinceEpoch.toString())),
                TextWidget(date: DatesUtils().compareTimesForSevenDays(DateTime(2023, 06, 10).microsecondsSinceEpoch.toString())),
                const Divider(),


              ],
            ),
          ),
        ),
      ),
    );
  }
}


class TextWidget extends StatelessWidget {
  final String title, date ;
  const TextWidget({Key? key , required this.date , this.title = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(date , style: TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}



class DatesUtils {


  String dateFormatYMDKKMM(){
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd , hh:mm').format(now);
    return formattedDate ;
  }

  String compareTimesForSevenDays(String date){

    DateTime dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(date.toString())).toLocal();

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday = DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    final dayBeforeYesterday = DateTime(todayDate.year, todayDate.month, todayDate.day - 2);

    String difference = '';

    final aDate = DateTime(dt.year, dt.month, dt.day);

    if( aDate == today){
      return 'Today' ;
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else if (aDate == dayBeforeYesterday) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 3 && todayDate.difference(dt).inDays < 4) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 4 &&
        todayDate.difference(dt).inDays < 5) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 5 &&
        todayDate.difference(dt).inDays < 6) {
      difference = DateFormat('E').format(dt).toString();
    } else if (todayDate.difference(dt).inDays >= 6 &&
        todayDate.difference(dt).inDays < 7) {
      difference = DateFormat('E').format(dt).toString();
    } else  {
      difference = "${DateFormat.d().format(dt)} ${DateFormat.MMM().format(dt)} ${DateFormat.y().format(dt)}";
    }
    return difference ;
  }

  String daysAgo(String date){

    DateTime dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(date.toString())).toLocal();

    final todayDate = DateTime.now();


    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday = DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    final dayBeforeYesterday = DateTime(todayDate.year, todayDate.month, todayDate.day - 2);

    String difference = '';

    final aDate = DateTime(dt.year, dt.month, dt.day);

    if( aDate == today){
      return 'Today' ;
    } else if (aDate == yesterday) {
      difference = "1d ago";
    } else if (aDate == dayBeforeYesterday) {
      difference = '2d ago';
    } else if (todayDate.difference(dt).inDays >= 3 && todayDate.difference(dt).inDays < 4) {
      difference = '3d ago';
    } else if (todayDate.difference(dt).inDays >= 4 && todayDate.difference(dt).inDays < 5) {
      difference = '4d ago';

    } else if (todayDate.difference(dt).inDays >= 5 && todayDate.difference(dt).inDays < 6) {
      difference = '5d ago';
    } else if (todayDate.difference(dt).inDays >= 6 &&
        todayDate.difference(dt).inDays < 7) {
      difference = '6 ago' ;
    }
    else  {
      difference = "${DateFormat.d().format(dt)} ${DateFormat.MMM().format(dt)} ${DateFormat.y().format(dt)}";
    }
    return difference ;
  }

  String timesAndMinutesAgo(String timestamp){

    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp));
    var diff = now.difference(date);
    var time = '';

    print(diff.inMinutes);

    
    if (diff.inHours <= 1) {
      time = diff.inMinutes.toString() +"m ago";
    }else if(diff.inHours <= 24){
      time = diff.inHours.toString() +"h ago";
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

}