import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/network/remote/dio_helper.dart';
import 'package:pet_app/view/clinics/data/models/add_book_model/add_book_model.dart';

part 'add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit() : super(AddBookInitial());

  static AddBookCubit get(context) => BlocProvider.of(context);

  AddBookModel? addBookModel;

  void userAddBook({required String? time, int? id}) async {
    emit(AddBookLoading());

    DioHelper.postData(
      url: 'https://pet-app.webbing-agency.com/api/clinic/$id/book-visit',
      data: {
        'time': time,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value != null) {
        addBookModel = AddBookModel.fromJson(value.data);
        print('Parsed status: ${addBookModel?.status}');
        print('Parsed message: ${addBookModel?.message}');
        print('Parsed id: ${addBookModel?.data?.book?.id}');
        emit(AddBookSuccess(addBookModel: addBookModel!));
      } else {
        emit(
          AddBookFailure(message: 'Null response received'),
        );
      }
    }).catchError((error) {
      emit(AddBookFailure(message: error.toString()));
    });
  }
}
