import 'package:accessories_app/data/model/profile_model.dart';
import 'package:accessories_app/data/source/auth_data_source.dart';
import 'package:accessories_app/data/source/prefs.dart';

class AuthRepository {
  AuthRepository({required AuthDataSource dataSource})
      : _dataSource = dataSource;

  final AuthDataSource _dataSource;

  Future<ProfileModel> fetchMe() async {
    final value = await _dataSource.fetchMe(await Preferences.getEmailActive());

    return ProfileModel(fullname: value.nama, email: value.email);
  }

  Future<String> login(String email, String password) async {
    final value = await _dataSource.login(email, password);
    if (value == "Sukses") {
      Preferences.setEmailActive(email);
    }
    return value;
  }

  Future<bool> register(ProfileModel profileModel) async {
    final value = await _dataSource.addUser(profileModel);
    return value;
  }
}
