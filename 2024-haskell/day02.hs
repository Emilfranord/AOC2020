import Data.List (sort, tails)
import Data.Bifunctor (bimap)

type Ingoing = [[Integer]] 

type Outgoing = Integer

reportVerify :: [Integer] -> Bool
reportVerify level = (increase || decrease) && distance
  where
    windows m = foldr (zipWith (:)) (repeat []) . take m . tails
    windowed = map (\x -> (head x, x !! 1))(windows 2 level)  
    increase = all (uncurry (<)) windowed
    decrease = all (uncurry (>)) windowed
    distance = all (\x -> abs(uncurry (-) x) == 1  || abs(uncurry (-) x) == 2 || abs(uncurry (-) x) == 3 ) windowed

generateSimilarReports :: [Integer] -> [[Integer]]
generateSimilarReports report = map (`remove` report) [0 .. length report ]
  where
  remove _ [] = []
  remove 0 (x:xs) = xs
  remove n (x:xs) = x : remove (n-1) xs

partOne :: Ingoing -> Outgoing
partOne reports = toInteger (length (filter id (map reportVerify reports) ) )

partTwo :: Ingoing -> Outgoing 
partTwo reports = toInteger (length (filter id (map reportVerifySimilar reports) ) )
  where
    reportVerifySimilar report = any reportVerify (generateSimilarReports report)

parse :: [String] -> Ingoing
parse  = map (map (\ x -> read x :: Integer) . Prelude.words) 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/02-t.txt"
  let par =  parse raw
  
  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/02.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
