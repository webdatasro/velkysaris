
class DateUtil{

  var mouths =['januára','februára','marca','apríla','mája','júna','júla','augusta','septembra','októbra','novembra','decembra'];

  String buildDate(String date){

    try{
      var datatime = DateTime.parse(date);
      return "vložené dňa ${datatime.day}. ${mouths[datatime.month-1]} ${datatime.year}";
    }catch(e){
      return "";
    }

  }

}