package file {
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class VkPageLoader extends URLLoader {
		private var _id:int;

		public function VkPageLoader(id:int) {
			_id = id;
			super();
		}

		public function loadUrl():void {
			super.load(new URLRequest("https://vk.com/id" + _id));
		}

		public function get id():int {
			return _id;
		}
	}
}