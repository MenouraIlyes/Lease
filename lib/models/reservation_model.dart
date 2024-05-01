class Reservation {
  final String startDate;
  final String endDate;
  final String pickupTime;
  final String dropoffTime;
  final String totalPrice;
  final String vehicleId;
  final String customerId;

  Reservation({
    required this.startDate,
    required this.endDate,
    required this.pickupTime,
    required this.dropoffTime,
    required this.totalPrice,
    required this.vehicleId,
    required this.customerId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      pickupTime: json['pickup_time'] as String,
      dropoffTime: json['dropoff_time'] as String,
      totalPrice: json['total_price'] as String,
      vehicleId: json['vehicle'] as String,
      customerId: json['customer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate,
      'end_date': endDate,
      'pickup_time': pickupTime,
      'dropoff_time': dropoffTime,
      'total_price': totalPrice,
      'vehicle': vehicleId,
      'customer': customerId,
    };
  }
}
