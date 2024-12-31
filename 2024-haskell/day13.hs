import Text.Regex.Posix
import Data.List.Split

import Data.Bifunctor ( Bifunctor(bimap) )

type Ingoing = [[Integer]]

type Outgoing = Integer

(~~) :: (Ord a, Fractional a) => a -> a -> Bool
(~~) a b = 0.99999999999999 * a <= b && b <= 1.00000000000001 * a                            

isInt :: RealFrac a => a -> Bool
isInt x = x ~~ fromInteger (round x)

integerMatrix :: (RealFrac a, Fractional a) => (a,a)  -> Bool
integerMatrix = all isInt

inverse (a,b,c,d) = if det == 0 then Nothing else Just (d', -b', -c', a')
  where
    det = 1.0 / (a*d - b *c)
    a' = a * det
    b' = b * det
    c' = c * det
    d' = d * det

(***) :: Num b => (b, b, b, b) -> (b, b) -> (b, b)
(***) (a,b,c,d) (x,y) = (a*x + b*y, c*x+d*y) 

systemSolution m (x,y) = solution (inverse m)
  where
    solution Nothing = error "There is not a unique solution for this system"
    solution (Just inv) = inv *** (x,y)

singleSolve :: (RealFrac b1, Integral b2) => [Integer] -> b1 -> ((b1, b1) -> Bool) -> b2
singleSolve d offset condition = total
  where
    da = map fromInteger d
    matrix = (head da, da !! 2,  da !! 1, da !! 3)
    solution = systemSolution matrix (offset + da !! 4, offset + da !! 5)
    validSolution = if integerMatrix solution && condition solution  then solution else (0,0)
    roundedSol = bimap round round validSolution
    total = 3 * fst roundedSol + snd roundedSol

partOne :: Ingoing -> Outgoing
partOne a = sum (map (\x -> singleSolve x 0 (\(a,b) -> a <= 100 && b <= 100))  a)

partTwo :: Ingoing -> Outgoing
partTwo a =  sum (map (\x -> singleSolve x 10000000000000 (\(a,b) -> a >= 100 && b >= 100))  a)

numberExtractor :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numberExtractor str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[0-9]+")

parse :: (Foldable t, RegexContext Regex a (AllTextMatches [] String)) => t a -> [[Integer]]
parse dat = chunksOf 6 (concatMap numberExtractor dat)

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/13-t.txt"
  let par =  parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/13.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  