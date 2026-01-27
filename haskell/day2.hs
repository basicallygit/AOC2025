splitOnChar :: Char -> String -> [String]
splitOnChar splitChar str = case break (== splitChar) str of
	(a, splitChar:b) -> a : splitOnChar splitChar b
	(a, "")    -> [a]

isValid :: Int -> Bool
isValid n =
	let
		strN = show n
		len = length strN
		(half1, half2) = splitAt (len `div` 2) strN
	in even len && half1 == half2

parseRange :: String -> [Int]
parseRange pair =
	let [minStr, maxStr] = splitOnChar '-' pair
	in [read minStr .. read maxStr]

main :: IO ()
main = do
	content <- readFile "input.txt"
	let input = head (lines content)
	
	let
		ranges = splitOnChar ',' input
		allNumbers = concatMap parseRange ranges
		validNums  = filter isValid allNumbers
		result     = sum validNums
	
	putStrLn $ "Part 1: " ++ show result
