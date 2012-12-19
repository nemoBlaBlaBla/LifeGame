package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;

	public class Tile extends Sprite
	{
		private var _tileView:MovieClip = new DeadTile();
		private var _tileState:int = 0;
		private var _frame:Sprite = new TileFrame();

		public function Tile()
		{
			this.addChild(_tileView);
			this.addChild(_frame);
			_frame.visible = false;
			this.addEventListener(MouseEvent.CLICK, MouseClickHandler);

			this.addEventListener(MouseEvent.MOUSE_OVER, MouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, MouseOutHandler);
			// constructor code
		}

		private function MouseOverHandler(evt:MouseEvent)
		{
			_frame.visible = true;
		}
		private function MouseOutHandler(evt:MouseEvent)
		{
			_frame.visible = false;
		}
		private function MouseClickHandler(evt:MouseEvent)
		{
			ChangeState();
		}

		public function ChangeState()
		{
			if (_tileState == 0)
			{
				SetAlive();
			}
			else if (_tileState == 1)
			{
				SetDead();
			}
			RefreshGraphsics();
		}

		public function SetAlive()
		{
			_tileState = 1;
			_tileView  = new AliveTile();
			RefreshGraphsics();
		}

		public function SetDead()
		{
			_tileState = 0;
			_tileView  = new DeadTile();
			RefreshGraphsics();
		}

		private function RefreshGraphsics()
		{
			this.removeChildren();
			this.addChild(_tileView);
			this.addChild(_frame);
		}

		public function GetLifeState():int
		{
			return _tileState;
		}

	}

}