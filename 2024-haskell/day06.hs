import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

import Debug.Trace
import qualified Data.Foldable as Sen

type Ingoing = (Map (Int, Int) Char, (Int, Int)) 

type Outgoing = Integer

data Direction = Up | Right | Down | Left

rotate :: Direction -> Direction
rotate Up = Main.Right
rotate Main.Right = Down
rotate Down = Main.Left
rotate Main.Left = Up

instance Show Direction where
    show Up = "U"
    show Main.Right = "R"
    show Down = "D"
    show Main.Left = "L"

instance Eq Direction where
  (==) a b = show a == show b 

instance Ord Direction where
    compare a b = compare (show a) (show b)

next :: (Num a, Num b) => (a, b) -> Direction -> (a, b)
next (x,y) Up         = (x,y-1)
next (x,y) Main.Right = (x+1,y)
next (x,y) Down       = (x,y+1)
next (x,y) Main.Left  = (x-1,y)

objectInFront :: (Ord a, Ord b, Num a, Num b) => Map (a, b) Char -> (a, b) -> Direction -> Char
objectInFront tiles (x,y) dir = Map.findWithDefault 'x' (next (x,y) dir) tiles

advance tiles (flag, guard, direction, visited) =  aux object 
  where
    object = objectInFront tiles guard direction
    
    aux '.' = (False, next guard direction, direction, Set.insert (guard, direction) visited)
    aux '^' = (False, next guard direction, direction, Set.insert (guard, direction) visited)
    aux '#' = (False, guard, rotate direction, visited)
    aux 'x' = (True, guard, direction, Set.insert (guard, direction) visited)

partOne :: (Show a1, Show b, Ord a1, Ord b, Num a1, Num b) => (Map (a1, b) Char, (a1, b)) -> Int
partOne (dat, ini) = Set.size (Set.map fst r)
  where 
    (q,w,e,r) = until (\(a,b,c,d) -> a) (advance dat) (False, ini, Up, Set.singleton (ini, Up))

partTwo :: Ingoing -> Outgoing
partTwo a  = -1

parse :: [String] -> Ingoing
parse dat = structure
  where
    cartProd xs ys = [(x,y) | x <- xs, y <- ys]
    sizeToCart (a,b) =  cartProd [0 .. a-1] [0 .. b-1]
    matrixSize grid = (length (head grid),length grid)
    elements = Prelude.map (\(x,y) -> ((y,x), (dat !! x) !! y)) (sizeToCart (matrixSize dat))
    init = fst (head (filter (\(a,b) -> b=='^') elements))
    structure = (Map.fromList elements, init)

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/06-t.txt"
  let par =  parse raw

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
  