from piper.piper import Piper


class InterruptPiper(Piper):
    name = "interrupt"

    def next(self, data):
        if data.data:
            super().next(data)