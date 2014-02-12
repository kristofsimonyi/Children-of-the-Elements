var args = arguments[0] || {};
// $.label.text = args.foobar;
var currentItem = args.currentItem;


function init(){

	$.inicio.text = args.currentItem.id;
	$.texto.text = "This is a placeholder for the  >" + args.currentItem.id.toUpperCase() + "< planet. There is no layout yet...use your imagination in here :)  ";

	setPlanet();
	//addPedals()
	showSlide();

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



//// add pedals dynamically

function addPedals(){

	petalo1 = {"left":"-40.7", "top":"76" , "rotacion":"-340"};
	 

	var petalos = [petalo1, petalo2, petalo3, petalo4, petalo5];


	

	for (var i = 0; i < petalos.length; i++) {


		var petalo = Ti.UI.createImageView({image:"/bookshelf/bookshelf_pedalMenu_pedal_normal.png"})
	
	

			var matrix = Ti.UI.create2DMatrix();
				matrix = matrix.rotate(-340); //340


			petalo.width = 144;
			petalo.height = 160;
			petalo.left = petalos[i].left;
			petalo.top = petalos[i].top;
			petalo.transform = matrix;

			petalo.addEventListener('click', function(){
				alert("yolo")
			})


			$.pedalItems.add(petalo);

			petalo.transform = matrix;


	};

}

function showSlide(){

	var imageSlides = ["/bookshelf/bookshelf_imageslide_01.jpg", "/bookshelf/bookshelf_imageslide_02.jpg" , "/bookshelf/bookshelf_imageslide_03.jpg"]
	$.bookshelf_slide.images = imageSlides;
	$.bookshelf_slide.start();

	//alert("start yo")
}






init();



///cancelar el back

 
