class GameBid {
  final String gameId;
  final String gameType;
  final String session;
  final String bidPoints;
  final String openDigit;
  final String closeDigit;
  final String openPanna;
  final String closePanna;

  GameBid({
    required this.gameId,
    required this.gameType,
    required this.session,
    required this.bidPoints,
    required this.openDigit,
    required this.closeDigit,
    required this.openPanna,
    required this.closePanna,
  });

  factory GameBid.fromJson(Map<String, dynamic> json) {
    return GameBid(
      gameId: json['game_id'],
      gameType: json['game_type'],
      session: json['session'],
      bidPoints: json['bid_points'],
      openDigit: json['open_digit'],
      closeDigit: json['close_digit'],
      openPanna: json['open_panna'],
      closePanna: json['close_panna'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_id': gameId,
      'game_type': gameType,
      'session': session,
      'bid_points': bidPoints,
      'open_digit': openDigit,
      'close_digit': closeDigit,
      'open_panna': openPanna,
      'close_panna': closePanna,
    };
  }
}
