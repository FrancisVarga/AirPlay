package org.playdar.as3
{
	import org.playdar.as3.util.GUID;
	import mx.utils.StringUtil;
	
	public class ResolveResult
	{
		public var request_id:String = null;
		public var album:String = null;
		public var track:String = null;
		public var artist:String = null;
		public var duration:Number = 0;
		public var url:String = null;
		public var source:String = null;
		public var score:Number = 1;
		public var result_id:String = null;
		
		public function ResolveResult(obj:Object){
			for(var prop:String in obj){
				this[prop] = obj[prop];
			}
			this.result_id = GUID.create();
		}
		
		public function get streamUrl():String{
			return StringUtil.substitute('/stream/{0}.mp3', this.result_id);
		}
		
		
		
		public function toString():String{
			return "ResolveResult(artist='"+this.artist+"', track='"+this.track+"', url='"+this.url+"')"
		}
	}
}