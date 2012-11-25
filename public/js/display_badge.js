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
                console.log(data);
                var value = data[0];
                var step = data[1];
                console.log(value);
                var infos = get_steps_info(project_slug, achievement_slug, parts[1], value, function (next_step) {
                        request('http://api.gameup.co/leaderboard/' + project_slug + '/' + achievement_slug, 'GET', function (leaderboard) {
                            var l = JSON.parse(leaderboard.responseText);
                            var content =  '<span style="display: inline-block; background-image: url(img/badges-hex-0003.png); width: 128px; height: 128px; background-size:contain;">' +
                            '<b style="display: inline-block; width: 128px; text-align: center; margin-top: 57px; font-size: 400%; color: white;">' + step + '</b></span><span style="font-size: 200%;">Parrainage</span>' +
                            '<progress style="margin-left: 100px; height: 20px;" value="'+value+'" max="'+next_step+'"></progress><b style="margin-left: 20px; font-size: 200%;">'+value+' / '+next_step+' fillots</b>' +
                            '<hr><h1>Leaderboard</h1><table class="table"><thead><tr><td>#</td><td>Username</td><td>Progression</td></tr></thead>';

                            var i = 1;
                            for(user in l) {
                                content += '<tr><td>'+i+'</td><td>' + l[user][0] + '</td><td>' + l[user][1] + '</td></tr>';
                                i += 1;
                            }

                            content += '</table>' +
                            '<hr><h1>ADMIN site</h1><button class="btn btn-primary"' +
                            ' onClick="plus_one(\''+ project_slug+'\',\''+achievement_slug+'\')">Valider un nouveau parrainage</button>';

                            document.getElementById(id).innerHTML = content
                        });
                    });
            });
    }
}
