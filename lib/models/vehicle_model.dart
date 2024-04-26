class Vehicle {
  final String? id; // Making id optional
  final String make;
  final String model;
  final int year;
  final String transmission;
  final int seats;
  final int doors;
  final String mileage;
  final String gasType;
  final String description;
  final String basePrice;
  final List<String> photos;
  final String? agencyName;
  final String? agencyNumber;

  Vehicle({
    this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.transmission,
    required this.seats,
    required this.doors,
    required this.mileage,
    required this.gasType,
    required this.description,
    required this.basePrice,
    required this.photos,
    this.agencyName,
    this.agencyNumber,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'], // Access id from JSON data
      make: json['make'],
      model: json['model'],
      year: json['year'],
      transmission: json['transmission'],
      seats: json['seats'],
      doors: json['doors'],
      mileage: json['mileage'],
      gasType: json['gasType'],
      description: json['description'],
      basePrice: json['basePrice'],
      photos: List<String>.from(json['photos']),
      agencyName: json['agencyName'],
      agencyNumber: json['agencyNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id, // Include id only if it's not null
      'make': make,
      'model': model,
      'year': year,
      'transmission': transmission,
      'seats': seats,
      'doors': doors,
      'mileage': mileage,
      'gasType': gasType,
      'description': description,
      'basePrice': basePrice,
      'photos': photos,
      'agencyName': agencyName,
      'agencyNumber': agencyNumber,
    };
  }
}
