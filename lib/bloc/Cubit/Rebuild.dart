
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPageRebuild extends Cubit<bool> {
  BlocPageRebuild() : super(true);
  bool isDarkTheme = false;

  //! not rebuild app bar and left menu
  void rebuildPage() {
    emit(!state);
  }

}


