module ExplicitImportDict where

import ExplicitExportDict (Class1(..), Class2(Class2.Dict, method2), Class3.Dict, method3)

class1Instance :: Class1.Dict Int
class1Instance = Class1.Dict { method1 = id }

class2Instance :: Class2.Dict Int
class2Instance = Class2.Dict { method2 = id }

class3Instance :: Class3.Dict Int
class3Instance = Class3.Dict { method3 = id }
