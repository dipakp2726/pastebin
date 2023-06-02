// ignore_for_file: one_member_abstracts

part of 'user_repository.dart';

/// An interface for UserRepository
abstract class IUserRepository {
  String get path;

  /// Get user Details
  Future<dynamic> profileSubmit(String name, String email);
}
