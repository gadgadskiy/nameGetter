package file {
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class OutputFileParser extends BaseFileParser{
		private var result:String;

		public function OutputFileParser() {}

		public function startProcessing(result:String):void {
			if (!result || result == "") {
				updateStatus("Nothing to save");
				return;
			}
			this.result = result;
			var outputFile:File = new File();
			outputFile.addEventListener(Event.SELECT, selectOutputFileHandler, false, 0, true);
			outputFile.browseForSave("Please, select file");
		}

		private function selectOutputFileHandler(event:Event):void {
			var file:File = File(event.target);
			var fileStream:FileStream = new FileStream();
			try {
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeUTFBytes(result);
				updateStatus("File saved!");
			} catch (error:Error) {
				updateStatus("Error saving file");
			} finally {
				fileStream.close();
			}
		}
	}
}