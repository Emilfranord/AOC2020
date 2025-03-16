
type Ingoing = Integer

type Outgoing = Integer


divisors n =  [x | x <- [1.. n], n `rem` x == 0]


presents :: Integral a => a -> a
presents house =  10 * sum (divisors house)


takeWhileInclusive :: (t -> Bool) -> [t] -> [t]
takeWhileInclusive _ [] = []
takeWhileInclusive p (x:xs) = x : if p x then takeWhileInclusive p xs
                                         else []


findHouse :: Integral t => t -> [t]
findHouse target = takeWhileInclusive  (< target ) [presents x | x <- [1.. ]] 



partOne :: Integral a => a -> Int
partOne a = length (findHouse a)



partTwo :: Ingoing -> Outgoing
partTwo a = 1

parse :: [String] -> Ingoing
parse a = read (head a) :: Integer 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/20-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/20.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  