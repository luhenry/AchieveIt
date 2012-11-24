function load(host, json_url, template_url, template_id) {
    $.ajax({
        type: 'GET',
        url: host + '/' + json_url,
        success: function(data, textStatus, jqXHR) {
            console.log(data);
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

    if(hash == '') {
        load(host, 'projects.json', 'list_project.html', 'list_project');
    } else {

    }

    // Set the page title based on the hash.
    document.title = 'The hash is ' + ( hash.replace( /^#/, '' ) || 'blank' ) + '.';
})

// Since the event is only triggered when the hash changes, we need to trigger
// the event now, to handle the hash the page may have loaded with.
$(window).hashchange();
