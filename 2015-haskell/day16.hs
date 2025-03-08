import Text.Regex.Posix
import Data.Maybe ( isNothing)

numbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Int]
numbers str = map (\x -> (read x :: Int) ) (getAllTextMatches $ str =~ "[0-9]+")

data Aunt = Aunt {  children    :: Maybe Int
                  , cats        :: Maybe Int
                  , samoyeds    :: Maybe Int
                  , pomeranians :: Maybe Int
                  , akitas      :: Maybe Int
                  , vizslas     :: Maybe Int
                  , goldfish    :: Maybe Int
                  , trees       :: Maybe Int
                  , cars        :: Maybe Int
                  , perfumes    :: Maybe Int
                  }
                  deriving (Show)

data AuntProb = Children | Cats |Samoyeds |Pomeranians |Akitas | Vizslas |Goldfish  |Trees | Cars | Perfumes    

probPars :: String -> AuntProb
probPars "children" = Children
probPars "cats" = Cats
probPars "samoyeds" = Samoyeds
probPars "pomeranians" = Pomeranians
probPars "akitas" = Akitas
probPars "vizslas" = Vizslas
probPars "goldfish" = Goldfish
probPars "trees" = Trees
probPars "cars" = Cars
probPars "perfumes" = Perfumes
probPars s = error "prob not in list"

makeAunt = Aunt Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing

modifyAunt :: Aunt -> AuntProb -> Maybe Int -> Aunt
modifyAunt aunt Children value = aunt {children = value}
modifyAunt aunt Cats value = aunt {cats = value}
modifyAunt aunt Samoyeds value = aunt {samoyeds = value}
modifyAunt aunt Pomeranians value = aunt {pomeranians = value}
modifyAunt aunt Akitas value = aunt {akitas = value}
modifyAunt aunt Vizslas value = aunt {vizslas = value}
modifyAunt aunt Goldfish value = aunt {goldfish = value}
modifyAunt aunt Trees value = aunt {trees = value}
modifyAunt aunt Cars value = aunt {cars = value}
modifyAunt aunt Perfumes value = aunt {perfumes = value}

modifyAunt2 :: Aunt -> AuntProb -> Int -> Aunt
modifyAunt2 aunt prob val = modifyAunt aunt prob (Just val)

removeColon xs = [ x | x <- xs, x `notElem` ":"]

parseAunt :: [Char] -> (Int, Aunt)
parseAunt s = (id, aunt)
  where
    cleaned = removeColon s
    segments = words cleaned
    num = numbers cleaned
    id = head num
    (kI, vI) = (probPars (segments !! 2), num !! 1)
    (kII, vII) = (probPars (segments !! 4), num !! 2)
    (kIII, vIII) = (probPars(segments !! 6), num !! 3)
    aunt = modifyAunt2 (modifyAunt2 (modifyAunt2 makeAunt kI vI) kII vII) kIII vIII

validAunt :: Aunt -> (AuntProb, Int) -> Bool
validAunt aunt (Children, val) = (currentValue == Just val )    || isNothing currentValue where currentValue   = children aunt 
validAunt aunt (Cats, val) = (currentValue == Just val )        || isNothing currentValue where currentValue   = cats aunt 
validAunt aunt (Samoyeds, val) = (currentValue == Just val )    || isNothing currentValue where currentValue   = samoyeds aunt 
validAunt aunt (Pomeranians, val) = (currentValue == Just val ) || isNothing currentValue where currentValue   = pomeranians aunt 
validAunt aunt (Akitas, val) = (currentValue == Just val )      || isNothing currentValue where currentValue   = akitas aunt 
validAunt aunt (Vizslas, val) = (currentValue == Just val )     || isNothing currentValue where currentValue   = vizslas aunt 
validAunt aunt (Goldfish, val) = (currentValue == Just val )    || isNothing currentValue where currentValue   = goldfish aunt 
validAunt aunt (Trees, val) = (currentValue == Just val )       || isNothing currentValue where currentValue   = trees aunt 
validAunt aunt (Cars, val) = (currentValue == Just val )        || isNothing currentValue where currentValue   = cars aunt 
validAunt aunt (Perfumes, val) = (currentValue == Just val )    || isNothing currentValue where currentValue   = perfumes aunt 

keepValidId ::  [(Int, Aunt)] -> (AuntProb, Int) ->  [(Int, Aunt)]
keepValidId pairs (prob, val) = filter (\ (id, a) -> validAunt a (prob, val)) pairs

validAuntII :: Aunt -> (AuntProb, Int) -> Bool
validAuntII aunt (Children, val) = (currentValue == Just val )    || isNothing currentValue where currentValue   = children aunt 
validAuntII aunt (Cats, val) = (currentValue > Just val )        || isNothing currentValue where currentValue   = cats aunt 
validAuntII aunt (Samoyeds, val) = (currentValue == Just val )    || isNothing currentValue where currentValue   = samoyeds aunt 
validAuntII aunt (Pomeranians, val) = (currentValue < Just val ) || isNothing currentValue where currentValue   = pomeranians aunt 
validAuntII aunt (Akitas, val) = (currentValue == Just val )      || isNothing currentValue where currentValue   = akitas aunt 
validAuntII aunt (Vizslas, val) = (currentValue == Just val )     || isNothing currentValue where currentValue   = vizslas aunt 
validAuntII aunt (Goldfish, val) = (currentValue < Just val )    || isNothing currentValue where currentValue   = goldfish aunt 
validAuntII aunt (Trees, val) = (currentValue > Just val )       || isNothing currentValue where currentValue   = trees aunt 
validAuntII aunt (Cars, val) = (currentValue == Just val )        || isNothing currentValue where currentValue   = cars aunt 
validAuntII aunt (Perfumes, val) = (currentValue == Just val )    || isNothing currentValue where currentValue   = perfumes aunt 


keepValidIdII ::  [(Int, Aunt)] -> (AuntProb, Int) ->  [(Int, Aunt)]
keepValidIdII pairs (prob, val) = filter (\ (id, a) -> validAuntII a (prob, val)) pairs

type Ingoing = [(Int, Aunt)]

type Outgoing = [Int]


rules = [(Children, 3), 
         (Cats, 7), 
         (Samoyeds,2),
         (Pomeranians, 3),
         (Akitas, 0),
         (Vizslas, 0),
         (Goldfish, 5),
         (Trees, 3),
         (Cars, 2),
         (Perfumes, 1)
          ]

partOne :: Ingoing -> Outgoing
partOne a =  map fst (foldr (flip keepValidId) a rules)

partTwo :: Ingoing -> Outgoing
partTwo a = map fst (foldr (flip keepValidIdII) a rules)

parse :: [String] -> Ingoing
parse  = map parseAunt  

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/16-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/16.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  