/* ***	© 2oo8 Timashev Roman *** */

package ru.gotoandstop.newspaper{
	import ru.gotoandstop.newspaper.types.AlignType;
	
	public class Editor{
		
/* *******
PROPERTIES
**************************************************************************************** */
		public var nativeWidth:int;
		public var nativeHeight:int;
		
		public var scalePositionX:Boolean;
		public var scalePositionY:Boolean;
		
		public var offsetX:int;
		public var offsetY:int;
		
		private var _screenAlignX:String = 'left';
		private var _screenAlignY:String = 'top';
		
		private var _objectAlignX:String = 'left';
		private var _objectAlignY:String = 'top';
		
		private var _scaleMode:uint = 0;
		
/* ********
CONSTRUCTOR
**************************************************************************************** */
		public function Editor(){
			
		}
		
/* ***********
PUBLIC METHODS
**************************************************************************************** */
		public function clone():Editor{
			var e:Editor = new Editor();
			e._objectAlignX = this._objectAlignX;
			e._objectAlignY = this._objectAlignY;
			e._scaleMode = this._scaleMode;
			e._screenAlignX = this._screenAlignX;
			e._screenAlignY = this._screenAlignY;
			e.nativeHeight = this.nativeHeight;
			e.nativeWidth = this.nativeWidth;
			e.offsetX = this.offsetX;
			e.offsetY = this.offsetY;
			e.scalePositionX = this.scalePositionX;
			e.scalePositionY = this.scalePositionY;
			
			return e;
		}

		/*public function saveObjectDimensions(object:DisplayObject):void{
			nativeWidth = object.width;
			nativeHeight = object.height;
		}
		
		public function rightAlign():void{
			screenAlignX = DisplayObjectTransformAlign.RIGHT;
			objectAlignX = DisplayObjectTransformAlign.RIGHT;
		}
		
		public function leftAlign():void{
			screenAlignX = DisplayObjectTransformAlign.LEFT;
			objectAlignX = DisplayObjectTransformAlign.LEFT;
		}
		
		public function topAlign():void{
			screenAlignY = DisplayObjectTransformAlign.TOP;
			objectAlignY = DisplayObjectTransformAlign.TOP;
		}
		
		public function bottomAlign():void{
			screenAlignY = DisplayObjectTransformAlign.BOTTOM;
			objectAlignY = DisplayObjectTransformAlign.BOTTOM;
		}
		
		public function horizontalCenterAlign():void{
			screenAlignX = DisplayObjectTransformAlign.CENTER;
			//objectAlignX = DisplayObjectTransformAlign.CENTER;
		}
		
		public function verticalCenterAlign():void{
			screenAlignY = DisplayObjectTransformAlign.CENTER;
			//objectAlignY = DisplayObjectTransformAlign.CENTER;
		}
		
		public function toString():String{
			var result:String = '(offset X:' + offsetX + '; ';
			result += 'offset Y:' + offsetY + '; ';
			result += 'align X:' + _screenAlignX + ', ' + _objectAlignX + '; ';
			result += 'align Y:' + _screenAlignY + ', ' + _objectAlignY + ')';
			
			return result;
		}*/
		
/* **********************
PUBLIC GETTERES & SETTERS
**************************************************************************************** */
		//
		public function get screenAlignX():String{
			return _screenAlignX;
		}
		
		public function set screenAlignX(value:String):void{
			if(checkAlignValidity(value)){
				_screenAlignX = value;
			}
		}
		
		//
		public function get screenAlignY():String{
			return _screenAlignY;
		}
		
		public function set screenAlignY(value:String):void{
			if(checkAlignValidity(value)){
				_screenAlignY = value;
			}
		}
		
		//
		public function get objectAlignX():String{
			return _objectAlignX;
		}
		
		public function set objectAlignX(value:String):void{
			if(checkAlignValidity(value)){
				_objectAlignX = value;
			}
		}
		
		//
		public function get objectAlignY():String{
			return _objectAlignY;
		}
		
		public function set objectAlignY(value:String):void{
			if(checkAlignValidity(value)){
				_objectAlignY = value;
			}
		}
		
		//
		public function get scaleMode():uint{
			return _scaleMode;
		}
		
		public function set scaleMode(value:uint):void{
			if(checkScaleModeValidity(value)){
				_scaleMode = value;
			}
		}
		
/* ************
PRIVATE METHODS
**************************************************************************************** */
		private function checkAlignValidity(align:String):Boolean{
			if(align == AlignType.BOTTOM || align == AlignType.CENTER || align == AlignType.LEFT || align == AlignType.RIGHT || align == AlignType.TOP) return true;
			else return false;
		}
		
		private function checkScaleModeValidity(mode:uint):Boolean{
			var result:Boolean = false;
			
			if(mode == 0 || mode == 1 || mode == 2){
				result = true;
			}
			
			return result;
		}
	}
}