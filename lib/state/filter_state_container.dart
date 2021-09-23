import 'package:flutter/material.dart';
import 'package:rw_courses/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterStateContainer extends StatefulWidget {
  final Widget child;

  const FilterStateContainer({Key? key, required this.child}) : super(key: key);

  @override
  FilterStateContainerState createState() =>FilterStateContainerState();

  static FilterStateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_FilterInheritedWidget>()!
        .state;
  }
}

class FilterStateContainerState extends State<FilterStateContainer> {
  int filterValue = Constants.allFilter;
  late SharedPreferences _prefs;

  @override
  void initState(){
    super.initState();

    _loadValue();
  }

  _loadValue(){
    SharedPreferences.getInstance().then((value){
      _prefs = value;
      setState(() {
        filterValue = _prefs.getInt(Constants.filterKey);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _FilterInheritedWidget(state: this, child: widget.child);
  }

  void updateFilterValue(int value) {
    setState(() {
      _prefs.setInt(Constants.filterKey, value);
      filterValue = value;
    });
  }
}

class _FilterInheritedWidget extends InheritedWidget {
  final FilterStateContainerState state;

  const _FilterInheritedWidget(
  {
    Key? key,
    required this.state,
    required Widget child,
}
) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
