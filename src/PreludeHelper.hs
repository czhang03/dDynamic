module PreludeHelper where

import GHC.Stack

import Control.Monad (guard)

import Data.Monoid (Any(..))
import Control.Applicative (Alternative(empty),  Applicative(..), (<$>))

import Debug.Trace (trace)

import Control.Monad.Except (throwError, MonadError)

-- todo a = trace ("optimistically assume " ++ show a) $ pure a
logg a = trace ("-- " ++ show a) $ pure a
-- logg a = pure a
--did the haskell upgrade break trace?


-- from: https://github.com/BU-CS320/Summer-2019/blob/master/assignments/HW4/src/HelpShow.hs
parenthesize :: Integer -- ^ the precedence level of outer expression
              -> Integer -- ^ the precedence level of the current expression
              -> String -- ^ string representation current expression
              -> String -- ^ the properly (not necessarily fully) parenthesized current expression
parenthesize outerLevel curLevel showExp 
  | outerLevel < curLevel = "(" ++ showExp ++ ")"
  | otherwise             =        showExp


-- guardThrow :: HasCallStack => MonadError e m => Bool -> e -> m a -> m a
-- guardThrow True s ma = ma
-- guardThrow False s ma = throwError $ s  -- ++ "\n" ++ prettyCallStack callStack


-- TODO why is this not in the stdlib, also needs some string output?
justM :: Alternative f => Maybe a -> f a
justM (Just a) = pure a
justM _ = empty


errIo :: HasCallStack => String -> IO a
errIo s = 
  throwError $ userError $ "\n" ++ s ++ "\n" ++ prettyCallStack callStack
-- TODO got to be something better then this?
