import 'package:flutter/material.dart';
import 'package:sgela_services/data/subject.dart';
import 'package:sgela_services/sgela_util/functions.dart';
import 'package:sgela_shared_widgets/util/gaps.dart';
import 'package:sgela_shared_widgets/util/styles.dart';

class SubjectFilterWidget extends StatefulWidget {
  final List<Subject> subjects;
  final Function(Subject) onSelected;

  const SubjectFilterWidget(
      {super.key, required this.subjects, required this.onSelected});

  @override
  _SubjectFilterWidgetState createState() => _SubjectFilterWidgetState();
}

class _SubjectFilterWidgetState extends State<SubjectFilterWidget> {
  late List<Subject> filteredSubjects;
  late TextEditingController searchController;
  static const mm = '💜💜💜💜SubjectFilterWidget💜';

  @override
  void initState() {
    super.initState();
    filteredSubjects = widget.subjects;
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterSubjects(String query) {
    pp('$mm filtering $query ...');

    setState(() {
      if (query.isEmpty) {
        filteredSubjects = widget.subjects;
      } else {
        filteredSubjects = widget.subjects
            .where((subject) =>
                subject.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 140,
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: searchController,
                onChanged: (m) {
                  filterSubjects(m);
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                ),
              ),
            ),
            gapH16,
            SizedBox(
              width: 400,
              child: DropdownButton<Subject>(
                items: filteredSubjects.map((subject) {
                  return DropdownMenuItem<Subject>(
                    value: subject,
                    child: Padding(
                        padding: const EdgeInsets.only(left:16,right:16,),
                        child: Text(subject.title!,
                            style: myTextStyleSmall(context)))
                  );
                }).toList(),
                onChanged: (selectedSubject) {
                  // Handle the selected subject
                  if (selectedSubject != null) {
                    widget.onSelected(selectedSubject);
                  }
                },
              ),
            )
          ],
        ));
  }
}
