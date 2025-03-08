
import Data.List (nub)

move '^' (x,y) = (x+1,y) 
move 'v' (x,y) = (x-1,y) 
move '>' (x,y) = (x,y+1) 
move '<' (x,y) = (x,y-1) 
move e (x,y) = (0,0)

type Ingoing = String

type Outgoing = Integer

partOne a = length (nub (foldr (\ele sta -> move ele (head sta) : sta ) [(0,0)] a ))


evenOddSplit :: [a] -> ([a], [a])
evenOddSplit [] = ([], [])
evenOddSplit (x:xs) = (x:o, e)
    where (e,o) = evenOddSplit xs

partTwo a = totalVisits
  where
    (santa, robot) = evenOddSplit a
    santaVisits = foldr (\ele sta -> move ele (head sta) : sta ) [(0,0)] santa 
    robotVisits = foldr (\ele sta -> move ele (head sta) : sta ) [(0,0)] robot
    totalVisits = length (nub (santaVisits ++ robotVisits))

parse :: [String] -> Ingoing
parse  = head 

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
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/03.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  