from unittest import TestCase

from piper.filter_piper import FilterPiper


class FakeData:
    data = {"a": {"b": "1"}}


class FilterPiperTestCase(TestCase):
    def testProcess(self):
        _piper = FilterPiper()
        _piper.setMetaInfo({
            "filter_key": "a.b",
            "filter_value": "1"
        })

        _fake_data = FakeData()
        _data = _fake_data.data
        _piper.process(_fake_data)

        self.assertEqual(_fake_data.data, _data)
        
        _piper.setMetaInfo({
            "filter_value": "2",
            "filter_key": "a.b"
        })
        _piper.process(_fake_data)
        self.assertFalse(_fake_data.data)
        
        
