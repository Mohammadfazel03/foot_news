import 'package:flutter/material.dart';

class FixtureTabScreen extends StatefulWidget {
  const FixtureTabScreen({Key? key}) : super(key: key);

  @override
  State<FixtureTabScreen> createState() => _FixtureTabScreenState();
}

class _FixtureTabScreenState extends State<FixtureTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text('${widget.key}'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
