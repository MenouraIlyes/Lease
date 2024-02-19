import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lease/shared/colors.dart';

class CarTypeList extends StatefulWidget {
  const CarTypeList({super.key});

  @override
  State<CarTypeList> createState() => _CarTypeListState();
}

class _CarTypeListState extends State<CarTypeList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;

    final List<Map<String, dynamic>> carTypes = [
      {'type': 'Cars', 'icon': FontAwesomeIcons.car},
      {'type': 'SUVs', 'icon': FontAwesomeIcons.car},
      {'type': 'Vans', 'icon': FontAwesomeIcons.vanShuttle},
      {'type': 'Trucks', 'icon': FontAwesomeIcons.truck},
      {'type': 'Lux', 'icon': FontAwesomeIcons.car},
    ];
    return SizedBox(
      height: 54.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: carTypes.length,
        itemBuilder: (context, index) {
          return Container(
            width: size.width * 0.2,
            margin: const EdgeInsets.only(
              right: 4.0,
              left: 4.0,
              top: 4.0,
            ),
            child: Column(
              children: [
                Icon(
                  carTypes[index]['icon'],
                ),
                Text(
                  carTypes[index]['type'],
                  style: textTheme.bodySmall!.copyWith(
                    fontWeight: (index == selectedIndex)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                (index == selectedIndex)
                    ? Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        height: 2.0,
                        width: 64.0,
                        color: appBlue,
                      )
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}
