var args = arguments[0] || {};
var currentStoryID = args.storyID;


var Story = require('/common/StoryBuilder');
var	_story;

/// importar clase creadora
/// importar manejo de sonidos?
/// importar manejo de slides? 

function init(){

	/** @TODO funcion de carga */
	
	_story = new Story(currentStoryID);

	$.storyViewer.add(_story);

	/** @TODO agregar controles de navegacion **/

}


$.storyViewer.addEventListener('open', function(){
	init();
})


function cerrar(){
	$.storyViewer.close();
}