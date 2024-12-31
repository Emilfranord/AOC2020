import Data.List
import Data.Maybe
import Text.Regex.Posix
import Debug.Trace
import Text.Printf (printf)

type Outgoing = Integer

type Rule = (Integer , Integer)

type Updates = [Integer]

type Ingoing = ([Rule], [Updates])


verifyOrdering :: Eq a => (a, a) -> [a] -> Bool
verifyOrdering (a,b) list = verifier idxA idxB
  where 
    idxA = elemIndex a list
    idxB = elemIndex b list
    verifier (Just x) (Just y) = x <= y
    verifier Nothing (Just y) = True
    verifier (Just x) Nothing = True
    verifier Nothing Nothing = True


verifyAll :: (Foldable t, Eq a) => t (a, a) -> [a] -> Bool
verifyAll orderings list =  all (`verifyOrdering` list) orderings

middle :: [a] -> [a]
middle l@(_:_:_:_) = middle $ tail $ init l
middle l           = l

partOne :: Ingoing -> Outgoing
partOne (orders, updates) = total
  where
    valid = filter (verifyAll orders) updates
    midpoints = map (head . middle) valid
    total = sum midpoints

makeValidReorder :: (Foldable t, Eq b) => t (b, b) -> [b] -> [b]
makeValidReorder rules = sortBy (\a b -> if (a, b) `elem` rules then LT else GT)

partTwo :: Ingoing -> Outgoing
partTwo (orders, updates) = total
  where
    incorrectly = filter (not . verifyAll orders) updates
    valid = map (makeValidReorder orders) incorrectly
    midpoints = map (head . middle) valid
    total = sum midpoints

numberExtractor :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numberExtractor str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[0-9]+")

parse :: [String] -> Ingoing
parse dat = (rules, updates)
  where
    idx = fromJust (elemIndex "" dat)
    rules = map ((\ x -> (head x, x !! 1)) . numberExtractor) (take idx dat)
    updates = map numberExtractor (drop (idx+1) dat)

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/05-t.txt"
  let par =  parse raw

  --print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/05.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  