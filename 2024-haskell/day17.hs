import GHC.Integer (xorInteger)
import Text.Regex.Posix

numberExtractor :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numberExtractor str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[-0-9]+")

type Ingoing = Integer

type Outgoing = Integer

type State = (Integer, Integer,  Integer, Integer, [Integer], [Integer]) 

data Operation = ADV | BXL | BST | JNZ | BXC | OUT | BDV | CDV | HALT

literalOperand x = x

comboOperand :: Integer -> State -> Integer
comboOperand 0 sta = 0   
comboOperand 1 sta = 1
comboOperand 2 sta = 2 
comboOperand 3 sta = 3  
comboOperand 4 (a, b, c, pc, pro, out) = a  
comboOperand 5 (a, b, c, pc, pro, out) = b
comboOperand 6 (a, b, c, pc, pro, out) = c
comboOperand 7 (a, b, c, pc, pro, out) = error "not a valid program"    

operation :: Integer -> Operation
operation 0 = ADV
operation 1 = BXL
operation 2 = BST
operation 3 = JNZ
operation 4 = BXC
operation 5 = OUT
operation 6 = BDV
operation 7 = CDV
operation x = HALT

extractCombo (a, b, c, pc, pro, out) = comboOperand (pro !! ( fromInteger pc + 1 )) (a, b, c, pc, pro, out)

extractLiteral (a, b, c, pc, pro, out) = literalOperand (pro !! ( fromInteger pc + 1 ))

performOperation :: State -> Operation -> State
performOperation (a, b, c, pc, pro, out) ADV = (nA, b, c, pc+2, pro, out)
  where 
    nA = a `div` (2 ^ extractCombo (a, b, c, pc, pro, out))
performOperation (a, b, c, pc, pro, out) BXL = (a, nB, c, pc+2, pro, out)
  where
    nB = xorInteger b (extractLiteral (a, b, c, pc, pro, out))
performOperation (a, b, c, pc, pro, out) BST = (a, nB, c, pc+2, pro, out)
  where
    nB = extractCombo (a, b, c, pc, pro, out) `mod` 8
performOperation (a, b, c, pc, pro, out) JNZ = if a == 0 then notJumps else jumps
  where
    jumps = (a, b, c, extractLiteral (a, b, c, pc, pro, out), pro, out)
    notJumps = (a, b, c, pc+2, pro, out)
performOperation (a, b, c, pc, pro, out) BXC = (a, nB, c, pc+2, pro, out)
  where
    nB = xorInteger b c
performOperation (a, b, c, pc, pro, out) OUT = (a, b, c, pc+2, pro, outgo : out )
  where
    outgo = extractCombo (a, b, c, pc, pro, out) `rem` 8
performOperation (a, b, c, pc, pro, out) BDV = (a, nB, c, pc+2, pro, out)
  where 
    nB = a `div` (2 ^ extractCombo (a, b, c, pc, pro, out)) -- read from A, and placed in B
performOperation (a, b, c, pc, pro, out) CDV = (a, b, nC, pc+2, pro, out)
  where 
    nC = a `div` (2 ^ extractCombo (a, b, c, pc, pro, out)) -- read from A, and placed in C
performOperation sta HALT = sta

findDefault :: a -> [a] -> Int -> a
findDefault de xs     n | n < 0  = de
findDefault de []      _         = de  
findDefault de (x:_)   0         = x
findDefault de (_:xs)  n         = findDefault de xs (n-1)

advanceState (a, b, c, pc, pro, out) = performOperation (a, b, c, pc, pro, out) (operation (findDefault 100 pro (fromInteger pc)))

advanceStateSeveral init rounds = foldr (\ item sta -> advanceState sta ) init [1 .. rounds]

partOne :: State -> [Integer]
partOne sta = reverse out
  where
    (a, b, c, pc, pro, out) = advanceStateSeveral sta 150


outputsSelf sta = reverse out == pro
  where
    (a, b, c, pc, pro, out) = advanceStateSeveral sta 40000


partTwo (a, b, c, pc, pro, out) =  filter (/= 0) (map (\x -> if outputsSelf (x, b, c, pc, pro, out) then x else 0) [0 .. 117440 ])

parse ::  [String] -> State
parse inp = (a,b,c,0,program, [])
  where 
    a = head (numberExtractor (head inp))
    b = head (numberExtractor (inp !! 1))
    c = head (numberExtractor (inp !! 2))
    program = numberExtractor (inp !! 4)


readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/17-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  --print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/17.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  