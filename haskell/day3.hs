import Data.Char (digitToInt)
import Data.List (tails)

makeJolts :: Int -> Int -> Int
makeJolts int1 int2 = 10 * int1 + int2

pairHeadWithRest :: [Int] -> [Int]
pairHeadWithRest [] = []
pairHeadWithRest (int1:rest) = map (makeJolts int1) rest

allPairs :: [Int] -> [Int]
allPairs digits = concatMap pairHeadWithRest (tails digits)

maxJoltage :: String -> Int
maxJoltage str = maximum $ allPairs $ map digitToInt str

main :: IO ()
main = do
	content <- readFile "input.txt"
	let input = lines content
	let part1 = sum $ map maxJoltage input
	putStrLn $ "Day 3: " ++ show part1
