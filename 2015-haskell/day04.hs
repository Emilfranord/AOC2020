import Data.List
import Data.Digest.Pure.MD5
import qualified Data.ByteString.Lazy.Char8 as C8

type Ingoing = String

type Outgoing = Integer

md5Hash a = show (md5 (C8.pack a))

partOne a = filter (\(a,b) -> "00000" `isPrefixOf` a) (map (\x -> (md5Hash (a ++ show x), x)) [0 .. 209050])

partTwo a = filter (\(a,b) -> "000000" `isPrefixOf` a) (map (\x -> (md5Hash (a ++ show x), x)) [3938030 .. 3938038 + 10])

parse :: [String] -> Ingoing
parse = head

readLines :: FilePath -> IO [String]
readLines = fmap Data.List.lines . readFile

main :: IO ()
main = do
  raw <- readLines "input/04-t.txt"
  let par = parse raw

  print par

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
  