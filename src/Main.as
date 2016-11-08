package {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.utils.ByteArray;

import graphics.GraphicUtils;

public class Main extends Sprite {
		private var loadFileBtn:MovieClip;
		private var saveFileBtn:MovieClip;
		private var statusText:TextField;
		private var resultText:TextField;

		public function Main() {
			fillElements();

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

		private function loadPage():void {
			var url:String = "https://vk.com/id6949616";
			var req:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, urlLoadCompleteHandler);
			loader.load(req);
		}

		private function urlLoadCompleteHandler(event:Event):void {
			var pageContent:String = event.currentTarget.data;
			var data:Array = pageContent.split("<title>");
			var name:String = data[data.length - 1];
			name = name.split(" |")[0];
			var ba:ByteArray = new ByteArray();
			ba.writeMultiByte(name, "windows-1252");
			ba.position = 0;
			name = ba.readMultiByte(ba.length, "windows-1251");
			trace(name);
		}
	}
}