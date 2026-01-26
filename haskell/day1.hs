import Data.List (foldl')
import Text.Read (readMaybe)

parseMove :: String -> Maybe (Char, Int)
parseMove [] = Nothing
parseMove (direction:distanceStr) = case readMaybe distanceStr of
	Just distance -> Just (direction, distance)
	Nothing       -> Nothing

processMove :: (Int, Int) -> String -> (Int, Int)
processMove (currentDial, zeroCount) line =
	case parseMove line of
		Just (direction, distance) ->
			let
				tempVal = case direction of
					'L' -> (currentDial - distance) `mod` 100
					'R' -> (currentDial + distance) `mod` 100
					_   -> currentDial
				newZeroCount = if tempVal == 0 then zeroCount + 1 else zeroCount
			in (tempVal, newZeroCount)
		Nothing -> (currentDial, zeroCount)

main :: IO ()
main = do
	content <- readFile "input.txt"
	let initialState = (50, 0)

	let finalState = foldl' processMove initialState (lines content)
	let (finalDial, zeroCount) = finalState
	putStrLn $ "Num of zeroes: " ++ show zeroCount
