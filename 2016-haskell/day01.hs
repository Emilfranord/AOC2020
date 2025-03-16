import Data.List.Split

type Ingoing = Integer

type Outgoing = Integer


data Inst = LL Integer | RR Integer

instance Show Inst where
    show (LL q) = "ll" ++ show q
    show (RR q) = "rr"  ++ show q


data Dir = N | S | E | W
instance Show Dir where
    show q = "what dir?"

rotate (LL q) N = W
rotate (LL q) W = S
rotate (LL q) S = E
rotate (LL q) E = N

rotate (RR q) N = E
rotate (RR q) W = N
rotate (RR q) S = W
rotate (RR q) E = S

walk (a,b) q N = (a+q,b)
walk (a,b) q S = (a-q,b)
walk (a,b) q E = (a,b+q)
walk (a,b) q W = (a,b-q)


actInstr  (dir, a,b) inst = (dir', a', b')
  where
    dir' = rotate inst dir
    getL (LL x) = x
    getL (RR x) = x
    (a', b') = walk (a,b) (getL inst) dir'


inter (a,b) (c,d) | a==c && b < d = [(a,x) | x <- [b .. d]] 
                  | a==c && b > d = [(a,x) | x <- [d .. b]] 
                  | b==d && a < c = [(x,b) | x <- [a .. c]] 
                  | b==d && a > c = [(x,b) | x <- [c .. a]] 

partOne :: Foldable t => t Inst -> Integer
partOne a = taxi
  where
    (d, x, y) = foldl actInstr (N, 0,0) a
    taxi = abs x + abs y


window [] = []
window xs = zip xs (tail xs)

onWindow f = map (uncurry f) . window

partTwo dat = concat (onWindow inter (map (\(x,y,z) -> (y,z)) (scanl actInstr (N, 0,0) dat)))

parseInst ('R' : tail) =  RR (read tail :: Integer)
parseInst ('L' : tail) =  LL (read tail :: Integer)


parse :: [[Char]] -> [Inst]
parse str = map parseInst (splitOn ", " (head str))

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
  