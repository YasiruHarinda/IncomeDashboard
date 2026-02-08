import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:assert_repository/assert_repository.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoriesBloc
    extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final AssertRepository assertRepository;

  GetCategoriesBloc(this.assertRepository)
      : super(GetCategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      emit(GetCategoriesLoading());
      try {
        final categories = await assertRepository.getCategory();
        emit(GetCategoriesSuccess(categories));
      } catch (e) {
        emit(GetCategoriesFailure());
      }
    });
  }
}
