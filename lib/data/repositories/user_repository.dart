import 'package:appwrite/appwrite.dart';
import 'package:users/core/constants/appwrite_constants.dart';
import 'package:users/model/user_model.dart';

class UserRepository {
  final Databases databases;

  UserRepository(this.databases);

  Future<UserModel> createUser(UserModel user) async {
    try {
      final response = await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
        documentId: ID.unique(),
        data: user.toJson(),
      );

      // Modificamos cómo accedemos a los datos
      Map<String, dynamic> userData = {
        '\$id': response.$id,  // Aseguramos que el ID se incluya correctamente
        'username': response.data['username'],
        'email': response.data['email'],
      };

      print('Response data: $userData'); // Para depuración
      return UserModel.fromJson(userData);
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
      );

      return response.documents
          .map((doc) => UserModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> eliminarUsuario(String documentId) async {
    try {
      await databases.deleteDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
        documentId: documentId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> actualizarUsuario(String documentId, UserModel usuario) async {
    try {
      final response = await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
        documentId: documentId,
        data: usuario.toJson(),
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
