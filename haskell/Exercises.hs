module Exercises
    ( change,
      firstThenApply,
      powers,
      meaningfulLineCount,
      volume,
      surfaceArea,
      Shape(Sphere, Box),
      size,
      inorder,
      show,
      insert,
      contains,
      BST(Empty)
    ) where

import qualified Data.Map as Map
import Data.Text (pack, unpack, replace)
import Data.List(isPrefixOf, find)
import Data.Char(isSpace)
import Control.Arrow (Arrow(first))

change :: Integer -> Either String (Map.Map Integer Integer)
change amount
    | amount < 0 = Left "amount cannot be negative"
    | otherwise = Right $ changeHelper [25, 10, 5, 1] amount Map.empty
        where
          changeHelper [] remaining counts = counts
          changeHelper (d:ds) remaining counts =
            changeHelper ds newRemaining newCounts
              where
                (count, newRemaining) = remaining `divMod` d
                newCounts = Map.insert d count counts

-- First then apply function 
firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply xs pred f = f <$> find pred xs

-- Infinite powers generator function
powers :: Integral a => a -> [a]
powers base = map (base^) [0..]

-- Line count function (help from Dr. Toal)
meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount path = do
    contents <- readFile path
    return $ length $ filter meaningfulLine $ lines contents
    where
      meaningfulLine line = not (all isSpace line) && not ("" `isPrefixOf` line)

-- Write your shape data type here (help from Dr. Toal)
data Shape = 
  Sphere Double 
  | Box Double Double Double 
  deriving (Eq, Show)

volume :: Shape -> Double
volume (Sphere r) = 4 * pi * r^3 / 3
volume (Box l w h) = l * w * h

surfaceArea :: Shape -> Double
surfaceArea (Sphere r) = 4 * pi * r^2
surfaceArea (Box l w h) = 2 * (l * w + w * h + h * l)

-- Binary search tree algebraic type function (help from built-in AI tools)
data BST a 
  = Empty 
  | Node a (BST a) (BST a)

size :: BST a -> Int
size Empty = 0
size (Node _ left right) = 1 + size left + size right

inorder :: BST a -> [a]
inorder Empty = []
inorder (Node a left right) = inorder left ++ [a] ++ inorder right

insert :: Ord a => a -> BST a -> BST a
insert value Empty = Node value Empty Empty
insert value (Node a left right)
  | value < a = Node a (insert value left) right
  | value > a = Node a left (insert value right)
  | otherwise = Node a left right

contains :: Ord a => a -> BST a -> Bool
contains _ Empty = False
contains value (Node a left right)
  | value < a = contains value left
  | value > a = contains value right
  | otherwise = True

instance Show a => Show (BST a) where
  show Empty = ""
  show (Node a left right) = "(" ++ show left ++ show a ++ show right ++ ")"