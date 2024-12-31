type Ingoing = Integer

type Outgoing = Integer

parse :: String -> Ingoing
parse y = read y :: Integer

partOne :: Ingoing -> Outgoing
partOne i = i * 2

partTwo :: Ingoing -> Outgoing 
partTwo i = i * 4

main = do
  raw <- getLine
  let par =  parse raw
  
  putStrLn "Part 1:"
  print (partOne par)
  putStrLn "Part 2:"
  print (partTwo par)

