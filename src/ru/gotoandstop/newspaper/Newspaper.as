package ru.gotoandstop.newspaper{
	import __AS3__.vec.Vector;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import ru.gotoandstop.newspaper.types.AlignType;
	
	/**
	 *
	 * Developed since 2008
	 * @version: 2.0
	 * @author Roman Timashev (roman@tmshv.ru)
	 */
	public class Newspaper{
		public static const VERSION:String = '2.0';
		
		public static var stage:Stage;
		public static var nativeStageWidth:uint;
		public static var nativeStageHeight:uint;
		
		private static var __conllection:Vector.<Block>;
		private static var __initialized:Boolean;
		
		public function Newspaper(){
			throw new Error('You cannot create instance of Newspaper.');
		}
		
		public static function init(stage:Stage, nativeStageWidth:uint, nativeStageHeight:uint):void{
			if(Newspaper.__initialized) return;
			
			Newspaper.__initialized = true;
			Newspaper.__conllection = new Vector.<Block>();
			Newspaper.stage = stage;
			Newspaper.nativeStageWidth = nativeStageWidth;
			Newspaper.nativeStageHeight = nativeStageHeight;
			
			Newspaper.stage.addEventListener(Event.RESIZE, handlerResize);
		}

		/**
		 * 
		 * @param object
		 * @param target
		 * @param callback
		 * @param offsetX
		 * @param offsetY
		 * @param alignX
		 * @param alignY
		 * 
		 */
		public static function add(object:DisplayObject,
										relativeTarget:DisplayObject,
										callback:Function=null,
										offsetX:uint=0,
										offsetY:uint=0,
										alignX:String='left',
										alignY:String='top'):void{
			
			var e:Editor = new Editor();
			e.offsetX = offsetX;
			e.offsetY = offsetY;
			e.objectAlignX = alignX;
			e.objectAlignY = alignY;
			e.screenAlignX = alignX;
			e.screenAlignY = alignY;
			
			var b:Block = new Block(object, relativeTarget, e, callback);
			Newspaper.__conllection.push(b);
			Newspaper.position(object, relativeTarget, e);
		}
		
		public static function addEditor(object:DisplayObject, target:DisplayObject, editor:Editor, callback:Function=null):void{
			var b:Block = new Block(object, target, editor, callback);
			Newspaper.__conllection.push(b);
			Newspaper.position(object, target, editor);
		}
		
		private static function handlerResize(event:Event):void{
			var length:uint = Newspaper.__conllection.length;
			for(var i:uint; i < length; i++){
				var block:Block = Newspaper.__conllection[i] as Block;
				if(block.callback != null){
					block.callback(block.object, block.target, block.editor);
					continue;
				}else{
					Newspaper.position(block.object, block.target, block.editor);
				}
			}
		}
		
		public static function position(object:DisplayObject, target:DisplayObject, editor:Editor):void{
			var offsetX:int = editor.offsetX;
			var offsetY:int = editor.offsetY;
				
			//Вычисление итогового смещения
			if(editor.objectAlignX == AlignType.RIGHT)		offsetX += object.width;
			if(editor.objectAlignY == AlignType.BOTTOM)	offsetY += object.height;
			if(editor.scalePositionX)						offsetX *= (Newspaper.stage.stageWidth / Newspaper.nativeStageWidth);
			if(editor.scalePositionY)						offsetY *= (Newspaper.stage.stageHeight / Newspaper.nativeStageHeight);
			
			//Смещение
			switch(editor.screenAlignX){
				case AlignType.LEFT:	object.x = offsetX; break;
				case AlignType.RIGHT:	object.x = Newspaper.stage.stageWidth - offsetX; break;
				case AlignType.CENTER:	object.x = (Newspaper.stage.stageWidth - object.width) / 2;
			}
			
			switch(editor.screenAlignY){
				case AlignType.TOP:	object.y = offsetY; break;
				case AlignType.BOTTOM:	object.y = Newspaper.stage.stageHeight - offsetY; break;
				case AlignType.CENTER:	object.y = (Newspaper.stage.stageHeight - object.height) / 2;
			}
		}
		
		/*public static function scale(object:DisplayObject, manager:Editor):void{
			if(Newspaper.stage == null){
				throw new Error('Property stage is null');
			}
			
			if(Newspaper.nativeStageWidth == 0 || Newspaper.nativeStageHeight == 0){
				throw new Error('Native stage dimension is null');
			}
			
			if(manager.nativeWidth == 0 || manager.nativeHeight == 0){
				throw new Error('Native object dimension is null');
			}
			
			switch(manager.scaleMode){
				case NewspaperScaleMode.NONE:
					object.width = manager.nativeWidth * (Newspaper.stage.stageWidth / Newspaper.nativeStageWidth); 
					object.height = manager.nativeHeight * (Newspaper.stage.stageHeight / Newspaper.nativeStageHeight);
					break;
					
				case NewspaperScaleMode.WIDTH:
					object.width = manager.nativeWidth * (Newspaper.stage.stageWidth / Newspaper.nativeStageWidth); 
					//object.scaleY = object.scaleX;
					break;
					
				case NewspaperScaleMode.HEIGHT:
					object.height = manager.nativeHeight * (Newspaper.stage.stageHeight / Newspaper.nativeStageHeight);
					object.scaleX = object.scaleY;
			}
		}*/
	}
}

import ru.gotoandstop.newspaper.Editor;
import flash.display.DisplayObject;

internal class Block{
	public var object:DisplayObject;
	public var target:DisplayObject;
	public var editor:Editor;
	public var callback:Function;
	public function Block(object:DisplayObject, target:DisplayObject, editor:Editor, callback:Function){
		this.object = object;
		this.target = target;
		this.editor = editor;
		this.callback = callback;
	}
}