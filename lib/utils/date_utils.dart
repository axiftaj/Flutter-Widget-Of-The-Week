

import 'package:intl/intl.dart';

class DateUtils {

   String changeMDYToYMD(String inputDate){

    try{

      DateFormat originalFormat = DateFormat("MM/dd/yyyy");
      DateTime dateTime = originalFormat.parse(inputDate);

      // Format the date to 'yyyy-MM-dd'
      DateFormat desiredFormat = DateFormat("yyyy-MM-dd");
      String formattedDate = desiredFormat.format(dateTime);
      return formattedDate;

    }catch(e){

      return  '' ;
    }

  }

}