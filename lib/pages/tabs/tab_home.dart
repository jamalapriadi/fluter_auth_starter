
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/login/login_cubit.dart';
import '../../cubit/post/post_cubit.dart';
import '../../cubit/post/post_state.dart';
import '../../cubit/profile/profile_cubit.dart';
import '../../cubit/profile/profile_state.dart';
import '../../helpers/constant.dart';
import '../../models/menu/menu_service.dart';
import '../../repositories/guest_repository.dart';
import '../components/loading_widget.dart';
import '../post/post_by_id.dart';


class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {


  final loginCubit = LoginCubit();
  GuestRepository guestRepository = GuestRepository();

  final List<MenuService> _menuService = [];

  final profileCubit = ProfileCubit();
  final postCubit = PostCubit();

  @override
  void initState() {
    profileCubit.getProfile();
    postCubit.getData();

    super.initState();

    _menuService.add(MenuService(
      image: Icons.menu_book,
      color: Warna.putih,
      title:'Menu 1'
    ));

    _menuService.add(MenuService(
      image: Icons.calendar_month,
      color: Warna.putih,
      title:'Menu 2'
    ));

    _menuService.add(MenuService(
      image: Icons.image,
      color: Warna.putih,
      title:'Menu 3'
    ));

    _menuService.add(MenuService(
      image: Icons.abc_outlined,
      color: Warna.putih,
      title:'Menu 4'
    ));
  }

  

  Widget _buildAppBar() {
    return BlocProvider<ProfileCubit>(
          create: (context) => profileCubit,
          child: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is FailureProfileState) {
              } else if (state is SuccessProfileState) {}
            },
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is SuccessProfileState) {

                  return AppBar(
                    centerTitle: true,
                    backgroundColor: Warna.kuning,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Image(
                              image: CachedNetworkImageProvider(
                                state.listProfile.profilePicture.toString(),
                              ),
                              fit: BoxFit.cover,
                              loadingBuilder: (context, imageProvider, loadingProgress) {
                                if (loadingProgress == null) return imageProvider;
                                return const Center(child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, trace) {
                                return const Center(child: Icon(Icons.image));
                              },
                            
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Welcome,', style: TextStyle(fontSize: 12, color: Colors.white),),
                              Text(state.listProfile.name.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
                            ],
                          )
                        ],
                      ),
                    ),
                    // leading: ,
                    actions: [
                      Padding(padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap:(){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Confirm Logout'),
                                content: const Text('Are you sure you want to log out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); 

                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      guestRepository.signOut();
                                      
                                      Navigator.pushReplacementNamed(context, "/login");
                                      // Perform your desired action here
                                    },
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Padding(
                          padding:  EdgeInsets.all(2),
                          child: CircleAvatar(
                            radius:20,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.logout_outlined,color: Colors.black87, size: 20,),
                          )
                        ),
                      )),
                    ],
                  );
                } else if (state is LoadingProfileState) {
                  return AppBar(
                    centerTitle: true,
                    backgroundColor: Warna.kuning,
                    title: const Text('', style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:Colors.white),),
                    leading: const Padding(
                      padding: EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://www.svgrepo.com/show/382097/female-avatar-girl-face-woman-user-9.svg', // Replace with the actual profile avatar URL
                        ),
                      ),
                    ),
                    actions: [
                      Padding(padding: const EdgeInsets.all(5),
                      child: InkWell(
                              onTap:(){
                                
                              },
                              child: Padding(
                                padding:  const EdgeInsets.all(2),
                                child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(3.0)),
                                            ),
                                        alignment: Alignment.center,
                                        child:Icon(Icons.logout,color: Warna.putih,),
                                      ),
                              ),
                            )),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Warna.kuning,
        automaticallyImplyLeading: false,
        flexibleSpace: _buildAppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Warna.putih
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: <Widget>[
                Container(
                  height: 90.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Warna.kuning,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                  ),
                ),

                Container(
                  color: Warna.kuning, // Set the background color
                  padding: const EdgeInsets.only(left: 16,right: 16, bottom: 16, top: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Warna.putih,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)
                        ),
                      ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                      child: _buildMenuService(),
                    ),
                  ),
                ),
              ]),

              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 2),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Latest News', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    ),
                    Expanded(flex: 1,child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('See All'),
                    ),)
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: _buildListPosts(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuService(){
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Container(
        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: GridView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: _menuService.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4),
          itemBuilder: (context, position){
            return _rowService(_menuService[position]);
          },
        ),
      ),
    ); 
  }

  Widget _rowService(MenuService items){
    return InkWell(
      onTap: (){
        
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color:Warna.hitam, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              color: Warna.putih
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              items.image,
              color: Colors.black87,
              size: 32,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
          ),
          Text(items.title.toString())
        ],
      )
    );
  }

  Widget _buildListPosts(){
    return BlocProvider<PostCubit>(
      create: (context) => postCubit,
      child: BlocListener<PostCubit, PostState>(
        listener: (context, state){

        },
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state){
            if(state is SuccessPostState){
              List<dynamic> posts = state.lists;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(1),
                child: SizedBox(
                  height: 600,
                  child: _buildPost(posts),
                ),
              );
            }else if(state is LoadingPostState){
              return Container(
                color: Warna.putih,
                child: const LoadingWidget(),
              );
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPost(List<dynamic> post){
    return ListView.builder(
      itemCount: post.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  PostById(postId: post[index].slug.toString(),), fullscreenDialog: true));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex:1, child: Card(
                  child: SizedBox(
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: CachedNetworkImageProvider(
                          post[index].featuredImage.toString(),
                        ),
                        fit: BoxFit.cover,
                        loadingBuilder: (context, imageProvider, loadingProgress) {
                          if (loadingProgress == null) return imageProvider;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, trace) {
                          return const Center(child: Icon(Icons.image));
                        },
                      
                      ),
                    ),
                  ),
                )),
                const SizedBox(width: 15,),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(post[index].title.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(post[index].createdAtHuman.toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  
  
}
