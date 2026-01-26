data Lock = Lock {
	currentDial :: Int,
	zeroCount :: Int
} deriving (Show)

newLock :: Lock
newLock = Lock { currentDial = 50, zeroCount = 0 }

incZeroCount :: Lock -> Lock
incZeroCount lock = lock { zeroCount = zeroCount lock + 1 }

lockAtZero :: Lock -> Bool
lockAtZero lock = currentDial lock == 0

doRotation :: Lock -> Int -> Lock
doRotation lock n =
	let
		lock' = lock { currentDial = (currentDial lock + n + 100) `mod` 100 }
		lock'' = if lockAtZero lock' then incZeroCount lock' else lock'
	in
		lock''

doRotationCountAllZero :: Lock -> Int -> Lock
doRotationCountAllZero lock n =
	let
		direction = if n < 0 then -1 else 1
		steps = replicate (abs n) direction
	in
		foldl clickOnce lock steps

clickOnce :: Lock -> Int -> Lock
clickOnce lock d =
	let 
		nextDial = (currentDial lock + d + 100) `mod` 100
		nextLock = lock { currentDial = nextDial }
	in
		if nextDial == 0
		then nextLock { zeroCount = zeroCount nextLock + 1 }
		else nextLock

parseRotation :: String -> Int
parseRotation rotationString = read $ if head rotationString == 'L' then '-':tail rotationString else tail rotationString

parseLockRotations :: [String] -> [Int]
parseLockRotations rotations = map parseRotation rotations

main :: IO ()
main = do
	content <- readFile "input.txt"
	let rotations = parseLockRotations (lines content)
	--print $ zeroCount $ foldl doRotation newLock rotations
	putStrLn $ "Part 1: " ++ show (zeroCount $ foldl doRotation newLock rotations)
	putStrLn $ "Part 2: " ++ show (zeroCount $ foldl doRotationCountAllZero newLock rotations)
