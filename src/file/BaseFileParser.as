package file {
import flash.events.Event;
import flash.events.EventDispatcher;

public class BaseFileParser extends EventDispatcher{
	protected var _status:String;

	public function BaseFileParser() {
	}

	public function get status():String {
		return _status;
	}

	protected function updateStatus(status:String):void {
		_status = status;
		dispatchEvent(new Event(Event.CHANGE));
	}
}
}
