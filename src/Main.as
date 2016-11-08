package {
	import file.InputFileParser;
import file.OutputFileParser;

import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
import flash.system.System;
import flash.text.TextField;

	import graphics.GraphicUtils;

	public class Main extends Sprite {
		private var loadFileBtn:MovieClip;
		private var saveFileBtn:MovieClip;
		private var copyBtn:MovieClip;
		private var statusTextField:TextField;
		private var resultTextField:TextField;
		private var inputFileParser:InputFileParser = new InputFileParser();
		private var outputFileParser:OutputFileParser = new OutputFileParser();
		private var result:String;

		public function Main() {
			fillElements();
			addListeners();
		}

		private function fillElements():void {
			loadFileBtn = GraphicUtils.createBtn("Load file", 5, 5);
			addChild(loadFileBtn);
			saveFileBtn = GraphicUtils.createBtn("Save to file", 5, 350);
			addChild(saveFileBtn);
			copyBtn = GraphicUtils.createBtn("Copy to clipboard", 115, 350);
			addChild(copyBtn);
			statusTextField = GraphicUtils.createTextField("Please, select file for parsing", 115, 5, 200, 20, false, false, false);
			addChild(statusTextField);
			resultTextField = GraphicUtils.createTextField("", 5, 30, 490, 315, true, true, true);
			addChild(resultTextField);
		}

		private function addListeners():void {
			inputFileParser.addEventListener(Event.CHANGE, changeStatusHandler);
			outputFileParser.addEventListener(Event.CHANGE, changeStatusHandler);
			loadFileBtn.addEventListener(MouseEvent.CLICK, clickLoadFileBtnHandler);
			saveFileBtn.addEventListener(MouseEvent.CLICK, clickSaveFileBtnHandler);
			copyBtn.addEventListener(MouseEvent.CLICK, clickCopyBtnHandler);
		}

		private function clickLoadFileBtnHandler(event:Event):void {
			inputFileParser.startProcessing();
		}

		private function clickSaveFileBtnHandler(event:Event):void {
			outputFileParser.startProcessing(result);
		}

		private function clickCopyBtnHandler(event:Event):void {
			System.setClipboard(result);
		}

		private function changeStatusHandler(event:Event):void {
			statusTextField.text = event.target.status;
			result = inputFileParser.result;
			resultTextField.text = formatTextForFlash(result);
		}

		private function formatTextForFlash(text:String):String {
			while (text.indexOf("\r\n") >= 0) {
				text = text.replace("\r\n", "\n");
			}
			return text;
		}
	}
}