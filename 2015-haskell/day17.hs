import Data.List
type Ingoing = [Integer]
type Outgoing = Integer



comb options target 
                | target == 0 = 1
                | target > 0 = sum (map (\x -> comb (delete x options) (target - x)) options)
                | target < 0 = 0


combinations :: [Integer] -> [Integer] -> Integer -> [[Integer]]
combinations unused used remaining
  | remaining == 0 = [used]
  | remaining < 0 = [[]]
  | remaining > 0 = concatMap (\ x  -> combinations (delete x unused) (x : used) (remaining - x)) unused


uniqueCombinations :: Ord a => [[a]] -> [[a]]
uniqueCombinations c = nub (map (sort) c)  

partOne :: [Integer] -> [[Integer]]
partOne a = uniqueCombinations ( combinations a [] 25)

partTwo :: Num a => p -> a
partTwo a = 1


parse :: [String] -> [Integer]
parse = map (\ x -> read x :: Integer )   

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/17-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/17.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  