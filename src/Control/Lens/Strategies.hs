-----------------------------------------------------------------------------
-- |
-- Module      :  Control.Lens.Strategies
-- Copyright   :  (C) 2012 Edward Kmett
-- License     :  BSD-style (see the file LICENSE)
-- Maintainer  :  Edward Kmett <ekmett@gmail.com>
-- Stability   :  provisional
-- Portability :  portable
--
-- A 'Lens' or 'Traversal' can be used to take the role of 'Traversable' in
-- @Control.Parallel.Strategies@, enabling those combinators to work with
-- monomorphic containers.
----------------------------------------------------------------------------
module Control.Lens.Strategies
  ( evalTraversal
  , parTraversal
  ) where

import Control.Lens
import Control.Parallel.Strategies

-- | Evaluate the targets of a 'Lens' or 'Traversal' into a data structure
-- according to the given strategy.
--
-- > evalTraversable = evalTraversal traverse
--
-- > evalTraversal = id
--
-- > evalTraversal :: Simple Lens a b -> Strategy b -> Strategy a
-- > evalTraversal :: Simple Traversal a b -> Strategy b -> Strategy a
evalTraversal :: SimpleLensLike Eval a b -> Strategy b -> Strategy a
evalTraversal l = l

-- | Evaluate the targets of a 'Lens' or 'Traversal' according into a
-- data structure according to a given 'Strategy' in parallel.
--
-- > parTraversable = parTraversal traverse
--
-- > parTraversal l s = l (rparWith s)
--
-- > parTraversal :: Simple Lens a b -> Strategy b -> Strategy a
-- > parTraversal :: Simple Traversal a b -> Strategy b -> Strategy a
parTraversal :: SimpleLensLike Eval a b -> Strategy b -> Strategy a
parTraversal l s = l (rparWith s)