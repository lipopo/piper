import os
from setuptools import setup, find_packages


# Setup require packages
_require = []
with open(os.path.join(os.path.dirname(__file__), "requirements.txt"), "r") as f:
    _require = [pack[:-1] for pack in f.readlines()]


setup(
    name="Piper",
    version="0.0.1",
    packages=find_packages(),
    install_requires=_require
)
