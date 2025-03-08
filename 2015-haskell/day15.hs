import Text.Regex.Posix
type Ingoing = String

type Outgoing = Integer

signedNumbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
signedNumbers str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "-?[0-9]+")


(!*) :: Num b => b -> [b] -> [b]
(!*) scalar = map ( scalar * )

(!+) :: Num b => [b] -> [b] -> [b]
(!+)  = zipWith (+) 

totalScore ingredients amounts = (total, calories)
  where
    foo = zip ingredients amounts
    inter = map (\(a,b) -> b !* a) foo
    propSum = foldl (!+) [0,0,0,0, 0] inter
    zeroing = map (max 0) propSum

    total = product (take 4 zeroing)
    calories = zeroing !! 4



amounts = [(i,j,k,n) |  i <- [0 .. 100],
                    j <- [0 .. 100],
                    k <- [0 .. 100],
                    n <- [0 .. 100] 
                    ]

validAmounts = filter (\(a,b,c,d) -> a + b + c + d == 100) amounts

partOne foo = maximum( map fst (map (\ (a,b, c, d ) -> totalScore foo [a,b,c,d ]) validAmounts))

partTwo foo =  maximum (map fst (filter (\(score, cal ) -> cal == 500 )(map (\ (a,b, c, d ) -> totalScore foo [a,b,c,d ]) validAmounts)))



parse = map signedNumbers 

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/15-t.txt"
  let par = parse raw

  print par

  putStrLn "Test Input"
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)

  putStrLn ""
  putStrLn "Real Input"
  raw <- readLines "input/15.txt"
  let par =  parse raw
  
  putStr "Part 1: "
  print (partOne par)
  
  putStr "Part 2: "
  print (partTwo par)
  