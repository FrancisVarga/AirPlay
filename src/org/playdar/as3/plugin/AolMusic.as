package org.playdar.as3.plugin
{
	import Mustache;
	import mx.utils.StringUtil;
	
	import org.osmf.audio.SoundLoader;
	import org.playdar.as3.IPlaydarPlugin;
	import org.playdar.as3.PlaydarPlugin;
	import org.playdar.as3.ResolveEvent;
	import org.playdar.as3.ResolveRequest;
	import org.playdar.as3.ResolveResult;

	public class AolMusic extends PlaydarPlugin implements IPlaydarPlugin
	{
		public static var name:String = "AOL Music Resolver";
		public static var id:String = "AolMusicResolver";
		private var onComplete:Function;
		
		public function AolMusic(){}
		
		/**
		 * @todo (lucas) Add bootstrapped to IPlaydarPlugin for first run (ie download an entire index)
		 * @todo (lucas) Support scoring?
		 * @todo (lucas) Support giving up on external requests that take too long.
		 */
		
		override public function resolve(request:ResolveRequest):void{
			var url:String = StringUtil.substitute(
				'http://music.aol.com/api/audio/search?start=0&count=20&artistName={{0}}&songTitle={{1}}', 
				request.artist_name, request.track_title
			);
			this.getUrl(url, request, onSuccess, onError);
			
		}
		
		private function onSuccess(json_data:String, request:ResolveRequest):void{
			var data:Object = this.jsonDecode(json_data);
			var raw_results:Array = data['response']['data']['assets'];
			
			var results:Array = new Array();
			raw_results.forEach(function(raw_result){
				results.push(new ResolveResult({
					request_id: request.request_id, 
					artist: raw_result['artistname'],
					album: raw_result['albumname'],
					track: raw_result['songtitle'],
					duration: raw_result['duration'],
					url: raw_result['enclosure'],
					source: id
				}));
			});
			this.dispatchEvent(new ResolveEvent(ResolveEvent.COMPLETE, false, false, results));
		}
		private function onError(error:Object, request:ResolveRequest):void{
			this.dispatchEvent(new ResolveEvent(ResolveEvent.RESOLVER_ERROR, false, false, error));
		}
	}
}