package {
	import file.InputFileParser;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import graphics.GraphicUtils;

	public class Main extends Sprite {
		private var loadFileBtn:MovieClip;
		private var saveFileBtn:MovieClip;
		private var statusText:TextField;
		private var resultText:TextField;
		private var inputFileParser:InputFileParser = new InputFileParser();

		public function Main() {
			fillElements();
			addListeners();
		}

		private function fillElements():void {
			loadFileBtn = GraphicUtils.createBtn("Load file", 5, 5);
			addChild(loadFileBtn);
			saveFileBtn = GraphicUtils.createBtn("Save to file", 5, 350);
			addChild(saveFileBtn);
			statusText = GraphicUtils.createTextField("Please, select file for parsing", 115, 5, 200, 20, false, false, false);
			addChild(statusText);
			resultText = GraphicUtils.createTextField("", 5, 30, 490, 315, true, true, true);
			addChild(resultText);
		}

		private function addListeners():void {
			inputFileParser.addEventListener(Event.CHANGE, changeStatusHandler);
			inputFileParser.addEventListener(Event.COMPLETE, completeParsingHandler);
			loadFileBtn.addEventListener(MouseEvent.CLICK, clickLoadFileBtnHandler);
		}

		private function clickLoadFileBtnHandler(event:Event):void {
			inputFileParser.startProcessing();
		}

		private function changeStatusHandler(event:Event):void {
			statusText.text = inputFileParser.status;
		}

		private function completeParsingHandler(event:Event):void {
			resultText.text = inputFileParser.result;
			statusText.text = inputFileParser.status;
		}
	}
}