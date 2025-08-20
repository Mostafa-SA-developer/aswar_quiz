class FinderFrameMissing {
  List<int> frames;

  FinderFrameMissing(this.frames);

  /// Function to find missing frame ranges
  Map<String, dynamic> findMissingRanges() {
    if (frames.isEmpty) {
      return {"gaps": [], "longest_gap": [], "missing_count": 0};
    }

    //Find max frame number manually (without sort)
    int maxFrame = getLastFrame();
    int missingCount = 0;

    List<List<int>> gaps = getGapList(maxFrame);

    // Find the longest gap and missingCount
    List<int> longestGap = [];
    int maxGapSize = 0;
    for (var gap in gaps) {
      int gapSize = gap[1] - gap[0] + 1;
      missingCount += gapSize;
      if (gapSize > maxGapSize) {
        maxGapSize = gapSize;
        longestGap = gap;
      }
    }

    return {
      "gaps": gaps,
      "longest_gap": longestGap,
      "missing_count": missingCount,
    };
  }

  int getLastFrame() {
    int maxFrame = frames[0];
    for (var f in frames) {
      if (f > maxFrame) maxFrame = f;
    }

    return maxFrame;
  }

  List<List<int>> getGapList(int maxFrame) {
    int missingCount = 0;

    //Create a set for faster lookup
    Set<int> frameSet = frames.toSet();

    List<List<int>> gaps = [];
    List<int>? currentGapStart;
    for (int i = 1; i <= maxFrame; i++) {
      if (!frameSet.contains(i)) {
        missingCount++;
        if (currentGapStart == null) {
          currentGapStart = [i, i];
        } else {
          currentGapStart[1] = i;
        }
      } else {
        if (currentGapStart != null) {
          gaps.add(currentGapStart);
          currentGapStart = null;
        }
      }
    }
    return gaps;
  }
}
