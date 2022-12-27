part of 'tab_bloc.dart';

class TabState {
  late final Tab tab;

  TabState({required this.tab});

  TabState.init() {
    SplayTreeMap<DateTime, String> items = SplayTreeMap();

    for (int i = -2; i <= 2; i++) {
      var dateTime = DateTime.now().add(Duration(days: i));
      if (i != 0) {
        items[dateTime] = intl.DateFormat("EEE dd MMM").format(dateTime);
      } else {
        items[dateTime] = 'Today';
      }
    }
    int tabPosition = 2;
    tab = Tab(count: items.length, items: items, position: tabPosition);
  }

  TabState copyWith(newTab) {
    return TabState(tab: newTab);
  }

  TabState addItem(bool addToEnd, int currentPosition) {
    SplayTreeMap<DateTime, String> items = tab.items;
    int position = currentPosition;
    if (addToEnd) {
      for (int i = 1; i <= 3; i++) {
        var date = items.lastKey()!.add(const Duration(days: 1));
        items[date] = intl.DateFormat("EEE dd MMM").format(date);
      }
    } else {
      for (int i = -1; i >= -3; i--) {
        var date = items.firstKey()!.add(const Duration(days: -1));
        items[date] = intl.DateFormat("EEE dd MMM").format(date);
      }
      position += 3;
    }

    return TabState(
        tab: Tab(count: items.length, items: items, position: position));
  }
}

class Tab {
  int count;
  SplayTreeMap<DateTime, String> items;
  int position;

  Tab({required this.count, required this.items, required this.position});
}
