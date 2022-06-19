import Control.Lens
import Control.Lens.List
import Control.Lens.Record
import Control.Lens.Tuple
import Data.List

-- The example use case of lenses shown in the introduction of the paper.
player :: Lens Game Player
player = Lens _player (\ o f -> o { _player = (f (_player o)) })

status :: Lens Player Status
status = Lens _status (\ o f -> o { _status = (f (_status o)) })

health :: Lens Status Int
health = Lens _health (\ o f -> o { _health = (f (_health o)) })

data Status = Status { _health :: Int, _level :: Int } deriving Show
data Player = Player { _name :: String, _status :: Status } deriving Show
data Game = Game { _player :: Player, _isStarted :: Bool } deriving Show

healPlayer :: Int -> Game -> Game
healPlayer points game = game { _player =
    (_player game) { _status =
        (_status (_player game)) { _health =
            _health (_status (_player game)) + points }}}

healPlayer' :: Int -> Game -> Game
healPlayer' points game = over (player ⊙ status ⊙ health) game (+ points)

-- An example usage of our agda2hs lenses in Haskell.
myFoo :: Foo
myFoo = Foo "hello" ('x', 5)

main :: IO ()
main = print $ get bar $ put (bar ⊙ two) myFoo 100
-- prints "(4, 100)"
