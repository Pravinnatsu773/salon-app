import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salonapp/screens/home/domain/model/service_type_model.dart';
import 'package:salonapp/screens/store/data/store_repository_impl.dart';

part 'store_data_state.dart';

enum StoreType { service, product }

class StoreDataCubit extends Cubit<StoreDataState> {
  StoreDataCubit() : super(StoreDataInitial());

  final _storeRepositoryImpl = StoreRepositoryImpl();

  getServiceOrProduct(StoreType type) async {
    final result = await _storeRepositoryImpl.getServiceOrProduct();

    result.fold((error) => null, (successData) {
      try {
        if (successData != null && successData.data['data'] != null) {
          final serviceTypeData =
              serviceTypesModelFromJson(successData.data['data']);
          emit(StoreDataFetched(data: serviceTypeData));
        }
      } catch (e) {
        print(e);
      }
    });
  }
}
