String getDefaultName(int startHour) {
  if (startHour >= 2 && startHour <= 11) {
    return "Morning exercise";
  } else if (startHour >= 11 && startHour <= 13) {
    return "Midday exercise";
  } else if (startHour >= 13 && startHour <= 18) {
    return "Afternoon exercise";
  } else if (startHour >= 18 || startHour <= 2) {
    return "Evening exercise";
  } else {
    return "Exercise";
  }
}

