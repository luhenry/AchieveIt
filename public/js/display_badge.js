(function(scope){

    function request(url, method, callback, error_callback) {
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
                console.log("Error");
                console.log(req.status);
                console.log(req.statusText);
                error_callback(req);
            } else {
                console.log("Callback");
                callback(req);
            }
        }

        req.send("");
    }


    function show_badge(project_slug, achievement_slug)
    {
        request('http://ec2-54-247-86-73.eu-west-1.compute.amazonaws.com/level/' + project_slug +
            '/' + achievement_slug, 'GET',
            function (req) {
                console.log(req);
                // Show data
            }, function (req) {
                console.log('In error callback');
                console.log(req.status);
                if(req.status == 401) {
                    console.log('401');
                    console.log(location);
                    // Show login button
                }
            });
    }

    scope.show_badge = show_badge;
})(window);