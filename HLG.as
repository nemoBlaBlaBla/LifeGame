package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;


	public class HLG extends MovieClip
	{

		private var _TU:TileUniverse = new TileUniverse(79,58);

		private var _myTextFormat:TextFormat = new TextFormat("Segoe UI Light",16,0xFFFFFF);

		private var _footerTextFormat:TextFormat = new TextFormat("Segoe UI Light",10,0xFFFFFF);
		private var _footerTextField: TextField = new TextField();

		public function HLG()
		{
			StartButton1.addEventListener(MouseEvent.CLICK, Start);
			StopButton1.addEventListener(MouseEvent.CLICK, Stop);
			StepButton1.addEventListener(MouseEvent.CLICK, Step);
			DefaultButton1.addEventListener(MouseEvent.CLICK, Default);
			ActionLabel.setStyle("textFormat", _myTextFormat);
			var bfil:BlurFilter = new BlurFilter(1.1,1.1,3);
			var gfil:GlowFilter = new GlowFilter(0xFFFFFF,1,7,7,2,3);
			var filterArray:Array = [bfil,gfil];
			ActionLabel.filters = filterArray;
			_footerTextField.text = ("Developed by Eugene Tkachenko. My email: nemo91@bigmir.net");
			_footerTextField.width = 450;
			try
			{
				_footerTextField.x = 0;
				_footerTextField.y = 465;
				_footerTextField.setTextFormat(_footerTextFormat);
				addChild(_footerTextField);
			}
			catch (e:Error)
			{
				trace(e.errorID);
				trace(e.name);
				trace(e.message);
			}
			_TU.scaleX = 0.25;
			_TU.scaleY = 0.25;
			trace("hello");
			addChild(_TU);
			// constructor code
		}

		private function Start(evt:MouseEvent)
		{
			trace("Start");
			_TU.StartLife();
			ActionLabel.text = "Running";
		}

		private function Stop(evt:MouseEvent)
		{
			trace("Stop");
			_TU.StopLife();
			ActionLabel.text = "Stopped";
		}

		private function Step(evt:MouseEvent)
		{
			trace("Step");
			_TU.StepLife();
		}

		private function Default(evt:MouseEvent)
		{
			trace("Default");
			_TU.ClearLife();
		}
	}

}