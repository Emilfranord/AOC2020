import Data.Function (fix)
import Data.Function.Memoize ( memoize2, Memoizable(memoize) ) 

type Ingoing = [Integer]

type Outgoing = Integer

digits :: Integral a => Integer -> a
digits x = floor (logBase 10 (fromInteger x) ) + 1

splitHalf :: [a] -> ([a], [a])
splitHalf l = splitAt ((length l + 1) `div` 2) l 

segment :: Show p => p -> [Integer]
segment x = [a,b]
  where
    spl = splitHalf (show x)
    a = read (fst spl) :: Integer
    b = read (snd spl) :: Integer

transform :: Integer -> [Integer]
transform 0 = [1]
transform x | even (digits x) = segment x
            | odd  (digits x) = [x * 2024]

memoTransform :: Integer -> [Integer]
memoTransform = memoize transform

followStone :: Integer -> Integer -> Integer
followStone stone 0 = toInteger (length [stone]) 
followStone stone n = sum (map (\x -> memoFollow x (n-1)) (memoTransform stone))

memoFollow :: Integer -> Integer -> Integer
memoFollow = memoize2 followStone

followInit :: [Integer] -> Integer -> Integer
followInit stones n = sum (map (`memoFollow` n) stones )

blink :: [Integer] -> [Integer]
blink = concatMap memoTransform

blinkN :: Int -> [Integer] -> [Integer]
blinkN n stones = last (take (n+1) (iterate blink stones))

partOne :: Ingoing -> Outgoing
partOne a = followInit a 25

partTwo :: Ingoing -> Outgoing
partTwo a = followInit a 75
  
parse :: [String] -> Ingoing
parse dat = map (\x -> read x :: Integer) (words (head dat)) 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/11-t.txt"
  let par =  parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/11.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  