part of 'tab_bloc.dart';

@freezed
class TabState with _$TabState {
  // late final Tab tab;

  const TabState._();

  const factory TabState({required Tab tab}) = _TabState;

  static TabState init() {
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
    return TabState(tab: Tab(count: items.length, items: items, position: tabPosition));
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

    return TabState(tab: Tab(count: items.length, items: items, position: position));
  }
}

@freezed
class Tab with _$Tab {
  const factory Tab(
      {required int count,
      required SplayTreeMap<DateTime, String> items,
      required int position}) = _Tab;
}
