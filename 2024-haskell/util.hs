

answers :: (a1 -> t) -> (t -> a2) -> (t -> a3) -> [Char] -> IO ()
    answers parse partOne partTwo num = do
        raw <- readLines ("input/" ++ num ++ "-t.txt")
        let par = parse raw

        putStrLn "Parsed input"
        print par
        
        putStrLn "Test Input"
        putStr "Part 1: "
        print (partOne par)
        
        putStr "Part 2: "
        print (partTwo par)

        putStrLn ""
        putStrLn "Real Input"
        raw <- readLines ("input/" ++ num ++ ".txt")
        let par =  parse raw
        
        putStr "Part 1: "
        print (partOne par)
        
        putStr "Part 2: "
        print (partTwo par)
    