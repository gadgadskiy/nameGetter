package dto {
	public class User {
		private var _id:int;
		private var _name:String = "";

		public function User(id:int) {
			_id = id;
		}

		public function get id():int {
			return _id;
		}

		public function set name(value:String):void {
			_name = value;
		}

		public function get data():String {
			return "@id" + _id + " (" + _name + ")";
		}
	}
}