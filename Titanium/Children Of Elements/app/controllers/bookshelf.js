var args = arguments[0] || {};
// $.label.text = args.foobar;
var currentItem = args.currentItem;


function init(){

	$.inicio.text = args.currentItem.id;
	$.texto.text = "This is a placeholder for the  >" + args.currentItem.id.toUpperCase() + "< planet. There is no layout yet...use your imagination in here :)  ";

	setPlanet();

}


function setPlanet(){


		//$.planetImage.animate(animationFinal);
		var object = $.planetImage;
		var argsObj = args.currentItem;
		
		object.backgroundImage = argsObj.backgroundImage;

		

}


/// play sound on load
function playLoopAudio(){
	
	player = Ti.Media.createSound({url:"/audio/storyOfTheSea.mp3", looping:true});
	player.looping = true; 
	player.play();	
}

function stopLoopAudio(){

	player.stop();
	
}



init();



///cancelar el back

 
