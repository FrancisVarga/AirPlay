package org.playdar.as3.straus
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;

	public class Server
	{
		private var sock:Socket;
		
		public function Server(host:String, port:Number){
			this.sock = new Socket();
			this.sock.addEventListener(Event.CLOSE, closeHandler);
			addEventListener(Event.CONNECT, connectHandler);
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			this.sock.connect(host, port);
		}
		
		public function login(username:String, password:String):void{
			
		}
		
		public function addToken(token:String):void{
			
		}
				
		private function sendMessage(str:String):void {
			str += "\n";
			try {
				this.sock.writeUTFBytes(str);
			}
			catch(e:IOError) {
				trace(e);
			}
		}
		

		private function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
		}
		
		private function connectHandler(event:Event):void {
			trace("connectHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function socketDataHandler(event:ProgressEvent):void {
			trace("socketDataHandler: " + event);
			
			onData(this.sock.readUTFBytes(this.sock.bytesAvailable)));
		}
	}
}