var args = arguments[0] || {};
var currentStoryID = args.storyID;


var Story = require('/common/StoryBuilder');
var Navigator = require('/common/StoryNavigator');

var	_story;
var _navigator;

/// importar clase creadora
/// importar manejo de sonidos?
/// importar manejo de slides? 

function init(){

	/** @TODO funcion de carga */
	//Ti.App.imageCount = 0
	
	_story = new Story(currentStoryID);
	_navigator = new Navigator(_story)

	$.storyStage.add(_navigator.init() );


	/** @TODO agregar controles de navegacion **/

}


$.storyViewer.addEventListener('open', function(){
	init();
})


function next(){
	_navigator.next();
}

function back(){
	_navigator.back();
}

function exitStory(){
	__navigator = null;
	///_story.cleaner()
	_story = null;
	$.storyViewer.close();
}