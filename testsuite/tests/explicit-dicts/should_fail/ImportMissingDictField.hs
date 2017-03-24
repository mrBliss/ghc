module ImportMissingDictField where

import ExportDictOnly

class1Instance :: Class1.Dict Int
class1Instance = Class1.Dict { method1 = id }
