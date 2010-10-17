package org.playdar.as3
{
	import breezy.BaseHandler;
	import flash.net.Socket;

	public class PlaydarWebServer extends BaseHandler
	{
		public function PlaydarWebServer(request:Object, socket:Socket)
		{
			super(request, socket);	
		}
		
		[Route(spec="/\api\/resolve\/?/")]
		public function resolve(artist:String, track:String):void{
			PlaydarServer.instance.resolve(new ResolveRequest(artist, track), _on_resolve);
		}
		
		private function _on_resolve(results:ResolveResponse):void{
			trace('Got some results');
			trace(results);
			this.render("", results);
		}
		
		public function get_results(request_id:String):void{
			
		}
		
		public function stream(result_id:String):void{
			
		}
	}
}