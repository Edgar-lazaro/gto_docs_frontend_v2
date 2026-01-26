int adaptiveCrossAxisCount(double width) {
  if (width >= 1200) return 6;
  if (width >= 900) return 4;
  if (width >= 600) return 3;
  return 2;
}