import 'package:flutter/material.dart';
import 'package:rw_courses/constants.dart';
import 'package:rw_courses/model/course.dart';
import 'package:rw_courses/repository/course_repository.dart';
import 'package:rw_courses/state/filter_state_container.dart';
import 'package:rw_courses/ui/course_detail/course_detail_page.dart';
import 'package:rw_courses/ui/courses_controller.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final _controller = CoursesController(CourseRepository());
 late FilterStateContainerState state;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = FilterStateContainer.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
        future: _controller.fetchCourses(state.filterValue),
        builder: (context, snapshot) {
          var courses = snapshot.data;
          if (courses == null || snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int position) {
              return _buildRow(courses[position]);
            },
            padding: const EdgeInsets.all(16.0),
            itemCount: courses.length,
          );
        });
  }

  Widget _buildRow(Course course) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(
          course.name,
          style: const TextStyle(fontSize: 18.0),
        ),
        subtitle: Text(course.domainsString),
        trailing: Hero(
          tag: "cardArtWork-${course.courseId}",
          transitionOnUserGestures: true,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(course.artworkUrl),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CourseDetailsPage(course: course),
            ),
          );
        },
      ),
    );
  }
}
