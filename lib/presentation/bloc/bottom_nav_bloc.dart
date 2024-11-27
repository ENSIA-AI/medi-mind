import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_mind/utils/pages_enum.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(HOMEPAGE_INDEX);
  changeSelectedPage(newPage) => emit(newPage);
}
