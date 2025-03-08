import Data.Map (Map)
import qualified Data.Map as Map
import Data.List (tails, nub, permutations)
import Data.Maybe

type Ingoing = String

type Outgoing = Integer



windows :: Int -> [a] -> [[a]]
windows m = foldr (zipWith (:)) (repeat []) . take m . tails


pathDis mapping route = dist
  where
    pairDist lst = fromJust(  Map.lookup (head lst, lst !! 1) mapping)
    gaps = windows 2 route
    dist = sum (map pairDist gaps)



allDistances a = possibleDistances
  where
    mapping = Map.fromList a
    targets = nub (map (fst . fst) a)
    perms =  permutations targets
    possibleDistances = map (pathDis mapping ) perms

partOne a = minimum (allDistances a)

partTwo a = maximum (allDistances a)


parseLine str = [((ori, des), dist), ((des, ori), dist)]
  where
    elements = words str
    ori = head elements 
    des = elements !! 2
    dist = read (elements !! 4) :: Integer


parse = concatMap parseLine  

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/09-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/09.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  