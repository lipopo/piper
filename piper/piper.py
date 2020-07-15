class Piper:
    data = None

    def process(self, data):
        return data

    def pipe(self, func):
        _data = func(self.data)
        if _data is not None:
            self.data = _data
        return self

    def __call__(self, data):
        """调用流程"""
        return self.process(data)
