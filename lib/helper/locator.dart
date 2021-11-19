import 'package:flutter_todo_app/cubit/edit_todo_cubit.dart';
import 'package:flutter_todo_app/cubit/todo_cubit.dart';
import 'package:flutter_todo_app/data/todo_data.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/*
  GetIt cung cấp các mẫu pattern: Singleton, Factory..
*/
Future<void> setupLocator() async {
  /*
    dùng Singleton để  đảm bảo chỉ tạo ra 1 instance của class từ khi run app
    tại mỗi chỗ có khởi tạo lại hay dùng đến thì sẽ chỉ dùng với instance ban đầu đã tạo

    Ở trường hợp này thì đảm bảo cho dữ liệu trong TodoCubit (hiển thị listview ở home) được nhất quán
    khi thao tác delete, create, edit ở TodoPage

    => để sử dụng thì phải gọi setupLocator này ngay lúc run app ở hàm main để có sẵn instance sử dụng sau

    TodoCubit là param truyền vào constructor của EditTodoCubit
    nên phải khởi tạo instance của TodoCubit trước
  
  */
  getIt.registerSingleton(TodoCubit());
  getIt.registerSingleton(EditTodoCubit(getIt<TodoCubit>()));
  //getIt.registerSingleton(instance)
}
