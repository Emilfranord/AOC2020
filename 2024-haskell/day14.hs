import Text.Regex.Posix

import Data.List (intercalate, isInfixOf)
import Data.Maybe (fromMaybe)
import Data.List.Split

type Ingoing = [(Integer, Integer, Integer, Integer)]

type Outgoing = Int


advanceRobot :: Integral b => b -> b -> b -> (b, b, b, b) -> (b, b)
advanceRobot modX modY rounds (x,y,dx,dy) = (newX,newY)
  where
    newX = (x + (dx*rounds)) `mod` modX
    newY = (y + (dy*rounds)) `mod` modY

advanceManyRobots :: Integral b => b -> b -> b -> [(b, b, b, b)] -> [(b, b)]
advanceManyRobots modX modY rounds = map (advanceRobot modX modY rounds) 

quadrantSplit :: (Num b, Integral a1, Integral a2) => a1 -> a2 -> [(a1, a2)] -> [b]
quadrantSplit modX modY = map (quadrant . centerZero)
  where
    centerZero (a,b) = (a - modX `div` 2 , b - modY `div` 2 )
    quadrant (a,b)  | a < 0 && b < 0 = 1
                    | a < 0 && b > 0 = 2
                    | a > 0 && b < 0 = 3
                    | a > 0 && b > 0 = 4
                    | a == 0 || b == 0 = 0
    quadrant (a,b) = -1

safetyFactor :: (Eq a, Num a) => [a] -> Int
safetyFactor lst = amount 1 lst * amount 2 lst * amount 3 lst * amount 4 lst
  where
    amount n lst = length (filter (==n) lst)  

partOne :: Ingoing -> Outgoing
partOne a = safetyFactor (quadrantSplit x y (advanceManyRobots x y 100 a))
  where
    x = 101
    y = 103


finder lst item  = aux (item `elem` lst)
  where
    aux True = '#'
    aux False = '.'
    

showGrid :: (Foldable t, Eq b, Num b, Enum b) => Integer -> b -> t (Integer, b) -> [Char]
showGrid dimX dimY lst = if treeTrick then joined else ""
  where
    cartesianProductList xs ys = [(x,y) | x <- xs, y <- ys]
    boundsToGrid (a,b) =  cartesianProductList [0 .. a] [0 .. b]
    grid = map (finder lst) (boundsToGrid (dimX, dimY))
    segmented = chunksOf (fromInteger dimX) grid
    joined = intercalate "\r\n" segmented
    treeTrick = "########" `isInfixOf` joined 

partTwo :: Ingoing -> [Char]
partTwo a = concatMap (\rou -> showGrid x y (advanceManyRobots x y rou a) ++ (show rou ++ "\n")) [6000 .. 7000]
  where
    x = 101
    y = 103

numberExtractor :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numberExtractor str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[-0-9]+")

parse :: [String] -> [(Integer, Integer, Integer, Integer)]
parse  = map (toTuple . numberExtractor) 
  where
    toTuple lst = (head lst, lst !! 1, lst !! 2, lst !! 3) 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/14-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  --putStrLn (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/14.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStrLn "Part 2: "
  putStrLn (partTwo par)
  