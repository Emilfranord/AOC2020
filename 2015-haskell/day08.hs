import Data.List.Utils (replace)

type Ingoing = String

type Outgoing = Integer


memLen :: String -> Int
memLen  = length 

applyList :: [a -> a] -> a -> a
applyList fs a = foldr ($) a fs

transforms = [replace "\"" "",
              replace "\\\"" "*", 
              replace "\\\\" "*",
              replace "\\x0" "",
              replace "\\x1" "",
              replace "\\x2" "",
              replace "\\x2" "",
              replace "\\x3" "",
              replace "\\x4" "",
              replace "\\x5" "",
              replace "\\x6" "",
              replace "\\x7" "",
              replace "\\x8" "",
              replace "\\x9" "",
              replace "\\xa" "",
              replace "\\xb" "",
              replace "\\xc" "",
              replace "\\xd" "",
              replace "\\xe" "",
              replace "\\xf" ""
            ]

litLen a = length (applyList transforms a) 

transformsII = [replace "\\x" "\\\\x",  replace "\\\"" "\\\\\"", replace "\"" "\\\""] --  replace "\\\"" "\\\\\""

repLen a = length (applyList transformsII a)


partOne :: (String, Int) -> Int
partOne (a,b) = (memLen a -  litLen a )


partTwo (a,b) = ( repLen a + 2 * b - memLen a)

parse :: [String] -> (String, Int)
parse a = (concat a, length a)

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/08-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/08.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  