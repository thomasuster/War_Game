function init()
{
	
	var params = get_params();
	
	/*alert("Hello world")
	var params = [];
	params["goose"] = "cook";
	alert(params["goose"]);
	//
	*/
	alert(params["game_uuid"]);
}

//http://snipplr.com/view/799/get-url-variables/
function get_params()
{
	var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	
	for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
 
    return vars;
}