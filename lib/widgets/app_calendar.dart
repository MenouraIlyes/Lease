import 'package:flutter/material.dart';
import 'package:lease/shared/colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum CalendarOptions { year, month, week, day }

class AppCalendar extends StatefulWidget {
  final Function(DateTime?, DateTime?) onSelectionChanged;

  const AppCalendar({Key? key, required this.onSelectionChanged})
      : super(key: key);

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      rangeSelectionColor: appBlue,
      endRangeSelectionColor: appBlue,
      startRangeSelectionColor: appBlue,
      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        setState(() {
          _startDate = args.value.startDate;
          _endDate = args.value.endDate;
        });
        widget.onSelectionChanged(_startDate, _endDate);
        print(_startDate);
        print(_endDate);
      },
      selectionMode: DateRangePickerSelectionMode.range,
      initialSelectedRange: PickerDateRange(
        DateTime.now().subtract(const Duration(days: 5)),
        DateTime.now().add(const Duration(days: 5)),
      ),
    );
  }
}

class CalendarOptionsSegmentedButton extends StatefulWidget {
  const CalendarOptionsSegmentedButton({super.key});

  @override
  State<CalendarOptionsSegmentedButton> createState() =>
      _CalendarOptionsSegmentedButtonState();
}

class _CalendarOptionsSegmentedButtonState
    extends State<CalendarOptionsSegmentedButton> {
  CalendarOptions selected = CalendarOptions.month;

  @override
  Widget build(BuildContext context) {
    return SegmentedButtonTheme(
      data: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return appBlue;
              }
              return appGrey.withAlpha(100);
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return appWhite;
              }
              return appBlack;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold);
              }
              return Theme.of(context).textTheme.bodyMedium!;
            },
          ),
        ),
      ),
      child: SizedBox(),
    );
  }
}
