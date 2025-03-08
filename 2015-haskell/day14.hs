import Data.List
import Data.Maybe

type Ingoing = String

type Outgoing = Integer

runningSleeping (speed, time, rest) = replicate time speed ++ replicate rest 0


distance :: Num a => (a, Int, Int) -> Int -> a
distance (speed, time, rest) t = sum (take t (cycle (runningSleeping (speed, time, rest))))

partOne a = maximum (map (`distance` 2503) a) 

leadingRace deers t = winner
  where
    standings = map (`distance` t) deers
    winning = maximum standings
    winner = elemIndices winning standings
    

count :: Eq a => a -> [a] -> Int
count x = length . filter (x==)


frequency :: Eq a => [a] -> [(a, Int)]
frequency lst = freq
  where
    values = nub lst
    freq = map (\x -> (x, count x lst)) values


winsAllRounds :: (Num b, Ord b) => [(b, Int, Int)] -> Int -> [(Int, Int)]
winsAllRounds deers rounds = frequency (concatMap (leadingRace deers) [1 .. rounds])

partTwo a = maximum (map snd (winsAllRounds a 2503))


parseLine specs = (speed, time, rest)
  where
    info = words specs
    speed =read ( info !! 3 ) :: Int
    time = read ( info !! 6 ) :: Int
    rest = read ( info !! 13 ) :: Int


parse  = map parseLine 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/14-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/14.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  