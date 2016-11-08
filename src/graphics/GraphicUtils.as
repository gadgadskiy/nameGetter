package graphics {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class GraphicUtils {
		public function GraphicUtils() {
			throw new Error("static class");
		}

		public static function createBtn(label:String, x:int, y:int):MovieClip {
			var btn:MovieClip = new MovieClip();
			btn.mouseChildren = false;
			btn.graphics.beginFill(0x3553FF);
			btn.graphics.drawRect(0, 0, 105, 20);
			btn.graphics.endFill();
			btn.x = x;
			btn.y = y;
			btn.addChild(createBtnLabel(label));
			btn.buttonMode = true;
			return btn;
		}

		private static function createBtnLabel(label:String):TextField {
			var field:TextField = new TextField();
			field.defaultTextFormat = new TextFormat("Arial", null, 0xFFFFFF, true, false, false, null, null, TextFormatAlign.CENTER);
			field.width = 105;
			field.text = label;
			return field;
		}

		public static function createTextField(text:String, x:int, y:int, width:int, height:int, multiline:Boolean, border:Boolean, selectable:Boolean):TextField {
			var field:TextField = new TextField();
			field.defaultTextFormat = new TextFormat("Arial", null, 0x000000, false, false, false, null, null, TextFormatAlign.LEFT);
			field.x = x;
			field.y = y;
			field.width = width;
			field.height = height;
			field.multiline = multiline;
			field.border = border;
			field.text = text;
			field.selectable = selectable;
			return field;
		}
	}
}