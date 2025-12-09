module Main where

import Data.Complex
import Data.List
import System.Environment
import Text.Printf
import Data.Bits ((.&.))

isPowerOfTwo :: Int -> Bool
isPowerOfTwo n = n > 0 && (n .&. (n-1)) == 0
  

fft :: [Complex Double] -> [Complex Double]
fft xs = let n = length xs in
  if n == 1 then xs else
  let (ev, od) = splitEvensOdds xs
      ye = fft ev
      yo = fft od
      wn = cis (-2 * pi / fromIntegral n)  -- primitive n-th root of unity
      -- compute powers w^k for k=0..n/2-1
      ws = take (n `div` 2) $ iterate (* wn) 1
      combine' = zipWith3 (\y e w -> (y + w*e, y - w*e)) ye yo ws
      -- zipWith3 above produces pairs (index k results), but we need to flatten
      out = concatMap (\(a,b) -> [a,b]) combine'
  in out

splitEvensOdds :: [a] -> ([a],[a])
splitEvensOdds = foldr (\x (es,os) -> (x:os, es)) ([],[]) . reverse

dft :: [Complex Double] -> [Complex Double]
dft xs =
  let n = length xs
      wn = cis (-2 * pi / fromIntegral n)
  in [ sum [ xs !! k * (wn ** (fromIntegral (j*k))) | k <- [0..n-1] ] | j <- [0..n-1] ]

maxError :: [Complex Double] -> [Complex Double] -> Double
maxError a b = maximum $ zipWith (\x y -> magnitude (x - y)) a b

sampleSignal :: Int -> [Complex Double]
sampleSignal n =
  [ cis (2*pi*(fromIntegral k)*f / fromIntegral n) + (0.000001 :+ 0)
  | k <- [0..n-1]
  ]
  where f = 3 :: Double

printFirst :: Int -> [Complex Double] -> IO ()
printFirst m xs =
  mapM_ (\(i, a:+b) -> printf "%2d: % .6f %+ .6fi\n" i a b)
        (zip [0 :: Int ..] (take m xs))


main :: IO ()
main = do
  args <- getArgs
  let n = case args of
            (s:_) -> read s :: Int
            []    -> 8
  if not (isPowerOfTwo n)
    then error "n must be a power of two"
    else do
      let sig = sampleSignal n
      let f1 = fft sig
      let f2 = dft sig
      let err = maxError f1 f2
      putStrLn $ "n = " ++ show n
      putStrLn $ "max error (fft vs dft) = " ++ show err
      putStrLn "first 8 outputs (FFT):"
      printFirst (min 8 n) f1
      putStrLn "first 8 outputs (DFT):"
      printFirst (min 8 n) f2
