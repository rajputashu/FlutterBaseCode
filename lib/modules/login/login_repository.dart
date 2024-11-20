import 'package:apps_architecture/database/dao/post_dao.dart';
import 'package:apps_architecture/database/entities/post_entity.dart';
import 'package:apps_architecture/networks/api_service.dart';

class LoginDaosSource {
  late final PostDao postDao;
  // Add other daos related to login
  LoginDaosSource(this.postDao);
}

class LoginRepository {
  late final ApiService apiService;
  late final LoginDaosSource daosSource;

  LoginRepository({required this.apiService, required this.daosSource});

  Future<List<PostEntity>> fetchPostsFromDB() async {
    // First, try to fetch from the API

    // final apiPosts = await apiService.fetchList();
    // print(apiPosts);

    await daosSource.postDao
        .insertUser(PostEntity(title: "Babu", body: "Hello Post Insertion"));
    return await daosSource.postDao.fetchAllPosts();
  }
}
