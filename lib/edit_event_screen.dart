import 'package:evently/providers/settings_provider.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/action_item.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'firebase_service.dart';
import 'home_screen.dart';
import 'l10n/app_localizations.dart';
import 'models/category_model.dart';
import 'models/event_model.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = '/edit-event';
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  int currentIndex = 0;
  EventModel? currentEvent;
  CategoryModel selectedCategory = CategoryModel.categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? imageName;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  bool initialization = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (!initialization) {
      currentEvent = ModalRoute.of(context)!.settings.arguments as EventModel;
      titleController.text = currentEvent!.title;
      descriptionController.text = currentEvent!.description;
      imageName = currentEvent!.category.type;
      selectedCategory = currentEvent!.category;
      selectedDate = currentEvent!.dateTime;
      selectedTime = TimeOfDay(
        hour: currentEvent!.dateTime.hour,
        minute: currentEvent!.dateTime.minute,
      );
      currentIndex = CategoryModel.categories.indexOf(currentEvent!.category);
    }
    initialization = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: ActionItem(
          svgPicture: settingsProvider.isArabic
              ? settingsProvider.isDark
                    ? 'arrow_right'
                    : 'arrow_right_light'
              : settingsProvider.isDark
              ? 'arrow_back_light'
              : 'arrow_back',
        ),
        title: Text(appLocalizations.editEvent),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: settingsProvider.isDark
                        ? AppTheme.borderDark
                        : AppTheme.line,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: settingsProvider.isDark
                      ? Image.asset(
                          'assets/images/${selectedCategory.type}_dark.png',
                          width: double.infinity,
                          fit: .fill,
                        )
                      : Image.asset(
                          'assets/images/${selectedCategory.type}.png',
                          width: double.infinity,
                          fit: .fill,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DefaultTabController(
                length: CategoryModel.categories.length,
                child: TabBar(
                  tabs: CategoryModel.categories
                      .map(
                        (category) => TabItem(
                          label: category.getName(
                            AppLocalizations.of(context)!,
                          ),
                          iconPath: category.iconPath,
                          isSelected:
                              currentIndex ==
                              CategoryModel.categories.indexOf(category),
                        ),
                      )
                      .toList(),
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  labelColor: AppTheme.primary,
                  unselectedLabelColor: AppTheme.secondText,
                  labelPadding: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  tabAlignment: .start,
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    selectedCategory = CategoryModel.categories[currentIndex];
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(appLocalizations.title, style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  DefaultTextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.length < 2) {
                        return appLocalizations.pleaseEnterYourTitle;
                      }
                      return null;
                    },
                    hintText: appLocalizations.eventTitle,
                  ),
                  const SizedBox(height: 4),
                  Text(appLocalizations.description, style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  DefaultTextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.length < 2) {
                        return appLocalizations.pleaseEnterYourDescription;
                      }
                      return null;
                    },
                    hintText: appLocalizations.eventDescription,
                    maxLine: 5,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/calendar.svg'),
                      const SizedBox(width: 8),
                      Text(appLocalizations.eventDate, style: textTheme.titleMedium),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            initialDate: selectedDate,
                            initialEntryMode: .calendarOnly,
                          );
                          if (date != null) {
                            selectedDate = date;
                            setState(() {});
                          }
                        },
                        child: Text(
                          selectedDate == null
                              ? appLocalizations.chooseDate
                              : dateFormat.format(selectedDate!),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/clock.svg'),
                      const SizedBox(width: 8),
                      Text(appLocalizations.eventTime, style: textTheme.titleMedium),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: selectedTime ?? TimeOfDay.now(),
                            initialEntryMode: .dialOnly,
                          );
                          if (time != null) {
                            selectedTime = time;
                            setState(() {});
                          }
                        },
                        child: Text(
                          selectedTime?.format(context) ?? appLocalizations.chooseTime,
                        ),
                      ),
                    ],
                  ),
                  DefaultElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          selectedDate != null &&
                          selectedTime != null) {
                        DateTime date = DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedTime!.hour,
                          selectedTime!.minute,
                        );
                        EventModel event = EventModel(
                          id: currentEvent!.id,
                          category: selectedCategory,
                          title: titleController.text,
                          description: descriptionController.text,
                          dateTime: date,
                        );
                        FirebaseService.editEvent(event).then(
                          (_) => Navigator.of(
                            context,
                          ).pushNamed(HomeScreen.routeName),
                        );
                      }
                    },
                    label: appLocalizations.editEvent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
