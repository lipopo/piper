class BaseData:
    def __init__(self, data):
        self._data = data

    @property
    def data(self):
        return self._data

    @data.setter
    def data(self, data):
        self._data = data

    def __repr__(self):
        return f"<BaseData at {hex(id(self))} with {type(self._data)}>"
