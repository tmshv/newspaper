package{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import ru.gotoandstop.newspaper.Newspaper;
	import ru.gotoandstop.newspaper.types.PaperAlign;
	
	
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
			
			var left:DisplayObject = this.getRectangle(new Rectangle(0, 0, 100, 150));
			super.addChild(left);
			Newspaper.add(left, super.stage, null, 10, 10, PaperAlign.LEFT, PaperAlign.TOP);
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