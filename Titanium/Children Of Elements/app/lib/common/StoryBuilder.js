/**
parsea el json y genera los slides

return all slides of  a story
**/
var Slide = require('StorySlide');

var _slides

function StoryBuilder(_storyID){

	/// parse data
	var _data = this.parseJSON('/json/story'+ _storyID +'.json');
	
	/// create slide class
	var _slides = Ti.UI.createView()

	for (var i = 0; i < _data.length; i++) {

		_slides.add( new Slide( _data[i] ) )

	};


	return _slides;
}

StoryBuilder.prototype.parseJSON = function(_URL) {
	var file = Titanium.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, _URL);
	var data = file.read().text;
	var json = JSON.parse(data);

	return json;
};


////parser


// looper


/// tools
	
	/// create animations
	/// play sound
	/// generate sequence
	/// 

module.exports = StoryBuilder;