package org.playdar.as3
{
	import org.playdar.as3.ResolveRequest;
	
	public interface IPlaydarPlugin
	{
		function resolve(request:ResolveRequest):void;
	}
}