var args = arguments[0] || {};
var currentItem = args.currentItem;

var SlideShow = require('/common/SlideShow');


function init(){

	$.MainTitle.text = args.currentItem.id;
	$.descriptionText.text = "This is a placeholder for the  >" + args.currentItem.id.toUpperCase() + "< planet. There is no layout yet...use your imagination in here :)  ";

	setPlanet();
	//addPedals()
	var slideshow = new SlideShow();

	$.bookshelf_slide.add(slideshow);

}


function setPlanet(){


		//$.planetImage.animate(animationFinal);
		var planetObject = $.planetImage;
		var argsObj = args.currentItem;
		
		planetObject.backgroundImage = argsObj.backgroundImage;
		planetObject.bottom = -(planetObject.height/3);
		planetObject.left = -200;
		planetObject.transform = Ti.UI.create2DMatrix().rotate(49);
		
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



//// add pedals dynamically

function addPedals(){

	petalo1 = {"left":"-40.7", "top":"76" , "rotacion":"-340"};
	 

	var petalos = [petalo1, petalo2, petalo3, petalo4, petalo5];


	

	for (var i = 0; i < petalos.length; i++) {


		var petalo = Ti.UI.createImageView({image:"/bookshelf/bookshelf_pedalMenu_pedal_normal.png"});
	
	

			var matrix = Ti.UI.create2DMatrix();
				matrix = matrix.rotate(-340); //340


			petalo.width = 144;
			petalo.height = 160;
			petalo.left = petalos[i].left;
			petalo.top = petalos[i].top;
			petalo.transform = matrix;

			petalo.addEventListener('click', function(){
				alert("yolo");
			});


			$.pedalItems.add(petalo);

			petalo.transform = matrix;


	};

}



init();

