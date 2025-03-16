import Text.Regex.Posix
import Data.List.Split


numbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numbers str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[0-9]+")

type Ingoing = Integer

type Outgoing = Integer

type Triple = (Integer, Integer, Integer)

validTriangle (a,b,c) = i && ii && iii
  where
    i = a + b > c
    ii = a + c > b
    iii = b + c > a

partOne :: [Triple] -> Int
partOne a =  length (filter validTriangle a)

toStream :: Foldable t => t (b, b, b) -> [b]
toStream  = concatMap (\(a,b,c) -> [a,b,c])

toTriples v = [(head v, v !! 3, v !! 6), (v !! 1, v !! 4, v !! 7), (v !! 2, v !! 5, v !! 8)]

reorder values = concatMap toTriples (chunksOf 9 (toStream values))

partTwo a = length (filter validTriangle (reorder a))


parse :: [String] -> [Triple]
parse = map ((\ x -> (head x, x !! 1, x !! 2)) . numbers)


readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/03-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  --print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/03.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  