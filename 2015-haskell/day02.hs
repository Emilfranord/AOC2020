
import Text.Regex.Posix
import Data.List 

numbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numbers str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[0-9]+")

type Ingoing = [(Integer, Integer, Integer)]

type Outgoing = Integer

boxArea :: Num a => a -> a -> a -> a
boxArea l w h = 2*l*w + 2*w*h + 2*h*l
smallestSide :: (Ord a, Num a) => a -> a -> a -> a
smallestSide l w h = minimum [l*w, w*h, h*l]
totalPaper :: (Num a, Ord a) => a -> a -> a -> a
totalPaper l w h = boxArea l w h + smallestSide l w h

volume :: Num a => a -> a -> a -> a
volume l w h = l*w*h
smallestPerimeter :: (Num a, Ord a) => a -> a -> a -> a
smallestPerimeter l w h = lo+lo+mid+mid
  where  
    (lo,mid,hi) = toTuple (sort [l,w,h])

totalRibbon l w h  = volume l w h +  smallestPerimeter l w h

partOne :: Ingoing -> Outgoing
partOne a = sum (map (\(l,w,h) -> totalPaper l w h) a )

partTwo :: Ingoing -> Outgoing
partTwo a = sum (map (\(l,w,h) -> totalRibbon l w h) a )

toTuple (a:b:c:tail) = (a,b,c)
toTuple x = (0,0,0)

parse :: [String] -> Ingoing
parse = map (toTuple . numbers)


readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/02-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/02.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  