import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_chip_cubit.dart';

class FilterChip extends StatefulWidget {
  const FilterChip({Key? key}) : super(key: key);

  @override
  State<FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<FilterChip> {
  static const items = [
    {'index': 0, 'name': 'Ongoing'},
    {'index': 1, 'name': 'Favourite'},
    {'index': 2, 'name': 'By Time'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterChipCubit, FilterChipState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.start,
          children: items.map((e) {
            var isSelected = state.selectedItems.contains(e['index'] as int);
            return _item(isSelected, e['name'].toString(), () {
              isSelected
                  ? BlocProvider.of<FilterChipCubit>(context)
                      .unSelectItem(e['index'] as int)
                  : BlocProvider.of<FilterChipCubit>(context)
                      .selectItem(e['index'] as int);
            });
          }).toList(growable: false));
      },
    );
  }

  Widget _item(
    bool isSelected,
    String text,
    void Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).primaryColorDark,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
              maxLines: 1,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.white)),
        ),
      ),
    );
  }
}
