import requests

from piper.piper import Piper


class HttpPiper(Piper):

    meta_info = {
        "method": "GET", 
        "headers": {},
        "params": {}
    }

    def process(self, data):
        url = data.data
        request = requests.Request(url=url, **self.meta_info)
        prepare_request = request.prepare()
        session = requests.Session()
        response = session.send(prepare_request)
        data.data = response.content
