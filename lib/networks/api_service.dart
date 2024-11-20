import 'package:apps_architecture/dto/post_dto.dart';
import 'package:apps_architecture/networks/dio_client.dart';

class ApiService {
  final DioClient dioClient;
  ApiService(this.dioClient);

  Future<List<Post>> fetchList() async {
    final response = await dioClient.get('/posts');
    final List<Post> post =
        (response.data as List).map((item) => Post.fromJson(item)).toList();
    return post;
  }
}
