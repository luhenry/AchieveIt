function load(json_url, template_url, template_id, additionnal_data) {
    // Private key do not use
    var key = '7he4NxmyZ6abHSyqPT4r';

    $.ajax({
        type: 'GET',
        url: json_url + '?auth_token=' + key,
        statusCode: {
            401: function() {
                location.href = 'developers/sign_in';
            }
        },
        success: function(json_data, textStatus, jqXHR) {
            var data = {
                data: json_data
            }
            $.extend(data, additionnal_data);
            console.log(data);
            load_template(template_url, data, template_id);
        }
    })
}

function load_template(template_url, data, template_id) {
    $.Mustache.load('templates/' + template_url).done(function () {
            $('#main_container').mustache(template_id, data);
        });
}

// Bind an event to window.onhashchange that, when the hash changes, gets the
// hash and adds the class "selected" to any matching nav link.
$(window).hashchange( function(){
    var hash = location.hash;

    var parts = hash.split('/')
    console.log(parts);

    // Clear main container
    $('#main_container').empty();

    if(hash == '') {
        load('projects', 'list_project.html', 'list_project', {});
    } else if (parts[0] == '#project') {
        if (parts[1] == 'show' && parts[2]) {
            load('achievements/' + parts[2], 'list_achievement.html', 'list_achievement', {project_slug: parts[2]});
        } else if (parts[1] == 'new') {
            load_template('create_project.html', {}, 'create_project')
        }
    } else if (parts[0] == '#achievement') {
        if (parts[1] == 'show' && parts[2] && parts[3]) {
            load('steps/' + parts[2] + '/' + parts[3], 'list_steps.html', 'list_steps');
        }
    }
})

// Since the event is only triggered when the hash changes, we need to trigger
// the event now, to handle the hash the page may have loaded with.
$(window).hashchange();
