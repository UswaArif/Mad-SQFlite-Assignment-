//name of table in database
import 'package:flutter/material.dart';

final String tableUsers = 'users';
//database table of user's attributes name
class UserFields{
  static final List<String> values = [
    id,fullName,phone,address,email,password,role,created_at,updated_at,active
  ];

  static final String id = '_id';
  static final String fullName = 'fullName';
  static final String phone = 'phone';
  static final String address = 'address';
  static final String email = 'email';
  static final String password = 'password';
  static final String role = 'role';
  static final String created_at = 'createdAt';
  static final String updated_at = 'updatedAt';
  static final String active = 'active';
}

class UserModel{
  final int? id;
  final String fullName;
  final int phone;
  final String address;
  final String email;
  final String password;
  final String role;
  final DateTime created_at;
  final DateTime updated_at;
  final bool active;

  const UserModel({
    this.id, 
    required this.fullName,
    required this.phone,
    required this.address,
    required this.email,
    required this.password,
    required this.role,
    required this.created_at,
    required this.updated_at,
    required this.active,
  });

  Map<String, Object?> toJson() => {
    UserFields.id: id,
    UserFields.fullName: fullName,
    UserFields.phone: phone,
    UserFields.address: address,
    UserFields.email: email,
    UserFields.password: password,
    UserFields.role: role,
    UserFields.created_at: created_at.toIso8601String(),
    UserFields.updated_at: updated_at.toIso8601String(),
    UserFields.active: active ? 1 : 0,
  }; 

  UserModel copy({
    int? id,
    String? fullName,
    int? phone,
    String? address,
    String? email,
    String? password,
    String? role,
    DateTime? created_at,
    DateTime? updated_at,
    bool? active,
  }) => 
      UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        email:  email ?? this.email,
        password: password ?? this.password,
        role: role ?? this.role,
        created_at:  created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        active: active ?? this.active,
      );

  static UserModel fromJson(Map<String, Object?> json) => UserModel(
    id: json[UserFields.id] as int?,
    fullName: json[UserFields.fullName] as String,
    phone: json[UserFields.phone] as int,
    address: json[UserFields.address] as String,
    email: json[UserFields.email] as String,
    password: json[UserFields.password] as String,
    role: json[UserFields.role] as String,
    created_at: DateTime.parse(json[UserFields.created_at] as String),
    updated_at: DateTime.parse(json[UserFields.updated_at] as String),
    active: json[UserFields.active] == 1,
  );
}