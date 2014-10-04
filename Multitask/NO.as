
package {

	import flash.display.*;
	import flash.events.*;

	public class NO extends MovieClip {
		public var ySpeed:Number=-25;
		public var randomNum:Number=Math.random()*5-2.5;
		public var xSpeed:Number = Math.random()*10-5;
		public var notdie:Boolean = true;
		var betterdeath:Boolean=false;
		public function NO() {
			this.addEventListener(Event.ENTER_FRAME, RotateCircle);

		}
		function RotateCircle(e:Event) {
			rotation+=randomNum;
			x+=xSpeed;
			y+=ySpeed;
			xSpeed*=.95;
			randomNum*=.95;
			ySpeed+=1;
			/*
			if(this.hitTestObject(MovieClip(root).Jane)){
				MovieClip(root).shake(scaleX*5,Math.random()*5,Math.random()*5,.7);
				MovieClip(root).Hw-=75*scaleX;
				selfDestruct();
			}
			*/
			for(var q in MovieClip(root).questions){
				if(this.hitTestObject(MovieClip(root).questions[q]) && notdie){
					if(MovieClip(root).questions[q].correct==0){
						MovieClip(root).questions[q].death=1;
						betterdeath=true;
						MovieClip(root).GPA+=.1;
						MovieClip(root).your_right.play();
						if(MovieClip(root).GPA>4){
							MovieClip(root).GPA=4;
						}
					}else{
						MovieClip(root).questions[q].death=2;
						MovieClip(root).GPA-=.2;
						MovieClip(root).your_wrong.play();
						ySpeed+=8;
					}
					notdie=false;
					
					xSpeed+=Math.random()*20-10;
				}
			}
			
			if(betterdeath){
				alpha-=.05;
			}
			if (x>750||x<-50||y>450||y<-50||alpha<.1) {
				selfDestruct();

			}

		}
		public function selfDestruct():void {
			this.removeEventListener(Event.ENTER_FRAME, RotateCircle);
			parent.removeChild(this);
		}
	}
}