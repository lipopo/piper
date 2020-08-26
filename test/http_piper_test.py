from unittest import TestCase
from unittest.mock import patch

from piper.http_piper import HttpPiper


class FakeData:
    data = "http://xxxxxx"


class MockRequests:

    content = "content"
    
    def Request(self, *args, **kwargs):
        return self

    def prepare(self, *args, **kwargs):
        return self

    def Session(self, *args, **kwargs):
        return self

    def send(self, *args, **kwargs):
        return self


class HttpPiperTestCase(TestCase):

    @patch("piper.http_piper.requests", MockRequests())
    def testProcess(self):
        """测试process过程
        """
        data = FakeData()
        http_piper = HttpPiper()
        http_piper.process(data)
        self.assertEqual(data.data, "content")
