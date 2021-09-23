import 'package:rw_courses/model/course.dart';
import 'package:rw_courses/repository/course_repository.dart';
import 'package:rw_courses/repository/repository.dart';

class CoursesController{
  final Repository _repository;


  CoursesController(this._repository);

  Future<List<Course>> fetchCourses(int domainFilter){
    return _repository.getCourses(domainFilter);
  }
}