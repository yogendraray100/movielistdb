import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/src/bloc/moviebloc/movie_bloc.dart';
import 'package:project1/src/bloc/moviebloc/movie_bloc_event.dart';
import 'package:project1/src/bloc/moviebloc/movie_bloc_state.dart';
import 'package:project1/src/model/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(MovieEventStarted(0, '')),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(
            Icons.menu,
            color: Colors.black45,
          ),
          title: Text(
            'movies-db'.toUpperCase(),
            style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://previews.123rf.com/images/ylivdesign/ylivdesign1211/ylivdesign121100088/16526995-blue-movie-logo-on-a-black-background.jpg"),
              ),
            )
          ],
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
                if (state is MovieLoading) {
                  return Center(
                    child: Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                  );
                } else if (state is MovieLoaded) {
                  List<Movie> movies = state.movieList;
                  print(movies.length);
                  return Column(
                    children: [
                      CarouselSlider.builder(
                          itemCount: movies.length,
                          itemBuilder: (BuildContext context, int index) {
                            Movie movie = movies[index];
                            return Stack(
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https//image.tmdb.org/t/p/original/${movie.backdropPath}',
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Platform.isAndroid
                                            ? CircularProgressIndicator()
                                            : CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://fisnikde.com/wp-content/uploads/2019/01/broken-image.png'))),
                                    ),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )
                              ],
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(microseconds: 500),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          ))
                    ],
                  );
                } else {
                  return Container(
                    child: Text("Something went wrong"),
                  );
                }
              })
            ],
          ),
        ),
      );
    });
  }
}
