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


function plus_one(project_slug, achievement_slug) {
    console.log("plus one");
    var search = window.location.search.substring(1);
    var parts = search.split("=");
    request('http://api.gameup.co/add/' + project_slug +
        '/' + achievement_slug + '?username=' + parts[1], 'GET', function() {
            window.location.reload();
        });
}

function get_steps_info(project_slug, achievement_slug, username, value, callback) {
    request('http://api.gameup.co/achievement_info/' + project_slug +
        '/' + achievement_slug + '?username=' + username, 'GET', function(req) {
            var steps = eval(req.responseText);
            steps.every(function(step) {
                if(step > value) {
                    callback(step);
                    return false;
                }
                return true;
            })
        });
}

function show_badge(project_slug, achievement_slug, id)
{
    var search = window.location.search.substring(1);
    var parts = search.split("=");
    if (!parts[1]) {
        document.getElementById(id).innerHTML = '<img src="css/images/logo.png"><a href="http://api.gameup.co/login?redirect_url=' +
        encodeURIComponent( document.location.href ) +
        '"><button class="btn btn-primary"><i class="icon-white icon-user"></i>Login with GameUP</button></a>';
    } else {
        request('http://api.gameup.co/level/' + project_slug +
            '/' + achievement_slug + '?username=' + parts[1], 'GET',
            function (req) {
                var data = eval(req.responseText);
                var infos = get_steps_info(project_slug, achievement_slug, parts[1], data, function(next_step) {
                        console.log(next_step);
                        document.getElementById(id).innerHTML = '<span style="display: inline-block; background-image: url(img/badges-hex-0003.png); width: 128px; height: 128px; background-size:contain;">' +
                        '<b style="display: inline-block; width: 128px; text-align: center; margin-top: 57px; font-size: 400%; color: white;">' + data + '</b></span><span style="font-size: 200%;">Nombre de parrainages</span>' +
                        '<hr><h1>Progression</h1><progress value="'+data+'" max="'+next_step+'"></progress><p>'+data+'/'+next_step+'</p>' +
                        '<hr><h1>ADMIN site</h1><button class="btn btn-primary"' +
                        ' onClick="plus_one(\''+ project_slug+'\',\''+achievement_slug+'\')">Valider un nouveau parrainage</button>';
                    });
            });
    }
}
