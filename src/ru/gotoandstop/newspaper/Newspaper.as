/*
autor: Timashev Roman
version: beta
date: 2oo8
*/

package ru.gotoandstop.newspaper{
	import __AS3__.vec.Vector;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	
	import ru.gotoandstop.newspaper.types.PaperAlign;
	
	public class Newspaper{
		
/* *******
PROPERTIES
**************************************************************************************** */
		public static const VERSION:String = 'beta';
		
		public static var stage:Stage;
		public static var nativeStageWidth:int;
		public static var nativeStageHeight:int;
		
		private static var __conllection:Vector.<Block>;
		private static var __initialized:Boolean;
/* ********
CONSTRUCTOR
**************************************************************************************** */
		public function Newspaper(){
			/*if(Newspaper.stage == null){
				throw new Error('Property stage is null');
			}
			
			if(Newspaper.nativeStageWidth == 0 || Newspaper.nativeStageHeight == 0){
				throw new Error('Native stage dimension is null');
			}*/
		}
		
/* ***********
PUBLIC METHODS
**************************************************************************************** */
		public static function init():void{
			if(Newspaper.__initialized) return;
			else{
				Newspaper.__initialized = true;
				Newspaper.__conllection = new Vector.<Block>();
			}
			
			Newspaper.stage.addEventListener(Event.RESIZE, handlerResize);
		}

		public static function addBlock(object:DisplayObject,
										target:DisplayObject,
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
			
			var b:Block = new Block(object, target, e, callback);
			Newspaper.__conllection.push(b);
			Newspaper.position(object, target, e);
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
			if(editor.objectAlignX == PaperAlign.RIGHT)		offsetX += object.width;
			if(editor.objectAlignY == PaperAlign.BOTTOM)	offsetY += object.height;
			if(editor.scalePositionX)						offsetX *= (Newspaper.stage.stageWidth / Newspaper.nativeStageWidth);
			if(editor.scalePositionY)						offsetY *= (Newspaper.stage.stageHeight / Newspaper.nativeStageHeight);
			
			//Смещение
			switch(editor.screenAlignX){
				case PaperAlign.LEFT:	object.x = offsetX; break;
				case PaperAlign.RIGHT:	object.x = Newspaper.stage.stageWidth - offsetX; break;
				case PaperAlign.CENTER:	object.x = (Newspaper.stage.stageWidth - object.width) / 2;
			}
			
			switch(editor.screenAlignY){
				case PaperAlign.TOP:	object.y = offsetY; break;
				case PaperAlign.BOTTOM:	object.y = Newspaper.stage.stageHeight - offsetY; break;
				case PaperAlign.CENTER:	object.y = (Newspaper.stage.stageHeight - object.height) / 2;
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