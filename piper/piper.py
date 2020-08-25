class Piper:
    name = "base" # 管道名称
    meta_info = None # 元信息
    target_pipe = None # 目标管道
    linked_number = 0 # 被指向的数目

    def setMetaInfo(self, meta_info):
        """设置元信息"""
        self.meta_info = meta_info

    def linked(self):
        """通知管道被链接
        """
        self.linked_number += 1

    def link(self, pipe):
        """链接到目标管道
        """
        self.target_pipe = pipe
        self.target_pipe.linked()

    def process(self, data):
        """处理信息"""
        pass
    
    def next(self, data):
        if self.target_pipe:
            self.target_pipe(data)

    def __call__(self, data):
        self.process(data)
        self.next(data)

    def __repr__(self):
        return f"<Piper {self.name} at {hex(id(self))}>"


class InputPiper(Piper):
    """输入管道"""
    name = "input"


class SplitPiper(Piper):
    """分解管道"""
    name = "split"
    target_pipes = None # 需要链接的管道

    def link(self, pipe):
        """链接管道们"""
        if not self.target_pipes:
            self.target_pipes = []
        self.target_pipes.append(pipe)
        pipe.linked()

    def next(self, data):
        """处理跳转
        """
        for _pipe in self.target_pipes or []:
            _pipe(data)


class ConcatePiper(Piper):
    """聚合管道"""
    name = "concate"
    data_pool = None # 数据数组

    def next(self, data):
        if not self.data_pool:
            self.data_pool = []
        data_pool = self.data_pool
        data_pool.append(data)
        if len(data_pool) >= self.linked_number:
            # clear data pool
            self.data_pool = []
            self.target_pipe(data_pool)


class EchoPiper(Piper):
    """输出管道，用于向命令行打印信息
    """
    name = "echo"

    def process(self, data):
        print(data)
