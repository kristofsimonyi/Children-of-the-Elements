var args = arguments[0] || {};
var currentItem = args.currentItem;

var SlideShow = require('/common/SlideShow');
var PedalMenu = require('/common/PedalMenu');
 


var _slideshow;
var	_pedals;
 

function init(){

	$.MainTitle.text = args.currentItem.id;
	$.descriptionText.text = "This is a placeholder for the  >" + args.currentItem.id.toUpperCase() + "< planet. There is no layout yet...use your imagination in here :)  ";

	setPlanet();
	$.aboutImage.touchEnabled = false;
	$.aboutImage.zIndex = 20

	

	var TO = setTimeout(function(){
		_slideshow = new SlideShow();

		$.bookshelf_slide.add(_slideshow);
	},1000)
		

	_pedals = new PedalMenu( $.MainTitle , $.descriptionText );
	
		$.pedalMenuElement.add(_pedals);


 

	$.bookshelf_play.addEventListener('click',function(){

		var soonScreen = Alloy.createController('soon').getView();

		soonScreen.open({
			fullscreen:true,
			navBarHidden : true,
			modal: true,
		});
				
	})

	 

}


function setPlanet(){


		//$.planetImage.animate(animationFinal);
		var planetObject = $.planetImage;
		var argsObj = args.currentItem;
		
		planetObject.backgroundImage = argsObj.backgroundImage;
		planetObject.zIndex = 10
/*
		planetObject.bottom = -(planetObject.height/3);
		planetObject.left = -200;
		planetObject.transform = Ti.UI.create2DMatrix().rotate(49);
*/
		if(Ti.Platform.name == "android"){
			
			planetObject.bottom = -60;
		}else{
			planetObject.top = "75%";
		}
		
}

 
/// play sound on load
function playLoopAudio(){
	
	player = Ti.Media.createSound({url:"/audio/storyOfTheSea.mp3", looping:true});
	player.looping = true; 
	player.play();	
}

function stopLoopAudio(){
	Ti.App.fireEvent('stopSlideShow');
	player.stop();
	//player = null;
	//_slideshow = null

	
}

function suscribe(){


	var animation = Titanium.UI.createAnimation({ opacity:1, duration: 600 });

	$.aboutImage.touchEnabled = true;
	$.aboutImage.animate(animation );
	$.aboutImage.addEventListener('click', function(){
		var animationx = Titanium.UI.createAnimation({ opacity:0, duration: 600 });
		$.aboutImage.animate(animationx );
		$.aboutImage.touchEnabled = false;
	})
 
}



//// add pedals dynamically




function cerrar(){

	Ti.App.fireEvent('backPlanet');

	$.bookshelf.close();
 
}


init();

