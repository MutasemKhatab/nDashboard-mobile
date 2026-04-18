abstract class ReactPortalState {}

class ReactPortalInitial extends ReactPortalState {}

class ReactPortalLoading extends ReactPortalState {}

class ReactPortalLoaded extends ReactPortalState {}

class ReactPortalJsMessageState extends ReactPortalState {
  final String message;
  ReactPortalJsMessageState(this.message);
}
