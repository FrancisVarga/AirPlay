package org.playdar.as3
{
	import flash.events.Event;
	public class ResolveEvent extends Event
	{
		public static const RESOLVER_ERROR:String = "resolver_error";
		public static const COMPLETE:String = "complete";
		public static const RESULTS_AVAILABLE:String = "results_available";
		
		public var data:Object = new Object();
		
		public function ResolveEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:Object=null)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}