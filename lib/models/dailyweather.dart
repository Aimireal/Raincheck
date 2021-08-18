class DailyWeather {
  String weekday;
  //int conditionWeather;
  dynamic maxTemp;
  dynamic minTemp;

  DailyWeather(
    {
      required this.weekday, 
      //required this.conditionWeather, 
      this.maxTemp, 
      this.minTemp
    }
  );
}