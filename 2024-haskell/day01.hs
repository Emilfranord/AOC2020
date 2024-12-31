import Data.List (sort)
import Data.Bifunctor (bimap)

type Ingoing = ([Integer], [Integer])

type Outgoing = Integer

partOne :: Ingoing -> Outgoing
partOne pair = sum (zipWith (\ a b -> abs (a - b)) right left)
  where
    right = sort (fst pair)
    left = sort (snd pair)

partTwo :: Ingoing -> Outgoing 
partTwo pair = sum (map (\x -> x * count left x) right)
  where
    right = sort (fst pair)
    left = sort (snd pair)
    count lst search = toInteger (length (filter (== search) lst))

parse :: [String] -> Ingoing
parse inp = (map fst (pairs inp), map snd (pairs inp))
  where
    extractRead str idx = read (Prelude.words str !! idx) :: Integer
    pairs = map (\x -> (extractRead x 0, extractRead x 1)) 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/01-t.txt"
  let par =  parse raw
  
  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/01.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
