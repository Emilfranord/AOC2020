import Data.List
import Data.Tuple

type Ingoing = [Instr]

type Outgoing = Integer

data Register = A | B | C | D | IP
instance Show Register where
  show A = "a"
  show B = "b"
  show C = "c"
  show D = "d"
  show IP = "ip"

data Instr =  Cpy Integer Register 
            | Cpy' Register Register
            | Inc Register
            | Dec Register
            | Jnz Integer Integer
            | Jnz' Register Integer

instance Show Instr where
  show (Cpy x y   ) = "cpy: "   ++ show x ++ " " ++ show y 
  show (Cpy' x y  ) = "cpy': "  ++ show x ++ " " ++ show y 
  show (Inc x     ) = "inc: "   ++ show x
  show (Dec x     ) = "dec: "   ++ show x
  show (Jnz x y   ) = "jnz: "   ++ show x ++ " " ++ show y 
  show (Jnz' x y  ) = "jnz': "  ++ show x ++ " " ++ show y 

parseRegister :: String -> Register
parseRegister str | str == "a" = A
                  | str == "b" = B
                  | str == "c" = C
                  | str == "d" = D

checkRegister :: String -> Bool
checkRegister str | str == "a" = True
                  | str == "b" = True
                  | str == "c" = True
                  | str == "d" = True
                  |otherwise = False

parseInstr :: String -> Instr
parseInstr str  | "cpy" `isPrefixOf` str =  if checkRegister (words str !! 1) 
                                            then Cpy' (parseRegister (words str !! 1)) (parseRegister (words str !! 2)) 
                                            else Cpy (read (words str !! 1) :: Integer) (parseRegister (words str !! 2)) 
                | "inc" `isPrefixOf` str = Inc (parseRegister (words str !! 1)) 
                | "dec" `isPrefixOf` str = Dec (parseRegister (words str !! 1)) 
                | "jnz" `isPrefixOf` str = if checkRegister (words str !! 1) 
                                           then Jnz' (parseRegister (words str !! 1)) (read (words str !! 2) :: Integer)
                                           else Jnz (read (words str !! 1) :: Integer) (read (words str !! 2) :: Integer) 
                | otherwise = Cpy' A A -- this represents a nop or id instruction 

type Memory = (Integer, Integer, Integer, Integer, Integer)
readMem :: Memory -> Register -> Integer
readMem (a,b,c,d,ip) A = a
readMem (a,b,c,d,ip) B = b
readMem (a,b,c,d,ip) C = c
readMem (a,b,c,d,ip) D = d
readMem (a,b,c,d,ip) IP = ip

writeMem :: Memory -> Register -> Integer -> Memory 
writeMem (a,b,c,d,ip) A value = (value,b,c,d,ip)
writeMem (a,b,c,d,ip) B value = (a,value,c,d,ip)
writeMem (a,b,c,d,ip) C value = (a,b,value,d,ip)
writeMem (a,b,c,d,ip) D value = (a,b,c,value,ip)
writeMem (a,b,c,d,ip) IP value = (a,b,c,d,value)

actInstr :: Memory -> Instr -> Memory
actInstr mem (Cpy x y ) = writeMem mem y x
actInstr mem (Cpy' x y) = writeMem mem y (readMem mem x)
actInstr mem (Inc x   ) = writeMem mem x (readMem mem x + 1 )
actInstr mem (Dec x   ) = writeMem mem x (readMem mem x - 1 )
actInstr mem (Jnz x y ) = if x /= 0 then writeMem mem IP (readMem mem IP + y - 1) else mem
actInstr mem (Jnz' x y) = if readMem mem x /= 0 then writeMem mem IP (readMem mem IP + y - 1) else mem

actInstr' mem main = writeMem new IP (readMem new IP + 1)
  where
    new = actInstr mem main

actInstructions :: [Instr] -> Memory -> Memory
actInstructions instructions mem = if stopNow then mem else next
  where
    largestIP =  length instructions
    currentIP = fromInteger (readMem mem IP)
    stopNow =  currentIP >= largestIP
    next = actInstr' mem (instructions !! currentIP)


partOne :: Ingoing -> Outgoing
partOne instruct = readMem (foldr (\ _ sta -> actInstructions instruct sta) (0,0,0,0,0) [0 .. 30000000]) A

partTwo :: Ingoing -> Outgoing
partTwo instruct = readMem (foldr (\ _ sta -> actInstructions instruct sta) (0,0,1,0,0) [0 .. 30000000]) A

parse :: [String] -> Ingoing
parse = map parseInstr 

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

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/12.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  