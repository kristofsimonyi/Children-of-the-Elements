var args = arguments[0] || {};
// $.label.text = args.foobar;
var currentItem = args.currentItem


function init(){

	$.inicio.text = args.currentItem.id;

	setPlanetPosition()

}


function setPlanetPosition(){



	/// zoom current planet
		var xPosition = Titanium.Platform.displayCaps.platformWidth - 100;
		var matrix = Ti.UI.create2DMatrix();
			matrix = matrix.rotate(-45);
			matrix = matrix.scale(3, 3);

	

		var animationFinal = Titanium.UI.createAnimation({
			top: '80%',
			left: '10', 
			transform: matrix,
			curve: Ti.UI.ANIMATION_CURVE_EASE_IN_OUT,
			duration: 1000
		});

		
		$.planetImage.animate(animationFinal);
		

}



init();

