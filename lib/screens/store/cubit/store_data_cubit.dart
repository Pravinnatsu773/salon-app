import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salonapp/screens/home/data/home_service_repository_impl.dart';
import 'package:salonapp/screens/home/domain/model/service_type_model.dart';
import 'package:salonapp/screens/store/data/store_repository_impl.dart';
import 'package:salonapp/screens/store/domain/model/store_category.dart';

part 'store_data_state.dart';

enum StoreType { service, product }

class StoreDataCubit extends Cubit<StoreDataState> {
  StoreDataCubit() : super(StoreDataInitial());
  final _homeServiceRepositoryImpl = HomeServiceRepositoryImpl();

  final _storeRepositoryImpl = StoreRepositoryImpl();

  List<StoreCategory> categories = [];

  getCategories() async {
    final result = await _storeRepositoryImpl.getCategories();

    result.fold((error) {
      print(error);
    }, (successData) {
      try {
        if (successData != null && successData.data['data'] != null) {
          categories = [
            StoreCategory(id: "", text: "All"),
            ...storeCategoryFromJson(successData.data['data'])
          ];
        }
      } catch (e) {
        print(e);
      }
    });
  }

  getServiceOrProduct(String selectedCategory) async {
    emit(StoreDataInitial());
    final result =
        await _storeRepositoryImpl.getServiceOrProduct(selectedCategory);

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
