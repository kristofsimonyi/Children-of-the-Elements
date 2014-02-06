/*
function doClick(e) {
    alert($.label.text);
}
*/


var player;
var _flagPlanetIsMoving;



/// play sound on load
function playLoopAudio(){
	
	player = Ti.Media.createSound({url:"/audio/loopTest.mp3", looping:true});
	player.looping = true; 
	player.play();	
}

function stopLoopAudio(){

	player.stop();
}


// handle tap events on planets
function onSelectPlanet(e){
	

	if(!_flagPlanetIsMoving){
			
			/// this only runs when the planet is active
			if( e.source.activePlanet == true){
				//showPlanets(e); 
				openBookshelf(e.source);
			}else{
				//hidePlanets(e);		
			}
			
			
			//e.source.activePlanet = !e.source.activePlanet;

			/// rise flag, planet is moving *see PositionMainPlanet()
			_flagPlanetIsMoving = true;

			hidePlanets(e);
	}
}

/// manage the planets animation onscreen
function hidePlanets(e){


	positionMainPlanet(e.source);

	/// now move other planets off the screen
	
	var selectedElement = e.source.id.toString();

	if ($.index.children) {

		// loop across screen elements 
		for (var c = 0; c < $.index.children.length ; c++) {

			// object cache
			var currentItem = $.index.children[c];

			//retrieve info from object
			var itemID = currentItem.id.toString();

			/// check is not the active planet     
			if( itemID != selectedElement  ){
				positionSecondaryPlanet(currentItem);  		 
			}

		}

	}
}

/// handle the 3 secondary planets position
function positionSecondaryPlanet(_target){

	var currentItem = _target;

	///remove seleced on this planet
	_target.activePlanet = false;

	//retrieve info from object
		var itemID = currentItem.id.toString();
		 
	// define transform matrix for short planets
	var matrix = Ti.UI.create2DMatrix();
		matrix = matrix.rotate(currentItem.preferedRotationBase);
		matrix = matrix.scale(1,1);
	

	//Ti.API.info(currentItem.preferedRightPosition)

	var planetAnimation = Ti.UI.createAnimation({
		transform:matrix,
		curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
		duration:600
	})

	if(_target.preferedTopPosition){
		planetAnimation.top = _target.preferedTopPosition.toString() 
	}

	if(_target.preferedLeftPosition){
		planetAnimation.left = _target.preferedLeftPosition.toString() 
	}
	

	currentItem.animate(planetAnimation);
}

/// handle the main planet position
function positionMainPlanet(_target){


	/// store element properties
	// verfi if this is still neded after next iteration
	_target.originalHeight = _target.height;
	_target.originalWidth = _target.width;
	_target.originalTop = _target.top;
	_target.originalTransform = _target.transform;
	_target.originalBottom = _target.bottom;
	_target.originalLeft = _target.left;
	_target.originalRight = _target.right;


	/* 

			e.source.width = 564;
			e.source.height = 500;
			e.source.top = "5%";
			e.source.layout = "center";
			e.source.left = '25%';
			e.source.right = null;


			regularRotation = Ti.UI.create2DMatrix().rotate(0);	
			e.source.transform = regularRotation;


			var posX = ( Titanium.Platform.displayCaps.platformWidth - (e.source.width) ) / 2;

			var matrix = Ti.UI.create2DMatrix();
			matrix = matrix.rotate(0);
			matrix = matrix.scale(2, 2);

			var a = Ti.UI.createAnimation({
			transform : matrix,
			duration : 2000
			});



			var animationHandler = function() {
			//animation.removeEventListener('complete',animationHandler);
			//animation.backgroundColor = 'orange';
			//view.animate(animation);
			};
			//animation.addEventListener('complete',animationHandler);
	*/

	var matrix = Ti.UI.create2DMatrix();
		matrix = matrix.rotate(0);
		matrix = matrix.scale(2, 2);


	var animation = Titanium.UI.createAnimation({
		top:'30%',
		left:'40%',
		transform:matrix,
		curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
		duration: 1000
	});

	
	_target.animate(animation);

	
	animation.addEventListener('complete',animationHandler);
	
	function animationHandler() {
			_flagPlanetIsMoving = false;
			_target.activePlanet = true;
	};
}

/// align all planets to the orignal position settings (based on current screen size)
function alignPlanets(){

	/// place the planets
	$.north.top = - ( ($.north.height / 3)*1 );
	$.south.top = ( Titanium.Platform.displayCaps.platformHeight - (($.south.height / 3) *2));
	$.east.left = - ( ($.east.width / 3)*1 );
	$.west.left = ( Titanium.Platform.displayCaps.platformWidth - (($.west.width / 3) *2 ) );

	/// store position values
	$.north.preferedTopPosition = - ( ($.north.height / 3)*2 );
	$.south.preferedTopPosition = ( Titanium.Platform.displayCaps.platformHeight - ($.south.height / 3) );
	$.east.preferedLeftPosition = - ( ($.east.width / 3)*2 );
	$.west.preferedLeftPosition = ( Titanium.Platform.displayCaps.platformWidth - ($.west.width / 3) );
}



/// open the next screen
 function  openBookshelf(_target){


 	/// stop all animations

 	// stop sound

 	// close this view?

 	/// clean memory

 	// reset elements
 	currentID = _target.id.toString();


	var bookshelfx = Alloy.createController('bookshelf', {currentItem: currentID}).getView();
	// For Alloy projects, you can pass context
	// to the controller in the Alloy.createController method.
	// var win2 = Alloy.createController('win2', {foobar: 42}).getView();
	bookshelfx.open();



 }






alignPlanets();


//// OPEN THE VIEW
$.index.open({
	fullscreen:true,
	navBarHidden : true
});