#def app(env, start_response):
#	query_string = env.get('QUERY_STRING', '')
#	data = '\n'.join(query_string.split('&'))
#	start_response("200 OK", [("Content-Type", "text/plain")])
#	return iter([data.encode()])


def app(environ, start_response):

    data = environ['QUERY_STRING']
    d = [bytes(i + '\n', 'ascii') for i in environ['QUERY_STRING'].split('&')]

    status = '200 OK'
    response_headers = [
        ('Content-type','text/plain'),
        ('Content-Length', str(len(data)))
    ]
    start_response(status, response_headers)
    return d