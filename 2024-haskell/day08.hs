import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set
import Data.List (tails)


type Ingoing = Integer

type Outgoing = Integer


circleAround (x,y) r = points
  where
    xf a = r * cos a + x
    yf a = r * sin a + y
    points = map (\ang -> (xf ang ,  yf ang)) [0.0, 0.01 .. 4.0]

handlePair a b =  concatMap
                (Set.toList
                  . (\ x
                        -> Set.union
                            (Set.fromList (circleAround a x))
                            (Set.fromList (circleAround b (2 * x)))))
                [1 .. 50]



antinodes mapping = points
  where
    windows m = foldr (zipWith (:)) (repeat []) . take m . tails
    windowed = map (\x -> (head x, x !! 1)) (windows 2 mapping)
    points = concatMap (uncurry handlePair) windowed


partOne (mapping, freq) = towers
  where
    towers = map (\x -> Map.filter (== x) mapping) (Set.toList freq)
    -- next step is to use the antinodes function on the towers. 
    -- This will generate a list of antinodes for each type of frequency

partTwo a = -1


parse :: [[Char]] -> (Map (Int, Int) Char, Set Char)
parse dat = (mapping, frequencies)
  where
    cartProd xs ys = [(x,y) | x <- xs, y <- ys]
    sizeToCart (a,b) =  cartProd [0 .. a-1] [0 .. b-1]
    matrixSize grid = (length (head grid),length grid)
    elements = filter (\(cord, ch) -> ch /= '.')  (Prelude.map (\(x,y) -> ((y,x), (dat !! x) !! y)) (sizeToCart (matrixSize dat)))
    mapping = Map.fromList elements
    frequencies = Set.fromList (map snd elements)
    

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/08-t.txt"
  let par =  parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/08.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  