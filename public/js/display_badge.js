(function(scope){

    function request(url, method, callback) {
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

        req.open("GET",url,true);

        req.onreadystatechange = function () {
            if (req.readyState != 4) return;
            if (req.status != 200 && req.status != 304) {
                return;
            } else {
                callback(req);
            }
        }

        req.send("");
    }


    function show_badge(project_slug, achievement_slug, id)
    {
        var search = window.location.search.substring(1);
        var parts = search.split("=");

        if (!parts[1]) {
            location.href = 'http://api.gameup.co/login?redirect_url=' + encodeURIComponent( document.location.href )
        }

        request('http://api.gameup.co/level/' + project_slug +
            '/' + achievement_slug + '?username=' + parts[1], 'GET',
            function (req) {
                var data = eval(req.responseText);
                document.getElementById(id).appendChild(document.createTextNode(data));
            });
    }

    scope.show_badge = show_badge;
})(window);