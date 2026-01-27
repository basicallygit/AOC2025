splitOnChar :: Char -> String -> [String]
splitOnChar splitChar str = case break (== splitChar) str of
	(a, splitChar:b) -> a : splitOnChar splitChar b
	(a, "")    -> [a]

isInvalid :: Int -> Bool
isInvalid n =
	let
		strN = show n
		len = length strN
		(half1, half2) = splitAt (len `div` 2) strN
	in even len && half1 == half2

isInvalidRepeated :: Int -> Bool
isInvalidRepeated n = any (isPattern strN) possibleLengths
	where
		strN = show n
		len = length strN
		possibleLengths = [k | k <- [1 .. len `div` 2], len `mod` k == 0]
		isPattern str k = concat (replicate (len `div` k) (take k str)) == str

parseRange :: String -> [Int]
parseRange pair =
	let [minStr, maxStr] = splitOnChar '-' pair
	in [read minStr .. read maxStr]

main :: IO ()
main = do
	content <- readFile "input.txt"
	let input = head (lines content)
	
	let
		ranges        = splitOnChar ',' input
		allNumbers    = concatMap parseRange ranges
		validNumsOne  = filter isInvalid allNumbers
		resultOne     = sum validNumsOne
		validNumsTwo  = filter isInvalidRepeated allNumbers
		resultTwo     = sum validNumsTwo
		
	
	putStrLn $ "Part 1: " ++ show resultOne
	putStrLn $ "Part 2: " ++ show resultTwo
