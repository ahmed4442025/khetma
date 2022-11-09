part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HSPageIndex extends HomeState {}

class HSLastRead extends HomeState {}


class HSGroupChange extends HomeState {}