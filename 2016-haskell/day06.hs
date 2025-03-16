import Data.List.Utils (countElem)
import Data.List (maximumBy, minimumBy)
type Ingoing = Integer

type Outgoing = Integer

mostFrequent lst = fst (maximumBy (\a b -> compare (snd a) (snd b)) (map (\x -> (x, countElem x lst)) lst))
leastFrequent lst = fst (minimumBy (\a b -> compare (snd a) (snd b)) (map (\x -> (x, countElem x lst)) lst))

extractCol col values = map fst (filter (\(ch, idx) -> idx == col) values)

partOne a = map (\x ->  mostFrequent (extractCol x a) ) [0.. limit]
  where
    limit = snd (maximumBy (\a b -> compare (snd a) (snd b)) a)

partTwo a = map (\x ->  leastFrequent (extractCol x a) ) [0.. limit]
  where
    limit = snd (maximumBy (\a b -> compare (snd a) (snd b)) a)

parse :: [String] -> [(Char, Integer)]
parse = concatMap (\x -> zip x [0..]) 

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
  