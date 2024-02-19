import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final String name;
  final String image;
  final String size;
  final String transmission;
  final String fuel;
  final String price;
  final String currencySymbol;
  final String city;
  final int order;
  final int passengers;
  final List<String> photoUrls;

  const Car({
    required this.name,
    required this.image,
    required this.size,
    required this.transmission,
    required this.fuel,
    required this.price,
    required this.currencySymbol,
    required this.city,
    required this.order,
    required this.passengers,
    required this.photoUrls,
  });

  Car copyWith({
    String? name,
    String? image,
    String? size,
    String? transmission,
    String? fuel,
    String? price,
    String? currencySymbol,
    String? city,
    int? order,
    int? passengers,
    List<String>? photoUrls,
  }) {
    return Car(
      name: name ?? this.name,
      image: image ?? this.image,
      size: size ?? this.size,
      transmission: transmission ?? this.transmission,
      fuel: fuel ?? this.fuel,
      price: price ?? this.price,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      city: city ?? this.city,
      order: order ?? this.order,
      passengers: passengers ?? this.passengers,
      photoUrls: photoUrls ?? this.photoUrls,
    );
  }

  @override
  List<Object?> get props => [
        name,
        image,
        size,
        transmission,
        fuel,
        price,
        currencySymbol,
        city,
        order,
        passengers,
        photoUrls
      ];

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      size: json['size'] ?? '',
      transmission: json['transmission'] ?? '',
      fuel: json['fuel'] ?? '',
      price: json['country'] ?? '',
      city: json['city'] ?? '',
      currencySymbol: json['currenceyCode'] ?? '',
      order: json['order'] ?? 0.0,
      passengers: json['passengers'] ?? 0.0,
      photoUrls:
          json['photoUrls'] != null ? List<String>.from(json['photoUrls']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'size': size,
      'transmission': transmission,
      'fuel': fuel,
      'price': price,
      'city': city,
      'currencySymbol': currencySymbol,
      'order': order,
      'passengers': passengers,
      'photoUrls': photoUrls,
    };
  }

  static List<Car> sampleData = [
    Car(
      name: 'Tesla Model X',
      image: 'https://source.unsplash.com/random/?villa',
      size: 'SUV',
      transmission: 'Automatic',
      fuel: 'Batterie',
      price: '3000',
      currencySymbol: '\$',
      city: 'Oran',
      order: 0,
      passengers: 4,
      photoUrls: [
        'https://source.unsplash.com/random/?tesla',
        'https://source.unsplash.com/random/?tesla'
      ],
    ),
    Car(
      name: 'Volkswagen',
      image: 'https://source.unsplash.com/random/?villa',
      size: 'Sports',
      transmission: 'Manual',
      fuel: 'Diesel',
      price: '2500',
      currencySymbol: '\$',
      city: 'Alger',
      order: 0,
      passengers: 64,
      photoUrls: [
        'https://source.unsplash.com/random/?volkswagen',
        'https://source.unsplash.com/random/?volkswagen'
      ],
    ),
    Car(
      name: 'Volkswagen',
      image: 'https://source.unsplash.com/random/?villa',
      size: 'Sports',
      transmission: 'Manual',
      fuel: 'Diesel',
      price: '2500',
      currencySymbol: '\$',
      city: 'Alger',
      order: 0,
      passengers: 64,
      photoUrls: [
        'https://source.unsplash.com/random/?volkswagen',
        'https://source.unsplash.com/random/?volkswagen'
      ],
    ),
  ];
}
