import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foot_news/ui/games/fixture/fixture_tab_bloc.dart';

class FixtureTabScreen extends StatefulWidget {
  const FixtureTabScreen({Key? key}) : super(key: key);

  @override
  State<FixtureTabScreen> createState() => _FixtureTabScreenState();
}

class _FixtureTabScreenState extends State<FixtureTabScreen>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<FixtureTabBloc>(context).add(const FixtureTabEvent.updateData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<FixtureTabBloc, FixtureTabState>(
      listener: (context, state) {
        if(state.errors.isNotEmpty) {
          print(state.errors.first);
        }
      },
      builder: (context, state) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text('${widget.key}'),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
