module ImportDictMissing where

import ExportClassOnly

class1Instance :: Class1.Dict Int
class1Instance = Class1.Dict { method1 = id }
