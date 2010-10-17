package org.playdar.as3
{
	import org.playdar.as3.util.GUID;
	public class ResolveResponse
	{
		public var solved:Boolean = false;
		public var request_id:String = null;
		// @todo (lucas) make Vector<ResolveResult>
		public var results:Array = new Array();
		public var request:ResolveRequest;
		public function ResolveResponse(request:ResolveRequest)
		{
			this.request = request;	
			this.request_id = request.request_id;
		}
		
		public function toString():String{
			return "ResolveResponse(request="+this.request.toString()+", request_id='"+this.request_id+"', results=["+this.results.toString()+"])"
		}
	}
}