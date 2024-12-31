type Ingoing = [[Char]]

type Outgoing = Integer

data Direction = Left | Right | Up | Down | O1 | O5 | O7 | O10

findDefault :: a -> [a] -> Int -> a
findDefault de xs     n | n < 0  = de
findDefault de []      _         = de  
findDefault de (x:_)   0         = x
findDefault de (_:xs)  n         = findDefault de xs (n-1)

(!!!) :: [[Char]] -> (Int, Int) -> Char
(!!!) grid (x,y) =  findDefault '.' (findDefault [] grid x ) y

search :: [[Char]] -> (Int, Int) -> Direction -> String
search grid (x,y) Main.Left =  map (grid !!!) [(x,y), (x+1,y), (x+2,y), (x+3,y)]
search grid (x,y) Main.Right = map (grid !!!) [(x,y), (x-1,y), (x-2,y), (x-3,y)]
search grid (x,y) Main.Up =    map (grid !!!) [(x,y), (x,y+1), (x,y+2), (x,y+3)]
search grid (x,y) Main.Down =  map (grid !!!) [(x,y), (x,y-1), (x,y-2), (x,y-3)]
search grid (x,y) Main.O1 =    map (grid !!!) [(x,y), (x+1, y+1),(x+2, y+2),(x+3, y+3)]
search grid (x,y) Main.O7 =    map (grid !!!) [(x,y), (x-1, y-1),(x-2, y-2),(x-3, y-3)]
search grid (x,y) Main.O5 =    map (grid !!!) [(x,y), (x+1,y-1), (x+2,y-2), (x+3,y-3)]
search grid (x,y) Main.O10 =   map (grid !!!) [(x,y), (x-1,y+1), (x-2,y+2), (x-3,y+3)]


partOne :: Ingoing -> Outgoing
partOne inp = toInteger (filerString inp "XMAS")
  where
    filerString grid str = length (filter (str ==) (searchAllDirAllCords grid))
    cartProd xs ys = [(x,y) | x <- xs, y <- ys]
    sizeToCart (a,b) =  cartProd [0 .. a] [0 .. b]
    matrixSize grid = (length grid, length (head grid))
    searchAllDir grid cord = map (search grid cord) [Main.Left, Main.Right, Up, Down, O1, O5, O7, O10]
    searchAllDirAllCords grid = concatMap (searchAllDir grid) (sizeToCart (matrixSize grid))


crossSearch :: [[Char]] -> (Int, Int) -> Bool
crossSearch grid (x,y) = length (filter ("MAS" ==) [a, b, c, d] ) == 2
  where
    a = map (grid !!!) [(x-1,y-1), (x,y), (x+1,y+1)]
    b = map (grid !!!) [(x+1,y+1), (x,y), (x-1,y-1)]
    c = map (grid !!!) [(x+1,y-1), (x,y), (x-1,y+1)]
    d = map (grid !!!) [(x-1,y+1), (x,y), (x+1,y-1)]

partTwo :: Ingoing -> Outgoing
partTwo grid = toInteger (crossSearchAllCords grid)
  where
    cartProd xs ys = [(x,y) | x <- xs, y <- ys]
    sizeToCart (a,b) =  cartProd [0 .. a] [0 .. b]
    matrixSize grid = (length grid, length (head grid))
    searchAllCords = map (crossSearch grid) (sizeToCart (matrixSize grid))
    crossSearchAllCords grid = length (filter id searchAllCords)

parse :: [String] -> Ingoing
parse void = void

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/04-t.txt"
  let par =  parse raw
  
  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/04.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
