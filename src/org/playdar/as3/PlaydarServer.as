package org.playdar.as3
{
	import breezy.Application;
	import breezy.HttpServer;
	import breezy.Route;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	import org.playdar.as3.IPlaydarPlugin;
	import org.playdar.as3.ResolveEvent;
	
	public class PlaydarServer extends EventDispatcher{
		private var plugins:Array = new Array();
		public var port:Number = 60214;
		private var logHandlers:Array = new Array(trace);
		private var results:Object = {};
		private var http_server:HttpServer;
		
		public static var instance:PlaydarServer;
		
		public function PlaydarServer(plugins:Array=null){
			PlaydarServer.instance = this;
		}
		
		public function addPlugin(plugin:Object):void{
			this.plugins.push(plugin);
		}
		
		public function addPlugins(plugins:Array):void{
			plugins.forEach(addPlugin, this);
		}
		
		public function addLogHandler(handler:Object):void{
			this.logHandlers.push(handler);
		}
		
		/**
		 * @todo (lucas) Support levels?  Maybe not.  Everybody usually only uses info for everything.
		 */
		private function log(what:Object):void{
			logHandlers.forEach(function(h){
				h.apply(this, [what]);
			});
		}
		
		public function resolve(request:ResolveRequest, onResults:Function):void{
			var server:PlaydarServer = this;
			this.results[request.request_id] = new ResolveResponse(request);
			
			
			this.plugins.forEach(function(plugin){
				var p:PlaydarPlugin = new plugin();
				p.resolve(request);
				var result:ResolveResponse = results[request.request_id];
				
				p.addEventListener(ResolveEvent.COMPLETE, function(event:ResolveEvent):void{
					server.addResults(event.data as Array, request.request_id);
					onResults(result);
				});
				p.addEventListener(ResolveEvent.RESOLVER_ERROR, function(event:ResolveEvent):void{
					trace('Resolver error: '+event);
				});
			});
			
		}
		
		/**
		 * @todo (lucas) rename.  This is unclear.
		 */
		public function getResults(request_id:String):Object{
			return this.results[request_id].results;
		}
		
		/**
		 * @todo (lucas) Probably way better if this is accomplished by listening for events on 
		 * ResolveRequests (see timeout long requests).
		 */
		public function addResults(results:Array, request_id:String):void{
			var server:PlaydarServer = this;
			results.forEach(function(result){
				server.results[result.request_id].results.push(result);
			});
			this.dispatchEvent(new ResolveEvent(ResolveEvent.RESULTS_AVAILABLE, false, false, this.results[request_id]));
		}
		
		/**
		 * Starts a socket server to listen for incoming requests.
		 * @note (lucas) Still pretty happy with this.
		 */
		public function start():void{
			var handlers:Array = [
				new Route(/\/api\/resolve\/(\w+)\/(\w+)\/?/, PlaydarWebServer, 'resolve'),
				new Route(/\/api\/get_results\/(\[^\/]+)\/?/, PlaydarWebServer, 'get_results'),
				new Route(/\/api\/stream\/(\[^\/]+)\/?/, PlaydarWebServer, 'stream'),
			];
			var app:Application = new Application(handlers);
			this.http_server = new HttpServer(app);
			this.http_server.listen(this.port);
		}
		
		public function stop():void{
			this.http_server.stop();
		}
		
		
		public function restart():void{
			this.stop();
			this.start();
		}
		
		public function stream(result_id:String):void{
			// @todo (lucas) Need to add/clean up map result_id -> results.
		}
	}
}