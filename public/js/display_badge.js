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

        console.log(method);
        req.open("GET",url);

        req.onreadystatechange = function () {
            if (req.readyState != 4) return;
            if (req.status != 200 && req.status != 304) {
                error_callback(req);
            }
            callback(req);
        }

        req.send("");
    }


    function show_badge(api_key, project_slug, achievement_slug)
    {
        console.log("Coucou");
        request('me.json?auth_token=' + api_key, 'GET', function(req) {
            console.log('req' + req);
        })
        // request('user_achievement/?auth_key=' + api_key +
        //     '&project_slug=' + project_slug +
        //     '&achievement_slug=' + achievement_slug, 'GET',
        //     function (req) {
        //         console.log(req);
        //         // Show data
        //     }, function (req) {
        //         if(req.status == 401) {
        //             console.log('401');
        //             // Show login button
        //         }
        //     });
    }

    scope.show_badge = show_badge;
})(window);