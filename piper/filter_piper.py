from functools import reduce

from piper.piper import Piper


class FilterPiper(Piper):
    name = "filter"
    meta_info = {
        "filter_value": None,
        "filter_key": None
    }

    def process(self, data):
        filter_key = self.meta_info.get("filter_key")
        filter_value = self.meta_info.get("filter_value")
        if filter_key:
            _data = data.data
            if isinstance(_data, dict):
                for k in filter_key.split("."):
                    _data = _data.get(k)
                if _data != filter_value:
                    data.data = False