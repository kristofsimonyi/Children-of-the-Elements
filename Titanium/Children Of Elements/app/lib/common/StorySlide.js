/***
Contiene y administra un slide

return: a self contained slide
*/

function StorySlide(_slideData){
	
	// start animated array
	this.animatedItems = []


	/// create main container
	this.mainView = Ti.UI.createView()

	// include slide data inside the class
	this.slideData = _slideData;


	///add elements to slide
	this.mainView.add ( this.buildElements() );

	this.mainView.anima = this.animatedItems;

	this.mainView.addEventListener('animarSlide', this.animateSlide);

	return this.mainView;
}



StorySlide.prototype.mainView;
StorySlide.prototype.animatedItems;



/// parse the elements lists and add all elements to main View
StorySlide.prototype.buildElements = function() {
	
	/// test values
	if(!this.slideData.stageElements){
		this.errorDetect("stage elements not found")
	}
	var elementsPreWrap = Ti.UI.createView()

	for (var i = 0; i < this.slideData.stageElements.length ; i++) {
	 
		var element = this.createSingleElement( this.slideData.stageElements[i] );
			element.zIndex = i
		elementsPreWrap.add(element);

	};


	//			this.mainView.add( element )

	return elementsPreWrap
};


/// create a single element based on map document Info
StorySlide.prototype.createSingleElement = function(_targetElement) {

	/// test values
	if(!_targetElement.type){
		this.errorDetect("target type not found")
	}

	
	var currentElement

	

	switch(_targetElement.type){

		case "image":
			var newImg = '/storyAssets/story1/'+ _targetElement.properties.image;			
			_targetElement.properties.image = newImg;
			currentElement = Ti.UI.createImageView(_targetElement.properties)

			/**
			@TODO create a preload handler
			currentElement.addEventListener('load',function(){

				//alert("loadef")
			})
			**/


			break;
		default:
			Ti.API.info("create single element, type not found");
	}

	///Attach Animations
		if(_targetElement.animation){
			
			var itemAnimation = this.animations(_targetElement.animation);

			currentElement._innerAnimation = itemAnimation;

			/// add this element to animation queue
			this.animatedItems.push(currentElement);

			//currentElement.animate(itemAnimation)

		}

	///Attach Touch Events
		if(_targetElement.alertOnClick){

			currentElement._msg = _targetElement.alertOnClick
			currentElement.addEventListener('click',function(e){

			})
		}else{

			currentElement.touchEnabled = false;
		}


	return currentElement;
};



StorySlide.prototype.animations = function(_animData) {
	
	
 
	/// valida si existe rotation

	var matrix = Ti.UI.create2DMatrix()

	if(_animData.rotate){
		//alert("rotation" + _animData.rotate)
		matrix = matrix.rotate(90);
		_animData.transform = matrix

	}
	_animData.rotate = null;
	_animData.scale = null;
	



	var _animation = Ti.UI.createAnimation(_animData);
		
		

	return _animation;
};

StorySlide.prototype.animateSlide = function(e){


	// Loop animation queue
	for (var i = 0; i < e.source.anima.length; i++) {
		
		var element = e.source.anima[i]
			element.animate( element._innerAnimation )
	};

	e.source.removeEventListener('animarSlide', function(){});
}


/// verifies values
StorySlide.prototype.errorDetect = function(_alertMessage) {
	alert(_alertMessage)
};


//memory delloc
StorySlide.prototype.cleaner = function() {
	// this function should track all images and remove them from memory
};


module.exports = StorySlide;

