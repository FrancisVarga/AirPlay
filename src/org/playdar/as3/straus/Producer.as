package org.playdar.as3.straus
{
	import flash.net.NetConnection;
	
	/**
	 * The producer takes a netstream and send commands over it to a peer (the Consumer).
	 */
	public class Producer
	{
		private var sendStream:NetConnection;
		private var actor:Object;
		public function Producer(sendStream:NetConnection, actor:Object)
		{
			this.sendStream = sendStream;
			this.actor = actor;
		}
		
		/**
		 * Request that a peer establish a two way connection.
		 */
		public function requestPeerConnection():void{
			this.sendStream.send("onRequestPeerConnection", actor);
		}
		
		/**
		 * Request a list of permissions from the peer this actor has,
		 * ie, canStream, canViewLibrary, canViewPlaylists, etc
		 * 
		 * @future
		 */
		public function requestPermissionsList():void{
			this.sendStream.send("onRequestPermissionsList", actor);
		}
		
		/**
		 * Request a file's byte array from a peer.
		 */
		public function sendFileRequest(fileName:String):void{
			this.sendStream.send("onFileRequest", fileName);
		}
		
		/**
		 * Send the actual file data to a peer.
		 */
		public function sendFile(fileData:Object):void{
			this.sendStream.send("onFile", fileData);
		}
		
		/**
		 * Query a peer to see if they have a track.
		 * The peers Producer responds by sending an `onResolveResult` message 
		 * with a result object.  The result object may or may not contain results.
		 */
		public function sendResolveRequest(request:Object):void{
			this.sendStream.send("onResolveRequest", request);
		}
		
		/**
		 * Send the results of a resolve request back to a peer.
		 */
		public function sendResolveResult(result:Object):void{
			this.sendStream.send("onResolveResult", result);
		}
		
		/**
		 * Mainly for debugging to test if messages are going through.
		 */
		public function sendChat(username:String, message:String):void{
			this.sendStream.send();
		}
		
		/**
		 * Request playlists from the peer.
		 */
		public function sendRequestListPlaylists():void{
			this.sendStream.send("onRequestListPlaylists", this.actor);
		}
		
		/**
		 * Send our playlists to the peer.
		 */
		public function sendListPlaylists(playlists:Array):void{
			this.sendStream.send("onListPlaylists", {actor: this.actor, playlists: playlists});
		}
		
		/**
		 * Request the peer's library.
		 */
		public function sendRequestListLibrary():void{
			this.sendStream.send("onRequestListLibrary", this.actor);
		}
		
		/**
		 * Send our library to the peer.
		 */
		public function sendListLibraryRequest(tracks:Array):void{
			this.sendStream.send("onListLibrary", {actor: this.actor, tracks: tracks});
		}
	}
}