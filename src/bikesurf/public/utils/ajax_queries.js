(function() {
    App.error = function(error) {
        var message;
        if (typeof(error) == 'string') {
            message = error;
        } else {
            message = error.message;
        }

        alert('Error: ' + message);
    }

    App.request = function(url, data, success, error_callback) {
        var throw_error = function(error) {
            if (error_callback) {
                error_callback(error)
            } else {
                App.error(error);
            }
        };

        var inspect_response = function(response_text) {
            response = JSON.parse(response_text);
            if (!response) {
                throw_error({
                    type: 'invalid_response',
                    text: response_text,
                    message: 'Error: server returned invalid JSON: ' + response_text
                });
                return;
            }

            if (!response.ok) {
                throw_error({
                    type: 'server_error',
                    data: response.data,
                    message: 'Server error: ' + response.data
                });
            } else {
                success(response.data);
            }
        };

        $.ajax({
            url: '/api/' + url,     // fixme: remove leading slash when router works
            data: JSON.stringify({
                data: data,
                session_id: 'dummy',
            }),
            method: 'POST',
            beforeSend: function(request) {
                request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
            },
            success: inspect_response,
            error:  function(xhr, error, errorText) {
                if (!xhr.responseText) {
                    throw_error({
                        type: 'http_error',
                        data: error,
                        text: errorText,
                        message: 'HTTP error ' + error + ': ' + errorText
                    });
                } else {
                    inspect_response(xhr.responseText);
                }
            }
        });
    }

    App.image_url = function(image) {
        return 'image/' + image.filename;
    };
})();
