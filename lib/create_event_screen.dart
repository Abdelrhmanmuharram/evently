import 'package:evently/models/category_model.dart';
import 'package:evently/tabs/home/tab_item.dart';
import 'package:evently/widgets/arrow_back.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'app_theme.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/create-event';
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int currentIndex = 0;
  CategoryModel selectedCategory = CategoryModel.categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: ArrowBack(), title: Text('Add event')),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.line),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/${selectedCategory.imageName}.png',
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
                          label: category.name,
                          icon: category.icon,
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
                    if(currentIndex == index) return;
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
                  Text('Title', style: textTheme.titleMedium),
                  DefaultTextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.length < 2) {
                        return 'Please enter your title';
                      }
                      return null;
                    },
                    hintText: 'Event title',
                  ),
                  const SizedBox(height: 4),
                  Text('Description', style: textTheme.titleMedium),
                  DefaultTextFormField(
                    validator: (value) {
                      if (value == null || value.length < 2) {
                        return 'Please enter your description';
                      }
                      return null;
                    },
                    hintText: 'Event description',
                    maxLine: 5,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/calendar.svg'),
                      const SizedBox(width: 8),
                      Text('Event Date', style: textTheme.titleMedium),
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
                              ? 'Choose date'
                              : dateFormat.format(selectedDate!),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/clock.svg'),
                      const SizedBox(width: 8),
                      Text('Event Time', style: textTheme.titleMedium),
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
                          selectedTime?.format(context) ?? 'Choose time',
                        ),
                      ),
                    ],
                  ),
                  DefaultElevatedButton(
                    onPressed: createEvent,
                    label: 'Add event',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createEvent() {
    formKey.currentState!.validate();
  }
}
