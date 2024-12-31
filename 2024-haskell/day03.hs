import Text.Regex.Posix

type Ingoing = String

type Outgoing = Integer

strInt :: String -> Integer
strInt x = read x :: Integer

partOne :: RegexContext Regex p (AllTextMatches [] String) => p -> Integer
partOne dat = total
  where
    matches = getAllTextMatches $ dat =~ "mul\\([0-9]{1,3},[0-9]{1,3}\\)" :: [String]
    numbers = map (\x -> getAllTextMatches $ x =~ "[0-9]+") matches
    products = map(\x -> (read (head x) :: Integer )* (read (x !! 1) :: Integer) ) numbers
    total = sum products

data State = READ | NOREAD | VALUE

partTwo :: RegexContext Regex p (AllTextMatches [] String) => p -> Integer
partTwo dat = total
  where
    matches = getAllTextMatches $ dat =~ "don't\\(\\)|do\\(\\)|mul\\([0-9]{1,3},[0-9]{1,3}\\)" :: [String]
    products x =  strInt (head x) * strInt (x !! 1)
    extractor ('d':'o':'n': tail) = (0,NOREAD)
    extractor ('d':'o':'(': tail) = (0,READ) 
    extractor ('m':'u':'l': tail) = (products ( getAllTextMatches $ tail =~ "[0-9]+" :: [String]), VALUE)
    numbers = map extractor matches
    folder (k,READ) (0,NOREAD) = (k,NOREAD)
    folder (k,READ) (0,READ) = (k,READ)
    folder (k,READ) (y,VALUE) = (k+y,READ)
    folder (k,NOREAD) (0,NOREAD) = (k,NOREAD)
    folder (k,NOREAD) (0,READ) = (k,READ)
    folder (k,NOREAD) (y,VALUE) = (k,NOREAD)
    total = fst (foldl folder (0,READ) numbers)

parse :: [String] -> Ingoing
parse = concat

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/03-t.txt"
  let par =  parse raw
  
  print "Test Input"
  print "Part 1: "
  print (partOne par)
  
  print "Part 2: "
  print (partTwo par)

  print ""
  print "Real Input"
  raw <- readLines "input/03.txt"
  let par =  parse raw
  
  print "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
