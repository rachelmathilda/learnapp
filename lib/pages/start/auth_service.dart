import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  /**
   * APPLE
   */
  static Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your.client.id.service',
          redirectUri:
              kIsWeb
                  ? Uri.parse('https://${Uri.base.host}/')
                  : Uri.parse('https://your-backend.com/apple/callback'),
        ),
      );

      print('Apple credential (sign-in): ${credential.email}');
    } catch (e) {
      print("Apple Sign-In Error: $e");
    }
  }

  static Future<void> signUpWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your.client.id.service',
          redirectUri:
              kIsWeb
                  ? Uri.parse('https://${Uri.base.host}/')
                  : Uri.parse('https://your-backend.com/apple/callback'),
        ),
      );

      final email = credential.email;
      final idToken = credential.identityToken;

      if (email == null || idToken == null) {
        print('Missing email or identity token for Apple sign-up');
        return;
      }

      final response = await http.post(
        Uri.parse('https://your-backend.com/register/apple'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'identityToken': idToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('Apple Sign-Up success! User ID: ${data['id']}');
      } else {
        print('Apple Sign-Up failed: ${response.body}');
      }
    } catch (e) {
      print("Apple Sign-Up Error: $e");
    }
  }

  /**
   * GOOGLE
   */
  static Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user == null) {
        print('Google Sign-In aborted by user');
        return;
      }

      final GoogleSignInAuthentication auth = await user.authentication;
      print('Access Token: ${auth.accessToken}');
      print('ID Token: ${auth.idToken}');
      print('Email: ${user.email}');
    } catch (e) {
      print('Google Sign-In error: $e');
    }
  }

  static Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user == null) {
        print('Google Sign-Up aborted by user');
        return;
      }

      final GoogleSignInAuthentication auth = await user.authentication;

      final email = user.email;
      final idToken = auth.idToken;

      if (idToken == null) {
        print('Missing ID Token for Google Sign-Up');
        return;
      }

      final response = await http.post(
        Uri.parse('https://your-backend.com/register/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'idToken': idToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('Google Sign-Up success! User ID: ${data['id']}');
      } else {
        print('Google Sign-Up failed: ${response.body}');
      }
    } catch (e) {
      print('Google Sign-Up Error: $e');
    }
  }

  /**
   * NEON-DB
   */
  static Future<void> signInWithEmail(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-backend.com/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login success! Token: ${data['token']}');
      } else {
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      print("Email login error: $e");
    }
  }

  static Future<void> registerWithEmail(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-backend.com/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Registration success! User ID: ${data['id']}');
      } else {
        print('Registration failed: ${response.body}');
      }
    } catch (e) {
      print("Email registration error: $e");
    }
  }
}
