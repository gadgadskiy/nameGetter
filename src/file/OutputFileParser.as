package file {
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class OutputFileParser extends BaseFileParser{
		private var outputFile:File;
		private var result:String;

		public function OutputFileParser() {}

		public function startProcessing(result:String):void {
			if (!result || result == "") {
				updateStatus("Nothing to save!");
				return;
			}
			this.result = result;
			outputFile = new File();
			outputFile.addEventListener(Event.SELECT, selectOutputFileHandler, false, 0, true);
			outputFile.browseForSave("Please, select file");
		}

		private function selectOutputFileHandler(event:Event):void {
			var file:File = File(event.target);
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(result);
			updateStatus("File saved!");
			fileStream.close();
		}
	}
}