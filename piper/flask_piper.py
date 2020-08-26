from flask import Flask, request

from piper.data import BaseData
from piper.piper import Piper


class FlaskPiper(Piper):

    name = "flask"
    _app = None # 默认的应用
    meta_info = {
        # 指定运行参数
        "run": {
            "port": 9000
        },
        # 指定路由点信息
        "routes": [
            "/"
        ]
    }

    @property
    def app(self):
        if not self._app:
            self._app = Flask(__name__)
            self.setupRoute()
        return self._app

    def setupRoute(self):
        """初始化路由信息
        """
        routers = self.meta_info.get("routes")
        for router_path in routers:
            # 挂载路由点
            self.app.add_url_rule(
                router_path,
                f"{router_path}_{self.runPiper.__name__}" ,
                self.runPiper)

    def runPiper(self):
        """执行管道过程，即next(data)，需要考虑的是构建data信息
        """
        _data = {
            "meta_info": self.meta_info,
            "args": request.args,
            "json": request.json,
            "path": request.path,
            "method": request.method
        }

        data = BaseData(_data)
        self.next(data)

        # get response from data
        return data.data

    def run(self):
        run_kwargs = self.meta_info.get("run", {})
        self.app.run(**run_kwargs)