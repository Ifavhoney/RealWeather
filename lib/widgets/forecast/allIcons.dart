import 'package:flutter/material.dart';

class AllIcons {
  static TextStyle styleTemp =
      TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle styleCurrTemp =
      TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle styleCurrHumidity =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

  //For The Icons of Main in API
  static Image showMain(String main, double size) {
    switch (main) {
      case "Clouds":
        styleTemp = styleTemp.copyWith(color: Colors.white);

        return Image.asset(
          "images/Clouds.png",
          height: size,
          width: size,
        );
        break;
      case "Rain":
        styleTemp = styleTemp.copyWith(color: Colors.white);

        return Image.asset(
          "images/Rain.png",
          height: size,
          width: size,
        );
        break;
      case "Clear":
        styleTemp = styleTemp.copyWith(color: Colors.white);

        return Image.asset(
          "images/Clear.png",
          height: size,
          width: size,
        );
        break;

      case "Snow":
        styleTemp = styleTemp.copyWith(color: Colors.white);

        return Image.asset(
          "images/white_snow.png",
          height: size,
          width: size,
        );

      default:
        return Image.asset(
          "images/Clouds.png",
          height: size,
          width: size,
        );
    }
  }

  //For the Icons of Description in API
  static Image showDesc(String description, BuildContext context) {
    const double size = 10;
    switch (description) {
      //clouds cover all 8/8 areas
      case "overcast clouds":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.grey.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.black);
        return Image.asset(
          "images/overcastClouds.JPG",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
      // Clouds cover 1/8 to 2/8 coverage
      case "few clouds":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.grey.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.black);
        return Image.asset(
          "images/fewClouds.png",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;

      // Clouds cover 3/8 to 7/8 coverage,
      case "broken clouds":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.grey.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.black);
        return Image.asset(
          "images/brokenClouds.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;

      //Clouds cover 3/8 to 4/8 coverage
      case "scattered clouds":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.grey.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.black);
        return Image.asset(
          "images/scatteredClouds.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
      //0.10 inches of rain per hour.
      case "light rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);

        return Image.asset(
          "images/lightRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
      //  0.10 to 0.30 inches of rain per hour
      case "moderate rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/moderateRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
      //Heavy rainfall is more than 0.30 inches of rain per hour
      case "heavy intensive rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/heavyRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
      //Very Heavy rainfall is more than 0.30 inches of rain per hour
      case "very heavy rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/heavyRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
      //Heavy rainfall is more than 4 inches of rain per hour
      case "extreme rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/extremeRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
//Rain that freezes on impact with the ground or solid objects
      case "freezing rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/freezingRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
//Light Rain with a shorter duration than usual on a small span of area (differs by city)
      case "light intensive shower rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/moderateRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
//Rain with shorter duration than usual on a small span of area (differs by city)
      case "shower rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/moderateRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
//Heavy Rain with shorter duration than usual on a small span of area (differs by city)

      case "heavy intensive shower rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/heavyIntensiveShowerRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
//Irregular rain

      case "ragged shower rain":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.blue.shade200);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.white);
        return Image.asset(
          "images/moderateRain.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;
      // Clouds cover 0/8 to 0.5/8
      case "clear sky":
        styleCurrTemp = styleCurrTemp.copyWith(color: Colors.white);
        styleCurrHumidity = styleCurrHumidity.copyWith(color: Colors.black);
        return Image.asset(
          "images/clearSky.jpg",
          fit: BoxFit.fill,
          height: 300,
          width: MediaQuery.of(context).size.width,
        );
        break;

      default:
        return Image.asset(
          "images/white_snow.png",
          height: size,
          width: size,
        );
    }
  }
}
