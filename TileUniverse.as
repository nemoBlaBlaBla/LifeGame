package 
{

	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.events.Event;

	public class TileUniverse extends Sprite
	{

		private var _universeWidth:int;
		private var _universeHeight:int;

		private var _currentStateArray:Array;// = new Array(100);

		private var _nextStateArray:Array;// = new Array(_currentStateArray.length);

		private var _isStarted:Boolean = false;

		public function TileUniverse(universeW:int = 50, universeH:int = 50)
		{
			_universeWidth = universeW;
			_universeHeight = universeH;
			InitUniverse();
			SetDefaultTiles();
			DrawTiles();
			this.addEventListener(Event.ENTER_FRAME, EnterFrameHandler);
			// constructor code
		}

		private function InitUniverse()
		{
			_currentStateArray = new Array(_universeWidth);
			_nextStateArray = new Array(_universeWidth);
			for (var i:int = 0; i < _currentStateArray.length; i++)
			{
				_currentStateArray[i] = new Array(_universeHeight);
				_nextStateArray[i] = new Array(_universeHeight);
			}
		}

		private function DrawTiles()
		{
			for (var i:int = 0; i < _currentStateArray.length; i++)
			{
				for (var j:int = 0; j < _currentStateArray[i].length; j++)
				{
					_currentStateArray[i][j].x = i * 32;
					_currentStateArray[i][j].y = j * 32;
					addChild(_currentStateArray[i][j]);
				}
			}
		}

		public function SetDefaultTiles()
		{
			for (var i:int = 0; i < _currentStateArray.length; i++)
			{
				_currentStateArray[i] = new Array(_universeHeight);
				_nextStateArray[i] = new Array(_currentStateArray[i].length);
				for (var j:int = 0; j < _currentStateArray[i].length; j++)
				{
					_currentStateArray[i][j] = new Tile();
					_nextStateArray[i][j] = 0;
				}
			}
		}

		private function CalculateNextStateArray()
		{
			for (var i:int = 0; i < _nextStateArray.length; i++)
			{
				for (var j:int = 0; j < _nextStateArray[i].length; j++)
				{
					var neighBourCounter:int = 0;

					if (i == 0 && j == 0)
					{
						neighBourCounter = 
						_currentStateArray[_universeWidth - 1][j].GetLifeState() 
						+ _currentStateArray[i + 1][j].GetLifeState() 
						+ _currentStateArray[_universeWidth - 1][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[i + 1][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[_universeWidth - 1][j + 1].GetLifeState() 
						+ _currentStateArray[i + 1][j + 1].GetLifeState() 
						+ _currentStateArray[i][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[i][j + 1].GetLifeState();
					}
					else if (i == 0 && j == _universeHeight - 1)
					{
						neighBourCounter = 
						_currentStateArray[_universeWidth - 1][j].GetLifeState() 
						+ _currentStateArray[i + 1][j].GetLifeState() 
						+ _currentStateArray[_universeWidth - 1][j - 1].GetLifeState() 
						+ _currentStateArray[i + 1][j - 1].GetLifeState() 
						+ _currentStateArray[_universeWidth - 1][0].GetLifeState() 
						+ _currentStateArray[i + 1][0].GetLifeState() 
						+ _currentStateArray[i][j - 1].GetLifeState() 
						+ _currentStateArray[i][0].GetLifeState();
					}
					else if (i == _universeWidth - 1 && j == _universeHeight - 1)
					{
						neighBourCounter = 
						_currentStateArray[i - 1][j].GetLifeState() 
						+ _currentStateArray[0][j].GetLifeState() 
						+ _currentStateArray[i - 1][j - 1].GetLifeState() 
						+ _currentStateArray[0][j - 1].GetLifeState() 
						+ _currentStateArray[i - 1][0].GetLifeState() 
						+ _currentStateArray[0][0].GetLifeState() 
						+ _currentStateArray[i][j - 1].GetLifeState() 
						+ _currentStateArray[i][0].GetLifeState();
					}
					else if (i == _universeWidth - 1 && j == 0)
					{
						neighBourCounter = 
						_currentStateArray[i - 1][j].GetLifeState() 
						+ _currentStateArray[0][j].GetLifeState() 
						+ _currentStateArray[i - 1][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[0][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[i - 1][j + 1].GetLifeState() 
						+ _currentStateArray[0][j + 1].GetLifeState() 
						+ _currentStateArray[i][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[i][j + 1].GetLifeState();
					}

					else if ((i == 0)  && ((j != 0)&&(j != _universeHeight - 1)))
					{
						neighBourCounter = 
						_currentStateArray[_universeWidth - 1][j].GetLifeState() 
						+ _currentStateArray[i + 1][j].GetLifeState() 
						+ _currentStateArray[_universeWidth - 1][j - 1].GetLifeState() 
						+ _currentStateArray[i + 1][j - 1].GetLifeState() 
						+ _currentStateArray[_universeWidth - 1][j + 1].GetLifeState() 
						+ _currentStateArray[i + 1][j + 1].GetLifeState() 
						+ _currentStateArray[i][j - 1].GetLifeState() 
						+ _currentStateArray[i][j + 1].GetLifeState();
					}
					else if ((j == 0)  && ((i != 0)&&(i != _universeWidth - 1)))
					{
						neighBourCounter = 
						_currentStateArray[i - 1][j].GetLifeState() 
						+ _currentStateArray[i + 1][j].GetLifeState() 
						+ _currentStateArray[i - 1][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[i + 1][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[i - 1][j + 1].GetLifeState() 
						+ _currentStateArray[i + 1][j + 1].GetLifeState() 
						+ _currentStateArray[i][_universeHeight - 1].GetLifeState() 
						+ _currentStateArray[i][j + 1].GetLifeState();
					}
					else if ((i == _universeWidth - 1)  && ((j != 0)&&(j != _universeHeight - 1)))
					{
						neighBourCounter = 
						_currentStateArray[i - 1][j].GetLifeState() 
						+ _currentStateArray[0][j].GetLifeState() 
						+ _currentStateArray[i - 1][j - 1].GetLifeState() 
						+ _currentStateArray[0][j - 1].GetLifeState() 
						+ _currentStateArray[i - 1][j + 1].GetLifeState() 
						+ _currentStateArray[0][j + 1].GetLifeState() 
						+ _currentStateArray[i][j - 1].GetLifeState() 
						+ _currentStateArray[i][j + 1].GetLifeState();
					}
					else if ((j == _universeHeight - 1)  && ((i != 0)&&(i != _universeWidth - 1)))
					{
						neighBourCounter = 
						_currentStateArray[i - 1][j].GetLifeState() 
						+ _currentStateArray[i + 1][j].GetLifeState() 
						+ _currentStateArray[i - 1][j - 1].GetLifeState() 
						+ _currentStateArray[i + 1][j - 1].GetLifeState() 
						+ _currentStateArray[i - 1][0].GetLifeState() 
						+ _currentStateArray[i + 1][0].GetLifeState() 
						+ _currentStateArray[i][j - 1].GetLifeState() 
						+ _currentStateArray[i][0].GetLifeState();
					}
					else
					{
						neighBourCounter = 
						_currentStateArray[i - 1][j].GetLifeState() 
						+ _currentStateArray[i + 1][j].GetLifeState() 
						+ _currentStateArray[i - 1][j - 1].GetLifeState() 
						+ _currentStateArray[i + 1][j - 1].GetLifeState() 
						+ _currentStateArray[i - 1][j + 1].GetLifeState() 
						+ _currentStateArray[i + 1][j + 1].GetLifeState() 
						+ _currentStateArray[i][j - 1].GetLifeState() 
						+ _currentStateArray[i][j + 1].GetLifeState();
					}

					if (neighBourCounter == 3)
					{
						_nextStateArray[i][j] = new int(1);
					}
					if (neighBourCounter == 2)
					{
						if (_currentStateArray[i][j].GetLifeState() == 1)
						{
							_nextStateArray[i][j] = new int(1);
						}
					}
					if (neighBourCounter > 3)
					{
						_nextStateArray[i][j] = new int(0);
					}
					if (neighBourCounter < 2)
					{
						_nextStateArray[i][j] = new int(0);
					}
				}
			}
		}

		private function RefreshCurrentStateArray()
		{
			for (var i:int = 0; i < _currentStateArray.length; i++)
			{
				for (var j:int = 0; j < _currentStateArray[i].length; j++)
				{
					if (_currentStateArray[i][j].GetLifeState() != _nextStateArray[i][j])
					{
						_currentStateArray[i][j].ChangeState();
					}
				}
			}
		}

		private function EnterFrameHandler(evt:Event)
		{
			if (_isStarted == true)
			{
				CalculateNextStateArray();
				RefreshCurrentStateArray();
			}
		}

		public function StartLife()
		{
			_isStarted = true;
		}

		public function StopLife()
		{
			_isStarted = false;
		}

		public function StepLife()
		{
			CalculateNextStateArray();
			RefreshCurrentStateArray();
		}

		public function ClearLife()
		{
			for (var i:int = 0; i < _currentStateArray.length; i++)
			{
				for (var j:int = 0; j < _currentStateArray[i].length; j++)
				{
					_currentStateArray[i][j].SetDead();
				}
			}
		}
	}
}