import Text.Regex.Posix

import Data.Map (Map)
import qualified Data.Map as Map

import Data.Function.Memoize


type Ingoing = [String]

type Outgoing = Integer

type Rectangle = (Integer, Integer, Integer, Integer)

data Operation = On Rectangle
                | Off Rectangle
                | Toggle Rectangle

instance Show Operation where
    show (On a) = "on " ++ show a
    show (Off a) = "of " ++ show a
    show (Toggle a) = "to " ++ show a

numbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numbers str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[0-9]+")

rectPoints :: Rectangle -> [(Integer, Integer)]
rectPoints (a,b,c,d) = [(x,y) | x<-[a .. c], y<-[b .. d] ]

insideRect :: Rectangle -> (Integer, Integer) -> Bool
insideRect (a,b,c,d) (x,y) = a <= x && x <= c && b <= y && y <= d

applyOperation (On rect) point lightState = insideRect rect point || lightState
applyOperation (Off rect) point lightState = not (insideRect rect point) && lightState
applyOperation (Toggle rect) point lightState = if insideRect rect point then not lightState else lightState

applyOperations operations point = foldl  (\sta ele -> applyOperation ele point sta) False operations

partOne a = lit
  where 
    initial = rectPoints (0,0,999,999)
    final = map (applyOperations a) initial
    lit = length (filter id final)

applyNumberOpe (On rect) point lightState =     if insideRect rect point then lightState + 1 else lightState
applyNumberOpe (Off rect) point lightState =    if insideRect rect point then max (lightState - 1) 0 else lightState
applyNumberOpe (Toggle rect) point lightState = if insideRect rect point then lightState + 2 else lightState

applyNumberOpes ::  [Operation] -> (Integer, Integer) -> Integer
applyNumberOpes operations point = foldl (\sta ele -> applyNumberOpe ele point sta) 0 operations

partTwo a = total
  where 
    brightnesses = map (applyNumberOpes a) (rectPoints (0,0,999,999))
    total = sum brightnesses

numbersFour x = (head val, val !! 1, val !! 2, val !! 3)
  where
    val = numbers x

lineParse :: String -> Operation
lineParse ('t':'o':'g':'g':'l':'e' : x)  = Toggle (numbersFour x)
lineParse ('t':'u':'r':'n':' ':'o' : 'n' : x)  = On (numbersFour x)
lineParse ('t':'u':'r':'n':' ':'o' : 'f' : x)  = Off (numbersFour x)
lineParse x = Toggle (-1,-1,-1,-1)

parse :: [String] -> [Operation]
parse = map lineParse

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/06-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/06.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  