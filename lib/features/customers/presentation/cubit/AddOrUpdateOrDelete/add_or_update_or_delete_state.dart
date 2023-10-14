part of 'add_or_update_or_delete_cubit.dart';

sealed class AddOrUpdateOrDeleteStates extends Equatable {
  const AddOrUpdateOrDeleteStates();

  @override
  List<Object> get props => [];
}

final class AddOrUpdateOrDeleteInitialState extends AddOrUpdateOrDeleteStates {}

final class AddOrUpdateOrDeleteLoadingState extends AddOrUpdateOrDeleteStates {}

final class AddOrUpdateOrDeleteSuccessState extends AddOrUpdateOrDeleteStates {
  final String message;

  const AddOrUpdateOrDeleteSuccessState({required this.message});
}

final class AddOrUpdateOrDeleteErrorState extends AddOrUpdateOrDeleteStates {
    final String message;

  const AddOrUpdateOrDeleteErrorState({required this.message});

}
