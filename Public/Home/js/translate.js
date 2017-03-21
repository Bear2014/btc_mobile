$(document).ready(function(){
	if(checkEnv())
		$('[lang-ext]').each(translate);
	
});

function checkEnv(){
	//英文环境才进行翻译
	if(LANG_SET && LANG_SET == 'en-us')
		return true;
	return false;
}

/**
 * 翻译成英文
 */
function translate(){
	if(checkEnv()){
		var self = $(this);
		var success = function(str){
			self.html(str);
		}
		$.get("/Ajax/translate?src=" + encodeURIComponent(self.html()), success);
	}
}

function transScope(parent){
	if(checkEnv() && parent != null){
		parent.find('[lang-ext]').each(translate);
	}
}