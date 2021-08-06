import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Basic Background (Unused as of 6/8/21)
const kGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.deepPurple, Colors.blue],
);

//App Icons
Icon kLightningIcon = Icon(
  FontAwesomeIcons.bolt,
  size: 75.0,
  color: Colors.white,
);

Icon kDrizzleIcon = Icon(
  FontAwesomeIcons.cloudRain,
  size: 75.0,
  color: Colors.white,
);

Icon kRainIcon = Icon(
  FontAwesomeIcons.cloudShowersHeavy,
  size: 75.0,
  color: Colors.white,
);

Icon kSnowIcon = Icon(
  FontAwesomeIcons.snowflake,
  size: 75.0,
  color: Colors.white,
);

Icon kAtmosphereIcon = Icon(
  FontAwesomeIcons.smog,
  size: 75.0,
  color: Colors.white,
);

Icon kSunIcon = Icon(
  FontAwesomeIcons.sun,
  size: 75.0,
  color: Colors.white,
);

Icon kCloudIcon = Icon(
  FontAwesomeIcons.cloud,
  size: 75.0,
  color: Colors.white,
);

Icon kMoonIcon = Icon(
  FontAwesomeIcons.moon,
  size: 75.0,
  color: Colors.white,
);

Icon kErrorIcon = Icon(
  FontAwesomeIcons.solidQuestionCircle,
  size: 75.0,
  color: Colors.white,
);

const kWeekdays = {
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
};

const kMonths = {
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
};

/*
//Used to contain ints, needed?
const kWeekdays = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};

const kMonths = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};
*/