import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:lease/models/booking_steps.dart';
import 'package:lease/shared/colors.dart';
import 'package:lease/widgets/app_calendar.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({super.key, required this.step});

  final BookingStep step;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    // 112 = app bar height + safe area top padding,
    // 60 = destination selection collapsed height,
    // 32 = top/bottom padding
    // 16 = margin below each card
    var expandedHeight = size.height - 250 - 60 - 32 - 16;
    return Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: step == BookingStep.selectDate ? expandedHeight : 60,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: step == BookingStep.selectDate
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'When\'s your trip ?',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(child: CalendarOptionsSegmentedButton()),
                        ],
                      ),
                      AppCalendar(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Skip',
                              style: TextStyle(color: appBlue),
                            ),
                          ),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: appBlue,
                              minimumSize: const Size(120, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Next'),
                          )
                        ],
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
                      'When',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Select date',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
    );
  }
}
