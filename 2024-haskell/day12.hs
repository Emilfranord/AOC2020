import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (catMaybes, mapMaybe)


type Ingoing = Integer

type Outgoing = Integer

type Mapping = Map (Int, Int) (Char, Maybe Integer)

fromJust :: Maybe a -> a
fromJust (Just a) = a
fromJust Nothing = error "Not Found"


stateTransfer :: Mapping -> (Int, Int) -> Mapping
stateTransfer state coord = newState
  where
    (x,y) = coord
    (itemChar, itemId) = fromJust (Map.lookup coord state)
    largestID = maximum (mapMaybe (snd . snd) (Map.toList state) ++ [0])
    north = Map.lookup (x+1,y ) state
    south = Map.lookup (x-1,y ) state
    east  = Map.lookup (x  ,y+1) state
    west  = Map.lookup (x  ,y-1) state
    friends = [north, south, east, west]
    definedFriends = catMaybes friends
    sameChar = filter (\(a,b) -> a == itemChar) definedFriends
    identifier  = mapMaybe snd sameChar ++ [largestID + 1]
    newState = Map.insert coord (itemChar, Just (head identifier)) state 

assignIds :: Mapping -> Mapping
assignIds state = Prelude.foldr (flip stateTransfer ) state coords
  where 
    coords = map fst (Map.toList state)

useIds = Map.map (\(a,b) -> [fromJust b])

invert :: Ord v => Map k [v] -> Map v [k]
invert m = Map.fromListWith (++) pairs
    where pairs = [(v, [k]) | (k, vs) <- Map.toList m, v <- vs]

partOne a = invert ( useIds (assignIds a))

partTwo a = -1


parse :: [[Char]] -> Map (Int, Int) (Char, Maybe Integer)
parse dat = Map.fromList addIdentifier
  where
    cartProd xs ys = [(x,y) | x <- xs, y <- ys]
    sizeToCart (a,b) =  cartProd [0 .. a-1] [0 .. b-1]
    matrixSize grid = (length (head grid),length grid)
    elements = Prelude.map (\(x,y) -> ((y,x), (dat !! x) !! y)) (sizeToCart (matrixSize dat))
    addIdentifier = map (\(coord, val) -> (coord, (val, Nothing))) elements

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

  raw <- readLines "input/12-tt.txt"
  let par = parse raw

  print par

  putStrLn "Test Input II"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  raw <- readLines "input/12-ttt.txt"
  let par = parse raw

  print par

  putStrLn "Test Input III"
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
  
  putStrLn "Part 2: "
  print (partTwo par)
  