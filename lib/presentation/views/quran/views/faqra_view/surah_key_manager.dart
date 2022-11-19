class SurahKeyManager {
  SurahKeyManager() {
    init();
  }

  void init() {}
  int maxIndex = 0;

  Map<int, int> _mapKeys = {};

  void resetMapKey() => _mapKeys = {};

  int indexOfAya(int surahId, int ayaId, [int werd = 0]) {
    int key = werd * 1000000 + surahId * 1000 + ayaId;

    if (!_mapKeys.containsKey(key)) {
      _mapKeys[key] = ++maxIndex;
    }
    print("key : $key, revers : ${indexToKeyCache(key)}");
    return key;
  }

  // reverse
  KeyCacheInfo indexToKeyCache(int index) {
    int werd = index ~/ 1000000;
    index -= werd*1000000;
    int surah = index ~/ 1000;
    index -= surah*1000;
    int aya = index;
    return KeyCacheInfo(aya, surah, werd);
  }

// visible manager

}

class KeyCacheInfo {
  int aya;
  int surah;
  int werd;

  KeyCacheInfo(this.aya, this.surah, this.werd);

  @override
  String toString() {
    // return super.toString();
    return "{aya : $aya, surah : $surah, werd : $werd}";
  }
}
