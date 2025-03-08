import Data.List

type Ingoing = [String]

type Outgoing = Integer

count :: Eq a => a -> [a] -> Int
count x = length . filter (x==)

vowels :: String -> Int
vowels str = a+e+i+o+u
  where 
    a = count 'a' str
    e = count 'e' str
    i = count 'i' str
    o = count 'o' str
    u = count 'u' str

adjacent :: Eq b => [b] -> Bool
adjacent str = any (uncurry (==)) pairs
  where
    prs (x:yys@(y:_)) = (x,y):prs yys
    prs x = []
    pairs = prs str


containsBaned :: [Char] -> Bool
containsBaned str = ab || cd || pq || xy
  where
    ab = "ab" `isInfixOf` str 
    cd = "cd" `isInfixOf` str 
    pq = "pq" `isInfixOf` str 
    xy = "xy" `isInfixOf` str 

goodString str = i && ii && iii
  where 
    i = vowels str >=3
    ii = adjacent str
    iii = not (containsBaned str)

partOne a = count True (map goodString a) 

partTwo a = -1

parse :: [String] -> Ingoing
parse a = a

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/05-t.txt"
  let par = parse raw

  print par

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
  