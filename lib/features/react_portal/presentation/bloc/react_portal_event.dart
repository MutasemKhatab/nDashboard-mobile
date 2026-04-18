abstract class ReactPortalEvent {}

class LoadStartedEvent extends ReactPortalEvent {}

class LoadFinishedEvent extends ReactPortalEvent {}

class JsMessageReceivedEvent extends ReactPortalEvent {
  final String message;
  JsMessageReceivedEvent(this.message);
}
