import 'package:get/get.dart';

import 'package:users/model/user_model.dart';
import 'package:users/data/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository repository;
  
  // Estado reactivo
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  UserController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    getUsers();  // Changed from fetchUsers to getUsers
  }

  Future<void> getUsers() async {  // Renamed from fetchUsers to getUsers
    try {
      isLoading.value = true;
      final fetchedUsers = await repository.getUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      error.value = e.toString();
      users.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      final newUser = await repository.createUser(user);
      users.add(newUser);
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> updateUser(String id, UserModel user) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      await repository.actualizarUsuario(id, user);
      await getUsers();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      await repository.eliminarUsuario(id);
      await getUsers();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
