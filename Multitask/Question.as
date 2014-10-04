
package {

	import flash.display.*;
	import flash.events.*;
	import flash.geom.ColorTransform;

	public class Question extends MovieClip {
		
		var my_color:ColorTransform = transform.colorTransform;
		var ySpeed:Number=-8;
		var xSpeed:Number=0;
		var incase:Number=Math.random()*20-10;
		public var correct:int=int(Math.random()*2);
		var death:int = 0;
		
		var multi:Number=20;
		var fish:Array=new Array("sardine","herring","mackerel","trout","cod","pike","salmon","tuna","bass","manta ray","swordfish","shark");
		var amphi:Array=new Array("frog","toad","newt","salamander");
		var insects:Array=new Array("roach","grasshopper","mosquito","ant","butterfly","dragonfly","housefly","ladybug","centipede","bee","wasp","beatle");
		var reptiles:Array=new Array("snake","lizard","alligator","crocodile","turtle","chamelion");
		var mammals:Array=new Array("cat","dog","cow","pig","horse","whale","dolphin","pig","skunk","racoon","moose","bear");

		var capitals:Array = new Array("Montgomery","Helena","Juneau","Lincoln","Phoenix","Carson City","Little Rock","Concord","Sacramento","Trenton","Denver","Santa Fe","Hartford","Albany","Dover","Raleigh","Tallahassee","Bismarck","Atlanta","Columbus","Honolulu","Oklahoma City","Boise","Salem","Springfield","Harrisburg","Indianapolis","Providence","Des Moines","Columbia","Topeka","Pierre","Frankfort","Nashville","Baton Rouge","Austin","Augusta","Salt Lake City","Annapolis","Montpelier","Boston","Richmond","Lansing","Olympia","Saint Paul","Charleston","Jackson","Madison","Jefferson City","Cheyenne");
		var states:Array = new Array("Alabama","Montana","Alaska","Nebraska","Arizona","Nevada","Arkansas","New Hampshire","California","New Jersey","Colorado","New Mexico","Connecticut","New York","Deleware","North Carolina","Florida","North Dakota","Georgia","Ohio","Hawaii","Oklahoma","Idaho","Oregon","Illinois","Pennsylvania","Indiana","Rhode Island","Iowa","South Carolina","Kansas","South Dakota","Kentucky","Tennessee","Louisiana","Texas","Maine","Utah","Maryland","Vermont","Massachusetts","Virginia","Michigan","Washington","Minnesota","West Virginia","Mississippi","Wisconsin","Missouri","Wyoming");




		public function Question() {
			var topic_id:int=int(Math.random()*3)+1;
			var topic:String="null";
			if (topic_id==1) {
				topic="Math";
			} else if (topic_id==2) {
				topic="Science";
			} else if (topic_id==3) {
				topic="Other";
			}

			if (topic=="Math") {
				var a:int=int(Math.random()*13);
				var b:int=int(Math.random()*13);
				var c:int=0;
				var checkit:Boolean=true;

				var offset:int=int(Math.random()*10);
				if (offset==0) {
					offset=1;
				}
				var upordown:int=int(Math.random()*2);
				if (upordown==1) {
					offset*=-1;
				}
				if (correct==0) {
					c=offset;
					checkit=false;
				}
				var subject_id:int=int(Math.random()*3)+1;
				if (subject_id==1) {
					//addition
					c+=a+b;
					anim.quest.text=String(a+"+"+b+"="+c);
				} else if (subject_id==2) {
					//subtraction
					c+=a-b;
					anim.quest.text=String(a+"-"+b+"="+c);
				} else {
					//multiplication
					c+=a*b;
					anim.quest.text=String(a+"*"+b+"="+c);
				}
			} else if (topic=="Science") {
				var animals:Array=new Array(fish,amphi,insects,reptiles,mammals);
				var animal:int=int(Math.random()*5);
				var animals_sub:Array=new Array("fish","amphibian","reptile","mammal");
				var correct_ans:String="alien";
				if (animal==0) {
					correct_ans="fish";
				} else if (animal==1) {
					correct_ans="amphibian";
				} else if (animal==2) {
					correct_ans="insect";
				} else if (animal==3) {
					correct_ans="reptile";
				} else {
					correct_ans="mammals";
				}
				var randAnim:int=int(Math.random()*animals[animal].length);
				var the_animal:String=animals[animal][randAnim];
				animals_sub.splice(animal,1);
				if (correct==0) {
					correct_ans=animals_sub[int(Math.random()*4)];
				}
				anim.quest.text=String("An "+the_animal+" is a "+correct_ans);
			} else {
				var state_ind:int = int(Math.random()*50);
				var cap_ind:int= state_ind;
				if(correct==0){
					capitals.splice(state_ind,1);
					cap_ind=int(Math.random()*49);
				}
				anim.quest.text=String(capitals[cap_ind]+" is the capital of "+states[state_ind]);
				
			}



			this.addEventListener(Event.ENTER_FRAME, RotateCircle);

		}
		function RotateCircle(e:Event) {
			y+=MovieClip(root).fallrate;
			x+=xSpeed;
			/*
			if(this.hitTestObject(MovieClip(root).Jane)){
			MovieClip(root).shake(scaleX*5,Math.random()*5,Math.random()*5,.7);
			MovieClip(root).Hw-=75*scaleX;
			selfDestruct();
			}
			*/
			
			if(y>(395-height)){
				death=2;
				MovieClip(root).GPA-=.2;
			}
			if(death==1){
				y+=ySpeed;
				ySpeed--;
				my_color.greenOffset+=10;
				my_color.alphaMultiplier -= 0.05;
				transform.colorTransform = my_color;
				alpha-=.05;
			}else if(death==2){
				y+=ySpeed;
				ySpeed++;
				xSpeed=incase;
				incase*=.95;
				my_color.redOffset+=10;
				my_color.alphaMultiplier -= 0.05;
				transform.colorTransform = my_color;
				alpha-=.05;
				
			}
			
			if (alpha<.1) {
				selfDestruct();
			}

		}
		public function selfDestruct():void {
			this.removeEventListener(Event.ENTER_FRAME, RotateCircle);
			var ind:int = MovieClip(root).questions.indexOf(this);
			MovieClip(root).questions.splice(ind,1);
			parent.removeChild(this);
		}
	}
}

