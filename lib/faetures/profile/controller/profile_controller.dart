import 'package:get/get.dart';
import 'package:lexi_learn/data/providers/user_provider.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/firestore_provider.dart';

class ProfileController extends GetxController{
  FireStoreProvider fireStore = FireStoreProvider();
  UserProvider auth = UserProvider();
  Stream<UserModel?> getUserStream() {
    return fireStore.getDataByUserID(collectionName: "lexi_learn_users", fromJson: UserModel.fromJson);
  }

}