type Ingoing = Integer

type Outgoing = Integer



partOne :: Ingoing -> Outgoing
partOne a =  1

partTwo :: Ingoing -> Outgoing
partTwo a = 1

parse :: [String] -> Ingoing
parse str = 11

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
  