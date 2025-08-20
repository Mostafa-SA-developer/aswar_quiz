import 'FinderFrameMissing.dart';

void main() {
  List<int> frames = [1, 2, 3, 5, 6, 10, 11, 16];

  var analyzer = FinderFrameMissing(frames);
  var result = analyzer.findMissingRanges();

  print(result);
}
