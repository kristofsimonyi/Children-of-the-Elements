/// handle wich slide be shown on screen
function StoryNavigator(_storySlides){

	this.storyView = Ti.UI.createView()


	if(_storySlides.length<=0){
		this.errorManager("empty slide array");

	}else{
		
		this.storySlides = _storySlides
		//this.init()
	}

	//return this.storyView;
}


StoryNavigator.prototype.storySlides;
StoryNavigator.prototype.storyView;
//StoryNavigator.prototype.currentSlide;
StoryNavigator.prototype.contentCount;



StoryNavigator.prototype.init = function() {
	// place the first slide
	//this.storyView.add(this.storySlides[0])

	this.loadSlide(0)


	this.contentCount = 0
	

	return this.storyView
};


StoryNavigator.prototype.next = function() {

	if((this.contentCount + 1) < this.storySlides.length){
		
		this.contentCount++

		//alert(this.contentCount)
		this.loadSlide(this.contentCount)
	}	
};


StoryNavigator.prototype.back = function() {
	

	if((this.contentCount -1) >= 0){

		this.contentCount--

		//alert(this.contentCount)
		this.loadSlide(this.contentCount)

		
	}
};


StoryNavigator.prototype.loadSlide = function(_slideID) {
	
	
	this.storySlides[_slideID].backgroundColor = "#ffffff";
	this.storySlides[_slideID].parentView = this.storyView;
	this.storySlides[_slideID].opacity = 0

	this.storyView.add(this.storySlides[_slideID])
	
	// check if this slide already appeared
	if (this.storySlides[_slideID].onStage ){
		this.storySlides[_slideID].fireEvent('story_slideImage_loaded')
	}


	


};


StoryNavigator.prototype.errorManager = function(_message) {

	alert(_message)
};


module.exports = StoryNavigator;