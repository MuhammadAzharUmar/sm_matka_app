class StarlineGameBid {
  final String gameId;
  final String gameType;
  final String session;
  final String bidPoints;
  final String digit;
  final String panna;

  StarlineGameBid({
    required this.gameId,
    required this.gameType,
    required this.session,
    required this.bidPoints,
    required this.digit,
    required this.panna,
  });

  factory StarlineGameBid.fromJson(Map<String, dynamic> json) {
    return StarlineGameBid(
      gameId: json['game_id'],
      gameType: json['game_type'],
      session: json['session'],
      bidPoints: json['bid_points'],
      digit: json['digit'],
      panna: json['panna'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_id': gameId,
      'game_type': gameType,
      'session': session,
      'bid_points': bidPoints,
      'digit': digit,
      'panna': panna,
    };
  }
}
