import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../presentation/bloc/react_portal_bloc.dart';
import '../../presentation/bloc/react_portal_event.dart';
import '../../presentation/bloc/react_portal_state.dart';
import '../widgets/webview_loading_indicator.dart';
import '../../../../utils/url_launcher_utils.dart';

class ReactPortalPage extends StatefulWidget {
  final String initialUrl;
  const ReactPortalPage({super.key, required this.initialUrl});

  @override
  State<ReactPortalPage> createState() => _ReactPortalPageState();
}

class _ReactPortalPageState extends State<ReactPortalPage> {
  late final WebViewController _controller;
  final ReactPortalBloc _bloc = ReactPortalBloc();
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100.0;
            });
          },
          onPageStarted: (String url) {
            _bloc.dispatch(LoadStartedEvent());
          },
          onPageFinished: (String url) {
            _bloc.dispatch(LoadFinishedEvent());
          },
          onNavigationRequest: (NavigationRequest request) {
            final uri = Uri.tryParse(request.url);
            if (uri == null) {
              return NavigationDecision.prevent;
            }
            final allowed =
                widget.initialUrl.isNotEmpty &&
                request.url.startsWith(widget.initialUrl);
            if (allowed) {
              return NavigationDecision.navigate;
            }
            launchExternalUrl(request.url);
            return NavigationDecision.prevent;
          },
        ),
      )
      ..addJavaScriptChannel(
        'FlutterBridge',
        onMessageReceived: (JavaScriptMessage message) {
          _bloc.dispatch(JsMessageReceivedEvent(message.message));
        },
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Future<bool> _handleWillPop() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => _handleWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'nDashboard Web View',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          ),
        ),
        body: Column(
          children: [
            WebViewLoadingIndicator(progress: _progress),
            Expanded(child: WebViewWidget(controller: _controller)),
            StreamBuilder<ReactPortalState>(
              stream: _bloc.stream,
              builder: (context, snapshot) {
                if (snapshot.data is ReactPortalJsMessageState) {
                  final state = snapshot.data as ReactPortalJsMessageState;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
