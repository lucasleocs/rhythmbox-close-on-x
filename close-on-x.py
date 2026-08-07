from gi.repository import GObject, Peas


class CloseOnX(GObject.Object, Peas.Activatable):
    object = GObject.Property(type=GObject.Object)

    def __init__(self):
        super().__init__()
        self._window = None
        self._handler_id = None
        self._quitting = False

    def do_activate(self):
        self._window = self.object.props.window

        # Rhythmbox normally hides its main window when the user clicks X.
        # As soon as that happens, request a real application shutdown.
        self._handler_id = self._window.connect(
            "hide",
            self._on_window_hidden,
        )

    def do_deactivate(self):
        if self._window is not None and self._handler_id is not None:
            try:
                self._window.disconnect(self._handler_id)
            except Exception:
                pass

        self._handler_id = None
        self._window = None

    def _on_window_hidden(self, window):
        if self._quitting:
            return

        self._quitting = True

        # Request Rhythmbox's normal, complete shutdown instead of merely
        # leaving the application running with its window hidden.
        self.object.quit()
