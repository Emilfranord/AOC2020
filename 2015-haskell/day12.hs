import Text.Regex.Posix

numbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numbers str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "-?[0-9]+")

type Ingoing = String

type Outgoing = Integer


partOne a = sum (numbers a)


findReds :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [String]
findReds str = getAllTextMatches $ str =~ "\\{([^[])*?red([^]])*?\\}"


partTwo a = (include- exclude) -- does not work 
  where
    include = sum (numbers a)
    exclude = sum (map (sum . numbers) (findReds a))
    




parse :: [String] -> Ingoing
parse  = concat

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/12-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/12.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  --print (partTwo par)
  