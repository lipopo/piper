## flow简介

构建piper的核心文件，通过使用

```python
form piper.piper import Piper

# 通过流文件构建
piper = Piper.build(<flow_file_path>)

# 走process过程
piper(<data>)
```


## flow 文件信息

### meta_info.json

描述flow中节点信息的文件，同时存储了节点元信息，以及对于节点的定义

```json
{
    "piper_count": 1,
    "entry": "point1",
    "piper": {
        "point1": {
            "idx": 0,
	    "meta_info": null,
	    "type": "input"
	}
    }
}
```


### link_info.npy

描述节点链接信息，存储了节点与节点之间的链接信息。文件通过numpy进行解析，解析之后为一个numpy常用的数组。
