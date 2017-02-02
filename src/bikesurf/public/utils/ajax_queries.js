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
    $.ajax({
        url: url,
        data: JSON.stringify({
            data: data,
            session_id: 'dummy',
        }),
        method: 'POST',
        success: function(response) {
            response = JSON.parse(response);
            if (!response) {
                error = {
                    type: 'invalid_response',
                    message: 'Error: server returned invalid JSON'
                };
                if (error_callback) {
                    error_callback(error)
                } else {
                    App.error(error);
                }
                return;
            }

            if (!response.ok) {
                console.log(response);
                console.log(response.ok);
                error = {
                    type: 'server_error',
                    data: response.data,
                    message: 'Server error: ' + response.data
                };
                if (error_callback) {
                    error_callback(error)
                } else {
                    App.error(error);
                }
            } else {
                success(response.data);
            }
        },
        error:  function(xhr, error, errorText) {
            App.error({
                type: 'http_error',
                data: error,
                text: errorText,
                message: 'HTTP error ' + error + ': ' + errorText
            });
        }
    });
}
