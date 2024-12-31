
import Text.Regex.Posix

type Ingoing = [[Equation]]

type Outgoing = Integer

data Equation = Val Integer | PLUS | TIMES | CON

instance Show Equation where
    show (Val x) = show x
    show PLUS = "+"
    show TIMES = "*"
    show CON = "||"

(-==) :: Equation -> Equation -> Bool
(-==) (Val a) (Val b ) = a == b
(-==) PLUS PLUS = True
(-==) TIMES TIMES = True
(-==) CON CON = True
(-==) a b = False

(!!!) ::  Equation -> Integer
(!!!) (Val x)  =  x
(!!!) PLUS  =  0
(!!!) TIMES  =  0
(!!!) CON  =  0

allCombinations ::  [Equation] -> [[Equation]]
allCombinations lst = map (drop 1) q 
  where
    q = foldl (\state element -> map (\x -> x ++ [PLUS] ++ [element]) state ++ map (\x -> x ++ [TIMES] ++ [element]) state ) [[]] lst 


(||) :: Integer -> Integer -> Integer
(||) a b = read (show a ++ show b) :: Integer 

evaluate :: [Equation] -> Equation
evaluate lst = Val (fst q)
  where
    aux (x, Val y) (Val z) = (z, Val z)
    aux (x, PLUS) (Val z) = (x+z, Val (x+z))
    aux (x, TIMES) (Val z) = (x*z, Val (x*z))
    aux (x, CON) (Val z) = (x Main.|| z , Val (x Main.|| z))
    aux (x, _) PLUS = (x, PLUS)
    aux (x, _) TIMES = (x, TIMES)
    aux (x, _) CON = (x, CON)
    q = foldl aux (0, Val 0) lst

verify :: [Equation] -> Bool
verify (result : numbers) = valid
  where
    combos = allCombinations numbers
    results = map Main.evaluate combos
    valid = any (-== result) results

partOne :: Ingoing -> Outgoing
partOne a = sum ( map ((!!!) . head) (filter verify a))

partTwo :: Ingoing -> Outgoing
partTwo  = partOne

numberExtractor :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numberExtractor str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[0-9]+")

parse :: [String] -> [[Equation]]
parse  = map (map Val . numberExtractor)

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/07-t.txt"
  let par =  parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/07.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  