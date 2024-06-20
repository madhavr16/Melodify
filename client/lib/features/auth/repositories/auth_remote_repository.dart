import 'dart:convert';

import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    // Call the API to login
    try {
       final response = await http.post(
      Uri.parse(
        'http://10.0.2.2:8000/auth/signup'
      ),
      headers: {
        'Content-Type': 'application/json',
      
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      },)
    );
    final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 201) {
      return Left(AppFailure(resBodyMap['detail']));
    }
    return Right(UserModel(
      id: resBodyMap['id'],
      email: email,
      name: name,
    ));
    } catch (e) {
       return Left(AppFailure(e.toString()));
    }
   
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Call the API to register
    try {
       final response = await http.post(
        Uri.parse(
          'http://10.0.2.21:8000/auth/login'
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      print(response.body);
      print(response.statusCode);
    } catch (e) {
      print('Failed to login: $e');
    }
  }
}