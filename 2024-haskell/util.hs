
import Text.Regex.Posix

numbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
numbers str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[0-9]+")

signedNumbers :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
signedNumbers str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "-?[0-9]+")

digits :: RegexContext Regex source1 (AllTextMatches [] String) => source1 -> [Integer]
digits str = map (\x -> (read x :: Integer) ) (getAllTextMatches $ str =~ "[0-9]")