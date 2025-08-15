class ErrorResponse {
  final String message;
  final int statusCode;
  final String? code;
  final Map<String, dynamic>? details;
  final DateTime timestamp;

  ErrorResponse({
    required this.message,
    required this.statusCode,
    this.code,
    this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] ?? 'Unknown error',
      statusCode: json['status_code'] ?? 0,
      code: json['code'],
      details: json['details'],
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status_code': statusCode,
      'code': code,
      'details': details,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ErrorResponse(message: $message, statusCode: $statusCode, code: $code)';
  }
}
