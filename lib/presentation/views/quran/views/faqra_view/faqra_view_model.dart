class FaqraViewModel{


  void autoScrollToEnd() {
    if(!_controller.hasClients)return;
    try {
      Duration? d = _cubit.timeToScroll(_controller);
      if (d == null) {
        _controller.animateTo(_controller.offset,
            duration: Duration.zero, curve: Curves.linear);
        return;
      }
      _controller.animateTo(_controller.position.maxScrollExtent,
          duration: d, curve: Curves.linear);
    } catch (e) {
      log("error : $e");
      stopTimer = true;
    }
  }
}