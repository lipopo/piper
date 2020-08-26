from unittest import TestCase

from piper.interrupt_piper import Piper, InterruptPiper


class FakeData:
    data = False


class FakePiper(Piper):
    trigered = False

    def __call__(self, data):
        self.trigered = True


class InterruptPiperTestCase(TestCase):
    def testIntrrupt(self):
        _piper = InterruptPiper()
        _fake_piper = FakePiper()
        _piper.link(_fake_piper)

        _data = FakeData()

        _piper(_data)
        self.assertFalse(_fake_piper.trigered)

        _data.data = True
        _piper(_data)
        self.assertTrue(_fake_piper.trigered)