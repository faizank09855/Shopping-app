import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:transparent/admin_panel/repository/admin_panel_repository.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminAddItemEvent>((event, emit) async {
      emit(AdminInitial());
      emit(AdminLoadingState());
      try {
        AdminPanelRepository repository = AdminPanelRepositoryImpl();
        var data = await repository.addItemRepository(
            "", event.image, event.name, event.price , event.category);
        emit(AdminLoadedState());
      } catch (exception) {
        emit(AdminErrorState(error: exception.toString()));
      }
    });
  }
}
