function request(url, postData, callback, error_callback)
{
    var XMLHttpFactories = [
        function () {return new XMLHttpRequest()},
        function () {return new ActiveXObject("Msxml2.XMLHTTP")},
        function () {return new ActiveXObject("Msxml3.XMLHTTP")},
        function () {return new ActiveXObject("Microsoft.XMLHTTP")}
    ];

    function createXMLHTTPObject() {
        var xmlhttp = false;
        for (var i=0;i<XMLHttpFactories.length;i++) {
            try {
                xmlhttp = XMLHttpFactories[i]();
            }
            catch (e) {
                continue;
            }
            break;
        }
        return xmlhttp;
    }

    var req = createXMLHTTPObject();
    if (!req) return;
    var method = (postData) ? "POST" : "GET";

    req.open(method,url,true);

    if(postData)
        req.setRequestHeader('Content-type','application/x-www-form-urlencoded');

    req.onreadystatechange = function () {
        if (req.readyState != 4) return;
        if (req.status != 200 && req.status != 304) {
            error_callback(req);
        }
        callback(req);
    }

    req.send(qdata);
}


function show_badge(api_key, project_slug, achivement_slug)
{
    request('http://api.gameup.co/user_achievement', {
            api_key: api_key,
            project_slug: project_slug,
            achievement_slug: achievement_slug
        }, function (req) {
            // Show data
        }, function (req) {
            if(req.status == 401) {
                console.log('401');
                // Show login button
            }
        });
}