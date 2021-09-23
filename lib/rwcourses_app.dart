import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rw_courses/strings.dart';
import 'package:rw_courses/ui/courses/courses_page.dart';
import 'package:rw_courses/ui/filter_page/filter.dart';

class RWCoursesApp extends StatelessWidget {
  const RWCoursesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(Strings.appTitle),
        actions: [
          IconButton(onPressed: ()=>
              Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FilterPage(),
            ),
          ), icon:
          const Icon(Icons.filter_list))
        ],
      ),
      body: const CoursesPage(),
    );
  }
}
