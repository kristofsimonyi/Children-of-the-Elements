/***
Contiene y administra un slide

return: a self contained slide
*/

function StorySlide(_slideData){
	
	// start animated array
	this.animatedItems = []

	//alert("yoyoyoy")


	/// create main container
	this.mainView = Ti.UI.createView({opacity:0})

	// include slide data inside the class
	this.slideData = _slideData;
 


	///add elements to slide
	this.buildElements()

	this.mainView.anima = this.animatedItems;
 
	this.mainView.imageCount= 0;


	this.mainView.addEventListener('story_slideImage_loaded', this.slideLoaded)


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
	
	_itemsLength = this.slideData.stageElements.length 
	for (var i = 0; i < _itemsLength ; i++) {
	 
		var element = this.createSingleElement( this.slideData.stageElements[i] , _itemsLength);
			element.zIndex = i
			element._parent = this.mainView
			



		this.mainView.add(element);

	};

};


/// create a single element based on map document Info
StorySlide.prototype.createSingleElement = function(_targetElement, _totalCount) {

	/// test values
	if(!_targetElement.type){
		this.errorDetect("target type not found")
	}

	
	var currentElement

	///set rotationAxis android
		if(_targetElement.animation){


			if(_targetElement.animation.rotateAxis){

				var axis = this.setAxis(_targetElement.animation.rotateAxis)
				_targetElement.properties.anchorPoint = axis;
				_targetElement.animation.anchorPoint = axis;

				alert("anchorPoint Tester is --->" + _targetElement.animation.rotate)

			}
			
		}

	switch(_targetElement.type){

		case "image":

			_targetElement.properties.image = '/storyAssets/story1/'+ _targetElement.properties.image;

			currentElement = Ti.UI.createImageView(_targetElement.properties)
			currentElement.itemCount = _itemsLength 




			///attach load event
				currentElement.addEventListener('load',function(e){



					if(++e.source._parent.imageCount == e.source.itemCount){
						e.source._parent.fireEvent("story_slideImage_loaded");
						e.source._parent.imageCount = 0
						//e.source._parent = null
					}

					

					
				})



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


/// asign animations based on map
StorySlide.prototype.animations = function(_animData) {
	
	
 
	/// valida si existe rotation

	var matrix = Ti.UI.create2DMatrix()

	///set rotationAxis Animation
		if(_animData.rotateAxis){
			_animData.anchorPoint = this.setAxis(_animData.rotateAxis)
			alert("rotation Axis B")
		}

	/// rotations
		if(_animData.rotate){
			//alert("rotation" + _animData.rotate)
			matrix = matrix.rotate(90);
			_animData.transform = matrix

		}

	_animData.rotateAxis	
	_animData.rotate = null;
	_animData.scale = null;
	



	var _animation = Ti.UI.createAnimation(_animData);
		
		

	return _animation;
};







/// start animation on slide
StorySlide.prototype.animateSlide = function(e){


	// Loop animation queue
	for (var i = 0; i < e.source.anima.length; i++) {
		
		var element = e.source.anima[i]
			element.animate( element._innerAnimation )
	};

	e.source.removeEventListener('animarSlide', function(){});
}

///counts every loaded image
StorySlide.prototype.slideLoaded = function(e) {
	
	//
	var element = e.source

	var animation = Titanium.UI.createAnimation({opacity:1, duration:600});

	//alert("removexx")

	element.animate(animation)

	animation.parentView = element.parentView

	animation.addEventListener('complete',function(e){
 
		
		if(e.source.parentView.children.length > 1){ 
			//alert("removed Slide")//e.source.parentView.children.length )
			e.source.parentView.remove(e.source.parentView.children[0]);
		}

		//alert("bamboozled")
		

	});

	if(Ti.Platform.name == "android"){
			element.onStage = false
	}

	if(!element.onStage){
			element.fireEvent('animarSlide')
	}

};




///////////////////// TOOLS /////////


StorySlide.prototype.setAxis = function(_axis) {

	var point;

	/*

	top left : anchorPoint:{x:0,y:0} 
	top right : anchorPoint:{x:1,y:0}
	center : anchorPoint:{x:0.5,y:0.5}
	bottom left : anchorPoint:{x:0,y:1} 
	bottom right : anchorPoint:{x:1,y:1}
	*/
	switch(_axis){
		case "topCenter":
			point = {x:0.5, y:0};
			break;
		case "topLeft":
			point = {x:0, y:0};
			break;
		case "topRight":
			point = {x:1,y:0};
			break;
		case "center":
			point = {x:0.5,y:0.5};
			break;
		case "bottomLeft":
			point = {x:0,y:1};
			break;
		case "bottomRight":
			point = {x:1,y:1};
			break;
		case "bottomCenter":
			point = {x:0.5,y:1};
			break;
		default:
			this.errorDetect("no valid axis value")
	}


	return point

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

