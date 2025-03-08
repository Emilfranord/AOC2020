import Text.Regex.Posix

import Data.Map (Map)
import qualified Data.Map as Map

import Data.Bits
import Data.Int


numbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Int16]
numbers str = map (\x -> (read x :: Int16) ) (getAllTextMatches $ str =~ "[0-9]+")

type Ingoing = [Expression]

type Outgoing = Int16

type Variable = String

data Expression = 
  Const Int16
  | Var Variable
  | ConstAssign (Expression, Variable) 
  | AND (Expression, Expression, Variable)
  | OR (Expression, Expression, Variable)
  | LSHIFT (Expression, Expression, Variable)
  | RSHIFT (Expression, Expression, Variable)
  | NOT (Expression, Variable)


instance Show Expression where
  show (Const x)                  = "Co: " ++ show x
  show (Var x)                    = "Va: " ++ show x
  show (ConstAssign (a, v))       = "Ca: " ++ show a ++ " " ++ show v
  show (NOT (a, v))               = "No: " ++ show a ++ " " ++ show v
  show (AND (a,b,v))              = "An: " ++ show a ++ " " ++ show b ++ " "++ show v
  show (OR (a,b,v))               = "Or: " ++ show a ++ " " ++ show b ++ " " ++ show v
  show (LSHIFT (a,b,v))           = "Ls: " ++ show a ++ " " ++ show b ++ " " ++ show v
  show (RSHIFT (a,b,v))           = "Rs: " ++ show a ++ " " ++ show b ++ " " ++ show v

parseExpression str | length s == 1 && not (null n) = Const (head n)
                    | length s == 1 && null n  = Var (head s)
                    | s !! 0 == "NOT" =   NOT ( parseExpression (s !! 1), s !! 3)
                    | s !! 1 == "AND" =   AND ( parseExpression (s !! 0), parseExpression (s !! 2), s !! 4)
                    | s !! 1 == "OR" =    OR ( parseExpression (s !! 0), parseExpression (s !! 2), s !! 4)
                    | s !! 1 == "LSHIFT" =LSHIFT ( parseExpression (s !! 0), parseExpression (s !! 2), s !! 4)
                    | s !! 1 == "RSHIFT" =RSHIFT ( parseExpression (s !! 0), parseExpression (s !! 2), s !! 4)
                    | s !! 1 == "->" =    ConstAssign (parseExpression (s !! 0) , s !! 2)
                    | otherwise = Var "XXXXXXX"
  where
    s = words str
    n = numbers str



look (Const x) state             = x
look (Var x) state               = state Map.! x
look x state = 0 

interpret (Const x) state             = Map.empty
interpret (Var x) state               = Map.empty  
interpret (ConstAssign (a, v)) state  = Map.insert v (look a state) state
interpret (NOT (a, v)) state          = Map.insert v (complement (look a state)) state
interpret (AND (a,b,v)) state         = Map.insert v (look a state .&. look b state) state
interpret (OR (a,b,v)) state          = Map.insert v (look a state .|. look b state) state
interpret (LSHIFT (a,b,v)) state      = Map.insert v (shiftL (look a state) (fromIntegral (look b state))) state
interpret (RSHIFT (a,b,v)) state      = Map.insert v (shiftR (look a state) (fromIntegral (look b state))) state


partOne  = foldl (\sta ele -> interpret ele sta) Map.empty

partTwo a = -1

parse :: [String] -> Ingoing
parse a = (map parseExpression a) 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/07-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/07.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  