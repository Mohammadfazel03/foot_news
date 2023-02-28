import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foot_news/common/utils/material_colors.dart';
import 'package:foot_news/features/match_feature/data/local/collections/match_details_collection.dart';
import 'package:intl/intl.dart' as intl;

class GameDetailsSummaryScreen extends StatelessWidget {
  final MatchDetailsCollection matchCollection;

  const GameDetailsSummaryScreen({Key? key, required this.matchCollection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (matchCollection.content?.matchFacts?.events?.events?.isNotEmpty == true) ...[
          for (var event in matchCollection.content!.matchFacts!.events!.events!) ...[
            _eventRow(event!, context)
          ]
        ],
        if (matchCollection.content?.matchFacts?.infoBox != null) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text(
              'Match Information',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          if (matchCollection.content?.matchFacts?.infoBox?.tournament != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: _tournamentRow(matchCollection),
            )
          ],
          if (matchCollection.general?.matchTimeUTCDate != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: _dateRow(matchCollection.general!),
            )
          ],
          if (matchCollection.content?.matchFacts?.infoBox?.referee != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: _refereeRow(matchCollection.content!.matchFacts!.infoBox!.referee!),
            )
          ],
          if (matchCollection.content?.matchFacts?.infoBox?.stadium != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: _stadiumRow(matchCollection.content!.matchFacts!.infoBox!.stadium!),
            )
          ],
          if (matchCollection.content?.matchFacts?.infoBox?.attendance != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: _attendanceRow(matchCollection.content!.matchFacts!.infoBox!.attendance!),
            )
          ],
        ]
      ],
    );
  }

  Widget _tournamentRow(MatchDetailsCollection collection) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                  placeholder: (context, string) =>
                      Image.asset('assets/images/team_placeholder.png'),
                  errorWidget: (context, string, error) =>
                      Image.asset('assets/images/team_placeholder.png'),
                  imageUrl:
                      'https://images.fotmob.com/image_resources/logo/teamlogo/${collection.general?.countryCode?.toLowerCase()}.png',
                  height: 16,
                  width: 16),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(
                collection.content?.matchFacts?.infoBox?.tournament?.leagueName ?? 'undefined',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              )),
            ],
          ),
        ),
        Flexible(
            child: Text(
          collection.content?.matchFacts?.infoBox?.tournament?.round ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ))
      ],
    );
  }

  Widget _dateRow(MatchGeneralEmbedded general) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon-time.png',
              height: 16,
              width: 16,
            ),
            const SizedBox(width: 8),
            const Text(
              'Date',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        Flexible(
            child: Text(
          intl.DateFormat('dd.MM.yyyy').format(DateTime.parse(general.matchTimeUTCDate!)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ))
      ],
    );
  }

  Widget _refereeRow(RefereeEmbedded referee) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon-whistle.png',
              height: 16,
              width: 16,
            ),
            const SizedBox(width: 8),
            const Text(
              'Referee',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        Flexible(
            child: Text(
          referee.text ?? 'undefined',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ))
      ],
    );
  }

  Widget _stadiumRow(StadiumEmbedded stadium) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon-stadium.png',
              height: 16,
              width: 16,
            ),
            const SizedBox(width: 8),
            const Text(
              'Stadium',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        Flexible(
            child: Text(
          stadium.name ?? 'undefined',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ))
      ],
    );
  }

  Widget _attendanceRow(int attendance) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon-fans.png',
              height: 16,
              width: 16,
            ),
            const SizedBox(width: 8),
            const Text(
              'Attendance',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        Flexible(
            child: Text(
          attendance.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ))
      ],
    );
  }

  Widget _eventRow(EventsBeanEmbedded event, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: (event.isHome == true) ? TextDirection.ltr : TextDirection.rtl,
        children: [
          if (event.type == 'Goal' || event.type == 'goal') ...[
            const SizedBox(width: 8),
            Text(event.timeStr ?? 'undefined', style: const TextStyle(color: Colors.white, fontSize: 12)),
            const SizedBox(width: 8),
            Image.asset('assets/images/match-goal.png',
                height: 16,
                width: 16,
                color: (event.ownGoal == true) ? MaterialColors.redLose : MaterialColors.greenWin),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                event.assistStr == null
                    ? (event.nameStr ?? 'undefined')
                    : ('${event.nameStr ?? 'undefined'} (${event.assistStr})'),
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
          ] else if (event.type == 'Card' || event.type == 'card') ...[
            const SizedBox(width: 8),
            Text(event.timeStr ?? 'undefined', style: const TextStyle(color: Colors.white, fontSize: 12)),
            const SizedBox(width: 8),
            Image.asset(
              (event.card == 'Yellow' || event.card == 'yellow')
                  ? 'assets/images/match-yellow-card.png'
                  : (event.card == 'red' || event.card == 'Red')
                      ? 'assets/images/match-red-card.png'
                      : 'assets/images/match-yellow-red-card.png',
              height: 16,
              width: 16,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                event.nameStr ?? 'undefined',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
          ] else if (event.type == 'Substitution' || event.type == 'substitution') ...[
            const SizedBox(width: 8),
            Text(event.timeStr ?? 'undefined', style: const TextStyle(color: Colors.white, fontSize: 12)),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/match-substitution.png',
              height: 16,
              width: 16,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                '${event.swap?[0]?.name ?? 'undefined'} (${event.swap?[1]?.name ?? 'undefined'})',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
          ] else if (event.type == 'AddedTime') ...[
            Expanded(
              child: Text(
                event.minutesAddedStr ?? 'undefined',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ] else if (event.type == 'Half' || event.type == 'half') ...[
            Expanded(
              child: SizedBox(
                height: 32,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
                  child: Align(
                    child: Text(
                      event.halfStrShort ?? 'undefined',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
