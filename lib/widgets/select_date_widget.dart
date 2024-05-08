import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:lease/models/booking_steps.dart';
import 'package:lease/providers/reservation_provider.dart';
import 'package:lease/widgets/app_calendar.dart';
import 'package:provider/provider.dart';

class SelectDateWidget extends StatefulWidget {
  const SelectDateWidget({Key? key, required this.step});

  final BookingStep step;

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var expandedHeight = size.height - 350 - 60 - 32 - 16;
    return Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: widget.step == BookingStep.selectDate ? expandedHeight : 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: widget.step == BookingStep.selectDate
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
                    AppCalendar(
                      onSelectionChanged: (startDate, endDate) {
                        /// Store start date and end date in ReservationProvider
                        // Handle nullable DateTime values before passing them to the provider
                        final nonNullStartDate = startDate ?? DateTime.now();
                        final nonNullEndDate = endDate ?? DateTime.now();

                        // Pass non-nullable DateTime values to the provider methods
                        Provider.of<ReservationProvider>(context, listen: false)
                            .setStartDate(nonNullStartDate);
                        Provider.of<ReservationProvider>(context, listen: false)
                            .setEndDate(nonNullEndDate);
                      },
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
              ),
      ),
    );
  }
}
