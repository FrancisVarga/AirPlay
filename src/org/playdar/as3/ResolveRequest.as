package org.playdar.as3
{
	public class ResolveRequest
	{
		import org.playdar.as3.util.GUID;
		
		public var artist_name:String;
		public var track_title:String;
		
		public var request_id:String;
		
		public function ResolveRequest(artist_name:String, track_title:String)
		{
			this.artist_name = artist_name;
			this.track_title = track_title;
			this.request_id = GUID.create(); // Each resolve request gets a guid
		}
		
		public function toString():String{
			return "ResolveRequest(artist_name='"+this.artist_name+"', track_title='"+this.track_title+"', request_id='"+this.request_id+"')";
		}
	}
}