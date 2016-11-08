package file {
import dto.User;

import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;

	public class InputFileParser extends EventDispatcher {
		private static const DELIMITER_INPUT = "\r\n";
		private static const DELIMITER_OUTPUT = "\n";
		private var inputFile:File;
		private var _status:String;
		private var _result:String;
		private var users:Vector.<User> = new Vector.<User>();
		private var totalCount:uint;
		private var currentCount:uint;

		public function InputFileParser() {}

		public function startProcessing():void {
			inputFile = new File();
			inputFile.addEventListener(Event.SELECT, selectInputFileHandler, false, 0, true);
			inputFile.browseForOpen("Please, select file with ids", [new FileFilter("Documents", "*.txt")]);
		}

		public function get status():String {
			return _status;
		}

		public function get result():String {
			return _result;
		}

		private function updateStatus(status:String):void {
			this._status = status;
			dispatchEvent(new Event(Event.CHANGE));
		}

		private function selectInputFileHandler(event:Event):void {
			updateStatus("Processing...");
			inputFile.addEventListener(Event.COMPLETE, loadInputFileHandler, false, 0, true);
			inputFile.load();
		}

		private function loadInputFileHandler(event:Event):void {
			var resultText:String = event.currentTarget.data;
			var ids:Array = resultText.split(DELIMITER_INPUT);
			if (validateInputData(ids)) {
				parseData(ids);
			}
		}

		private function validateInputData(ids:Array):Boolean {
			var length:uint = ids.length;
			var isCorrectData:Boolean = true;
			for (var i:int = 0; i < length; i++) {
				if (ids[i] == "") {
					ids.splice(i, 1);
					i--;
					length--;
				} else if (isNaN(ids[i])) {
					isCorrectData = false;
					break;
				}
			}
			if (!isCorrectData) {
				updateStatus("File has incorrect data");
			}
			return isCorrectData;
		}

		private function parseData(ids:Array):void {
			totalCount = ids.length;
			currentCount = 0;
			for each (var id:int in ids) {
				users.push(new User(id));
				loadPage(id);
			}
		}

		private function loadPage(id:int):void {
			var loader:VkPageLoader = new VkPageLoader(id);
			loader.addEventListener(Event.COMPLETE, urlLoadCompleteHandler);
			loader.loadUrl();
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
			updateUser(event.currentTarget.id, name);
		}

		private function updateUser(id:int, name:String):void {
			for each (var user:User in users) {
				if (user.id == id) {
					user.name = name;
					break;
				}
			}
			currentCount++;
			if (currentCount >= totalCount) {
				createResultString();
				_status = "Complete!";
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		private function createResultString():void {
			_result = "";
			for each (var user:User in users) {
				_result += user.data + DELIMITER_OUTPUT;
			}
		}
	}
}