-- Haskell parser for Featherweight Java
-- Author: Samuel da Silva Feitosa
-- Date: 01/2018
---------------------------------------------
module FJParser where
import Data.Map

-- Syntax
data Class = Class String String [(Type,String)] Constr [Method]
           deriving (Show, Eq)

data Constr = Constr String [(Type,String)] [String] [(String,String)]
            deriving (Show, Eq)

data Method = Method Type String [(Type,String)] Expr
            deriving (Show, Eq)

data Expr = Var String                               -- Variable
          | FieldAccess Expr String                  -- Field Access
          | MethodInvk Expr String [Expr]            -- Method Invocation
          | CreateObject String [Expr]               -- Object Instantiation
          | Cast String Expr                         -- Cast
          deriving (Show, Eq)

data Type = TypeClass String
          deriving (Show, Eq)

type Env = Map String Type
type CT = Map String Class


constr1 = Constr "A" [] [] []
constr2 = Constr "B" [] [] []
constr3 = Constr "C" [] [] []
constr4 = Constr "D" [(TypeClass "Object", "k")] [] [("k", "k")] 

class1 = Class "A" "Object" [(TypeClass "C", "x"), 
                             (TypeClass "Object", "y")] constr1 []
class2 = Class "B" "Object" [(TypeClass "Object", "z")] constr2 [meth1]
class3 = Class "C" "Object" [(TypeClass "Object", "w")] constr3 [] 
class4 = Class "D" "Object" [(TypeClass "Object", "k")] constr4 [meth1]

meth1 = Method (TypeClass "Object") "getA" [(TypeClass "Object", "a")] (Var "a")
meth2 = Method (TypeClass "Object") "getB" [(TypeClass "Object", "b")] (Var "b")

ct = Data.Map.fromList [("A", class1), ("B", class2), ("C", class3)]
ctx = Data.Map.fromList [("x", TypeClass "B"), ("y", TypeClass "Object")]
