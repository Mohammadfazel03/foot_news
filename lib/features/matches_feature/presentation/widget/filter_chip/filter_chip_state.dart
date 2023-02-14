part of 'filter_chip_cubit.dart';

@freezed
class FilterChipState with _$FilterChipState {
  const FilterChipState._();

  const factory FilterChipState({
    required List<int> selectedItems,
  }) = _FilterChipState;

  bool get byOngoing => selectedItems.contains(0);

  bool get byFavourite => selectedItems.contains(1);

  bool get byTime => selectedItems.contains(2);
}
