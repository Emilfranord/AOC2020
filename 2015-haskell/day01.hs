
type Ingoing = String

type Outgoing = Integer

floor :: Char -> Integer
floor '(' = 1
floor ')' = -1
floor x   = 0

partOne :: Ingoing -> Outgoing
partOne a = sum (map Main.floor a) 

partTwo :: Ingoing -> Outgoing
partTwo a = snd (foldl (\(flo, idx) element -> if flo == -1 then (flo, idx) else (element + flo, idx + 1) ) (0,0) numerical )
    where numerical = map Main.floor a

parse :: [String] -> Ingoing
parse = head 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/01-t.txt"
  let par = parse raw

  print par

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
  