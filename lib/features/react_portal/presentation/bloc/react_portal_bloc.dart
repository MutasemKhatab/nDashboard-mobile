import 'dart:async';

import 'react_portal_event.dart';
import 'react_portal_state.dart';

class ReactPortalBloc {
  final StreamController<ReactPortalEvent> _eventController =
      StreamController<ReactPortalEvent>();
  final StreamController<ReactPortalState> _stateController =
      StreamController<ReactPortalState>.broadcast();

  Stream<ReactPortalState> get stream => _stateController.stream;

  ReactPortalBloc() {
    _eventController.stream.listen(_mapEventToState);
    _stateController.add(ReactPortalInitial());
  }

  void dispatch(ReactPortalEvent event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  void _mapEventToState(ReactPortalEvent event) {
    if (event is LoadStartedEvent) {
      _stateController.add(ReactPortalLoading());
    } else if (event is LoadFinishedEvent) {
      _stateController.add(ReactPortalLoaded());
    } else if (event is JsMessageReceivedEvent) {
      _stateController.add(ReactPortalJsMessageState(event.message));
    }
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
