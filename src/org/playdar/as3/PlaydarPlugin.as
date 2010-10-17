package org.playdar.as3
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	

	[Event(name="complete", type="org.playdar.as3.ResolveEvent")]
	[Event(name="error", type="org.playdar.as3.ResolveEvent")]
	public class PlaydarPlugin extends EventDispatcher
	{
				
		public function PlaydarPlugin()
		{
			
		}
		
		public function resolve(request:ResolveRequest):void{
			throw new Error("Resolve not implemented.");
		}
		
		public function jsonDecode(str:String):Object{
			return JSON.decode(str, false);
		}
		
		public function getUrl(url:String, resolveRequest:ResolveRequest, onSuccess:Function, onError:Function=null):void{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function(event:Event):void {
				var loader:URLLoader = URLLoader(event.target);
				onSuccess(loader.data, resolveRequest);
			});
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(event:IOErrorEvent):void{
				if(onError != null){
					onError(event, resolveRequest);
				}
			});
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(event:SecurityErrorEvent):void{
				if(onError != null){
					onError(event, resolveRequest);
				}
			});
			//loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			//loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			
			
			var request:URLRequest = new URLRequest(url);
			try {
				loader.load(request);
			} catch (error:Error) {
				if(onError != null){
					onError(error, resolveRequest);
				}
			}
		}
	}
}