/***
Contiene y administra un slide

return: a self contained slide
*/

function StorySlide(_slideData){
	
	/// create main container
	this.mainView = Ti.UI.createView()

	// store data inside the class
	this.slideData = _slideData;


	///add elements to slide
	this.mainView.add ( this.buildElements() );


	return this.mainView;
}



StorySlide.prototype.mainView;





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
		/// if there's animation for this element attach it
		if(_targetElement.animation){
			
			var itemAnimation = this.animations(_targetElement.animation);

			currentElement.animate(itemAnimation)

		}
		


	return currentElement;
};


StorySlide.prototype.animations = function(_animData) {
	
	
	Ti.API.info(_animData)

	Ti.API.info("==========")


	/// valida si existe rotation


	_animData.rotate = null;
	_animData.scale = null;

	Ti.API.info(_animData)

	var _animation = Ti.UI.createAnimation(_animData);

	return _animation;
};


/// verifies values
StorySlide.prototype.errorDetect = function(_alertMessage) {
	alert(_alertMessage)
};

//memory delloc
StorySlide.prototype.cleaner = function() {
	// this function should track all images and remove them from memory
};

module.exports = StorySlide;

