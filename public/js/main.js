function load(host, json_url, template_url, template_id) {
    $.ajax({
        type: 'GET',
        url: host + '/' + json_url,
        success: function(json_data, textStatus, jqXHR) {
            console.log(json_data);
            var data = {
                host: host,
                data: json_data
            }
            $.Mustache.load(host + '/templates/' + template_url).done(function () {
                    $('#main_container').mustache(template_id, data);
                });
        }
    })
}

// Bind an event to window.onhashchange that, when the hash changes, gets the
// hash and adds the class "selected" to any matching nav link.
$(window).hashchange( function(){
    var hash = location.hash;

    var host = 'http://localhost:3000';

    var parts = hash.split('/')
    console.log(parts);

    // Clear main container
    $('#main_container').empty();

    if(hash == '') {
        load(host, 'projects.json', 'list_project.html', 'list_project');
    } else if (parts[0] == '#project') {
        if (parts[1]) {
            load(host, 'achievements/' + parts[1] + '.json', 'list_achievement.html', 'list_achievement');
        }

    }
})

// Since the event is only triggered when the hash changes, we need to trigger
// the event now, to handle the hash the page may have loaded with.
$(window).hashchange();
