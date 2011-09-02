package{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import ru.gotoandstop.newspaper.Newspaper;
	import ru.gotoandstop.newspaper.types.AlignType;
	
	/**
	 *
	 * Creation date: Sep 2, 2011 (11:28:25 PM)
	 * @author Roman Timashev (roman@tmshv.ru)
	 */
	public class newspaper_demo extends Sprite{
		public function newspaper_demo(){
			if(super.stage){
				this.init();
			}else{
				super.addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
			}
		}
		
		private function init():void{
			super.stage.scaleMode = StageScaleMode.NO_SCALE;
			super.stage.align = StageAlign.TOP_LEFT;
			super.stage.quality = StageQuality.LOW;
			
			Newspaper.init(super.stage, super.stage.stageWidth, super.stage.stageHeight);
			
			var top_left:DisplayObject = this.getRectangle(new Rectangle(0, 0, 10, 10));
			var top_right:DisplayObject = this.getRectangle(new Rectangle(0, 0, 10, 10));
			var bottom_right:DisplayObject = this.getRectangle(new Rectangle(0, 0, 10, 10));
			var bottom_left:DisplayObject = this.getRectangle(new Rectangle(0, 0, 10, 10));
			super.addChild(top_left);
			super.addChild(top_right);
			super.addChild(bottom_left);
			super.addChild(bottom_right);
			
			Newspaper.add(top_left, super.stage, null, 10, 10, AlignType.LEFT, AlignType.TOP);
			Newspaper.add(top_right, super.stage, null, 10, 10, AlignType.RIGHT, AlignType.TOP);
			Newspaper.add(bottom_left, super.stage, null, 10, 10, AlignType.LEFT, AlignType.BOTTOM);
			Newspaper.add(bottom_right, super.stage, null, 10, 10, AlignType.RIGHT, AlignType.BOTTOM);
		}
		
		private function getRectangle(rect:Rectangle):DisplayObject{
			var obj:Sprite = new Sprite();
			obj.graphics.beginFill(0x000000, 0.333);
			obj.graphics.drawRect(0, 0, rect.width, rect.height);
			obj.graphics.endFill();
			obj.x = rect.x;
			obj.y = rect.y;
			return obj;
		}
		
		private function handleAddedToStage(event:Event):void{
			super.removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
			this.init();
		}
	}
}