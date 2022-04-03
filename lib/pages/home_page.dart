import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_test_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:sign_in_test_app/components/custom_app_bar.dart';
import 'package:sign_in_test_app/middlewares/auth_middleware.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthBloc authBloc;

  @override
  void didChangeDependencies() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AuthMiddleware(
      child: Scaffold(
        appBar: CustomAppBar(
          titleText: 'Home',
          actions: [
            TextButton(
              onPressed: () {
                authBloc.add(SignOutRequested());
              },
              child: Text('Sign out'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserPicture(),
                Container(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(height: 20),
                    Text(FirebaseAuth.instance.currentUser?.displayName ??
                        'Empty Name'),
                    Container(height: 5),
                    Text(FirebaseAuth.instance.currentUser!.email!),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserPicture extends StatefulWidget {
  const UserPicture({Key? key}) : super(key: key);

  @override
  State<UserPicture> createState() => _UserPictureState();
}

class _UserPictureState extends State<UserPicture> {
  User user = FirebaseAuth.instance.currentUser!;

  get _size => 80.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: user.photoURL != null
          ? Image.network(user.photoURL!)
          : Container(
              decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            )),
    );
  }
}
