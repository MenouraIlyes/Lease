import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lease/models/booking_steps.dart';
import 'package:lease/shared/constants.dart';

class SelectDestinationWidget extends StatelessWidget {
  const SelectDestinationWidget({super.key, required this.step});

  final BookingStep step;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: step == BookingStep.selectDestination ? 140 : 60,
        padding: const EdgeInsets.all(16.0),
        child: step == BookingStep.selectDestination
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Where to ?',
                      style: textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.0),
                        hintText: 'Search destination',
                        prefixIcon:
                            const Icon(FontAwesomeIcons.magnifyingGlass),
                        hintStyle: textTheme.labelMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        focusedBorder: kFocusedBorder,
                        enabledBorder: kEnabledBorder,
                        errorBorder: kErrorBorder,
                        focusedErrorBorder: kErrorBorder,
                      ),
                    ),
                  ],
                )
                    .animate(delay: const Duration(milliseconds: 300))
                    .fadeIn(duration: const Duration(milliseconds: 300)),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Where',
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    'Select destination',
                    style: textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
      ),
    );
  }
}
