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

public class Main extends Sprite {
		private var loadFileBtn:MovieClip;
		private var saveFileBtn:MovieClip;
		private var statusText:TextField;
		private var resultText:TextField;

		public function Main() {
			fillElements();

		}

		private function fillElements():void {
			loadFileBtn = new MovieClip();
			loadFileBtn.mouseChildren = false;
			loadFileBtn.graphics.beginFill(0x3553FF);
			loadFileBtn.graphics.drawRect(0, 0, 100, 20);
			loadFileBtn.graphics.endFill();
			loadFileBtn.x = loadFileBtn.y = 5;
			loadFileBtn.addChild(createBtnLabel("Load file"));
			loadFileBtn.buttonMode = true;
			addChild(loadFileBtn);

			saveFileBtn = new MovieClip();
			saveFileBtn.mouseChildren = false;
			saveFileBtn.graphics.beginFill(0x3553FF);
			saveFileBtn.graphics.drawRect(0, 0, 100, 20);
			saveFileBtn.graphics.endFill();
			saveFileBtn.x = 5;
			saveFileBtn.y = 350;
			saveFileBtn.addChild(createBtnLabel("Save to file"));
			saveFileBtn.buttonMode = true;
			addChild(saveFileBtn);

			statusText = new TextField();
			statusText.defaultTextFormat = new TextFormat("Arial", null, 0x000000, false, false, false, null, null, TextFormatAlign.LEFT);
			statusText.x = 115;
			statusText.y = 5;
			statusText.width = 200;
			statusText.multiline = false;
			statusText.text = "Please, select file for parsing";
			statusText.selectable = false;
			addChild(statusText);

			resultText = new TextField();
			statusText.defaultTextFormat = new TextFormat("Arial", null, 0x000000, false, false, false, null, null, TextFormatAlign.LEFT);
			resultText.x = 5;
			resultText.y = 30;
			resultText.width = 490;
			resultText.height = 314;
			resultText.border = true;
			resultText.multiline = true;
			addChild(resultText);
		}

		private function createBtnLabel(label:String):TextField {
			var field:TextField = new TextField();
			field.defaultTextFormat = new TextFormat("Arial", null, 0xFFFFFF, true, false, false, null, null, TextFormatAlign.CENTER);
			field.text = label;
			return field;
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