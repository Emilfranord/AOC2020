import Data.List.Split
import Data.List
import Data.Maybe(mapMaybe, catMaybes)
import Data.Function.Memoize ( memoize2 ) 

type Ingoing = ([String], [String])

type Outgoing = Int


verifyDesign :: [String] -> String -> Bool
verifyDesign rules design = combDesignMem rules design /= 0

verifyDesignMem :: [String] -> String -> Bool
verifyDesignMem = memoize2 verifyDesign

combDesign :: [String] -> String -> Integer
combDesign rules design = if design == "" then 1 else below 
  where
    possibleRoutes = map (`stripPrefix` design) rules
    remainingRoutes = catMaybes possibleRoutes
    below = sum (map (combDesignMem rules ) remainingRoutes)

combDesignMem :: [String] -> String -> Integer
combDesignMem = memoize2 combDesign


partOne :: Ingoing -> Outgoing
partOne (rul, des) =  length (filter id (map (verifyDesignMem rul) des) )


partTwo (rul, des) =  sum (map (combDesignMem rul) des) 

parse :: [String] -> Ingoing
parse a = (patterns, designs)
  where
    halves = splitOn [""] a
    patterns = splitOn ", " (head (head halves)) 
    designs = halves !! 1

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/19-t.txt"
  let par = parse raw

  print par

  
  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/19.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  