import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lease/models/booking_steps.dart';
import 'package:lease/shared/colors.dart';
import 'package:lease/shared/constants.dart';

class SelectTimeWidget extends StatefulWidget {
  const SelectTimeWidget({super.key, required this.step});

  final BookingStep step;

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  //Time
  TextEditingController pickupTimeValue =
      TextEditingController(text: availableTimes[0]);
  TextEditingController dropofTimeValue =
      TextEditingController(text: availableTimes[0]);
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    var expandedHeight = size.height - 473 - 60 - 32 - 16;

    return Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      child: AnimatedContainer(
        height: widget.step == BookingStep.selectTime ? expandedHeight : 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        duration: const Duration(milliseconds: 200),
        child: widget.step == BookingStep.selectTime
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'When ?',
                    style: textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    child: TextFormField(
                      onTap: () async {
                        final TimeOfDay? picked_s = await showTimePicker(
                          context: context,
                          initialTime: time,
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                                  // change the border color
                                  primary: appBlue,
                                  // change the text color
                                  onSurface: appBlue,
                                ),
                                // button colors
                                buttonTheme: ButtonThemeData(
                                  colorScheme: ColorScheme.light(
                                    primary: appBlue,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked_s != null) {
                          setState(() {
                            pickupTimeValue.text = picked_s.format(context);
                          });
                        }
                      },
                      controller: pickupTimeValue,
                      decoration: InputDecoration(
                        hintText: 'Pick up time',
                        labelText: 'Pick up time',
                        prefixIcon: Icon(Icons.access_time_rounded),
                        enabledBorder: kEnabledBorder,
                        focusedBorder: kFocusedBorder,
                        errorBorder: kErrorBorder,
                        focusedErrorBorder: kErrorBorder,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    child: TextFormField(
                        onTap: () async {
                          final TimeOfDay? picked_s = await showTimePicker(
                            context: context,
                            initialTime: time,
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    // change the border color
                                    primary: appBlue,
                                    // change the text color
                                    onSurface: appBlue,
                                  ),
                                  // button colors
                                  buttonTheme: ButtonThemeData(
                                    colorScheme: ColorScheme.light(
                                      primary: appBlue,
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked_s != null) {
                            setState(() {
                              dropofTimeValue.text = picked_s.format(context);
                            });
                          }
                        },
                        controller: dropofTimeValue,
                        decoration: InputDecoration(
                          hintText: 'Drop off time',
                          labelText: 'Drop off time',
                          prefixIcon: Icon(Icons.access_time_rounded),
                          enabledBorder: kEnabledBorder,
                          focusedBorder: kFocusedBorder,
                          errorBorder: kErrorBorder,
                          focusedErrorBorder: kErrorBorder,
                        )),
                  )
                ],
              )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 200))
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'When',
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    'Select time',
                    style: textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
      ),
    );
  }
}
