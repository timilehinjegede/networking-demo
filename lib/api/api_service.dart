import 'package:networkingdemo/api/api_url.dart';
import 'package:networkingdemo/models/album.dart';
import 'package:networkingdemo/models/comment.dart';
import 'package:networkingdemo/models/photo.dart';
import 'package:networkingdemo/models/post.dart';
import 'package:networkingdemo/models/todo.dart';
import 'package:networkingdemo/models/user.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<Album>> fetchAlbums() async {
    final response = await http.get(ApiUrls.albums);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }

  static Future<List<Album>> fetchAlbumsWithId(int id) async {
    Map<String, String> queryParameters = {'userId': '$id'};

    var uri = Uri.https(ApiUrls.baseURL, '/albums', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(ApiUrls.users);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(ApiUrls.posts);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('failed to load album');
    }
  }

  static Future<List<Comment>> fetchCommentsWithId(int id) async {
    Map<String, String> queryParameters = {'postId': '$id'};

    var uri = Uri.https(ApiUrls.baseURL, '/comments', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('failed to load comment');
    }
  }

  static Future<List<Photo>> fetchPhotosWithId(int id) async {
    Map<String, String> queryParameters = {
      'albumId': '$id',
    };

    var uri = Uri.https(ApiUrls.baseURL, '/photos', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      throw Exception('failed to load photo');
    }
  }

  static Future<List<Todo>> fetchTodos(int id) async {
    Map<String, String> queryParameters = {'userId': '$id'};

    var uri = Uri.https(ApiUrls.baseURL, '/todos', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('failed to load todo');
    }
  }
}
