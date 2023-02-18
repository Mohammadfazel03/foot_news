enum TabDetailsType {
  matchfacts,
  lineup,
  stats,
  h2h;

  String getName() {
    switch (name) {
      case 'matchfacts':
        return 'Summary';
      case 'lineup':
        return 'Lineup';
      case 'stats':
        return 'Stats';
      case 'h2h':
        return 'H2H';
      default:
        return '';
    }
  }
}
