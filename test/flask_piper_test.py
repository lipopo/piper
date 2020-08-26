from unittest import TestCase
from unittest.mock import patch

from flask import Flask

from piper.flask_piper import FlaskPiper


class MockApp:
    path = []
    method = []

    running = False
    run_kwargs = None

    def add_url_rule(self, path, entry_point, function):
        self.path.append(path)
        self.method.append(function)
    
    def run(self, **kwargs):
        self.run_kwargs = kwargs
        self.running = True


class MockRequest:
    args = "args"
    json = "json"
    path = "path"
    method = "method"
    form = "form"


mock_app = MockApp()


class FlaskPiperTestCase(TestCase):

    def setUp(self):
        """初始化一个flask piper
        """
        self._flask_piper = FlaskPiper()
    
    def testApp(self):
        _app = self._flask_piper.app
        self.assertIsInstance(_app, Flask)

    @patch("piper.flask_piper.FlaskPiper.app", mock_app)
    def testSetupute(self):
        """测试路由结构"""
        self._flask_piper.setupRoute()
        self.assertEqual(
            mock_app.path,
            self._flask_piper.meta_info.get("routes"))
    
    @patch("piper.flask_piper.request", MockRequest())
    def testRunPiper(self):
        _data = self._flask_piper.runPiper()

        self.assertEqual(_data.get("args"), "args")
        self.assertEqual(_data.get("json"), "json")
        self.assertEqual(_data.get("path"), "path")
        self.assertEqual(_data.get("method"), "method")
        self.assertEqual(_data.get("form"), "form")
        self.assertEqual(_data.get("meta_info"), self._flask_piper.meta_info)
    
    @patch("piper.flask_piper.FlaskPiper.app", mock_app)
    def testRun(self):
        self._flask_piper.run()

        self.assertTrue(mock_app.running)
        self.assertEqual(mock_app.run_kwargs, self._flask_piper.meta_info.get("run", {}))