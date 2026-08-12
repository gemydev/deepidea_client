import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../support/presentation/widgets/sub_app_bar.dart';

class CustomCalendarPage extends StatefulWidget {
  const CustomCalendarPage({super.key});

  @override
  State<CustomCalendarPage> createState() => _CustomCalendarPageState();
}

class _CustomCalendarPageState extends State<CustomCalendarPage> {
  late final ValueNotifier<DateTime> _selectedDate;
  late final CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _selectedDate = ValueNotifier(DateTime.now());
    _calendarFormat = CalendarFormat.month;
  }

  @override
  void dispose() {
    _selectedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          children: [
            const SubAppBar(title: "التقويم"),
            SizedBox(height: 10),
            Container(
              color: CustomColorsManager.white,
              child: Column(children: [_buildCalendarHeader(), _buildCalendar()]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomImage(imagePath: CustomAssetsManager.calendarBlue, height: 25),
              SizedBox(width: 5),
              CustomText(
                "الاثنين ,اكتوبر 2024",
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.code, size: 30, color: CustomColorsManager.appRed),
            onPressed: () {
              // Go to the next month
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      locale: "ar",
      firstDay: DateTime.utc(2000),
      lastDay: DateTime.utc(2050),
      focusedDay: _selectedDate.value,
      calendarFormat: _calendarFormat,
      calendarBuilders: CalendarBuilders(
        // Customize the day cells
        defaultBuilder: (context, day, focusedDay) {
          return _buildDayCell(day);
        },
        todayBuilder: (context, day, focusedDay) {
          return _buildDayCell(day, isToday: true);
        },
        selectedBuilder: (context, day, focusedDay) {
          return _buildDayCell(day, isSelected: true);
        },
      ),
      headerVisible: false,
      rowHeight: 80,
      // We'll use a custom header
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate.value = selectedDay;
        });
      },
    );
  }

  Widget _buildDayCell(DateTime day, {bool isToday = false, bool isSelected = false}) {
    bool isContract = [3, 7, 10, 20, 30].contains(day.day); // Example days for "عقد"
    bool isCase = [3, 20, 7].contains(day.day); // Example days for "قضية"

    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? CustomColorsManager.darkYellowColor
                  : isToday
                  ? CustomColorsManager.darkYellowColor
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${day.day}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isToday ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          Column(
            children: [
              if (isCase)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: CustomColorsManager.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CustomText(
                    "قضية",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              if (isContract)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: CustomColorsManager.appGreen,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CustomText(
                    "عقد",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
