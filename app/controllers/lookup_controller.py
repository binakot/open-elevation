from flask import request, Response
from main import app

APPLICATION_JSON_MIMETYPE = 'application/json;charset=UTF-8'


@app.errorhandler(Exception)
def unhandled_exception(ex):
    return Response(response=traceback.format_exception(etype=type(ex), value=ex, tb=ex.__traceback__),
                    status=500, mimetype=APPLICATION_JSON_MIMETYPE)


@app.route("/api/v1/lookup", methods=['GET'])
def get_lookup():
    result = do_lookup(query_to_locations)
    return Response(result.to_json(), mimetype=APPLICATION_JSON_MIMETYPE)


@app.route("/api/v1/lookup", methods=['POST'])
def post_lookup():
    result = do_lookup(body_to_locations)
    return Response(result.to_json(), mimetype=APPLICATION_JSON_MIMETYPE)


def do_lookup(get_locations_func):
    locations = get_locations_func()
    return {'results': [get_elevation(lat, lng) for (lat, lng) in locations]}


def query_to_locations():
    locations = request.query.locations
    if not locations:
        raise ValueError(json.dumps({'error': '"Locations" is required.'}))

    return [lat_lng_from_location(l) for l in locations.split('|')]


def body_to_locations():
    try:
        locations = request.json.get('locations', None)
    except Exception:
        raise ValueError(json.dumps({'error': 'Invalid JSON.'}))

    if not locations:
        raise ValueError(json.dumps({'error': '"Locations" is required in the body.'}))

    latlng = []
    for l in locations:
        try:
            latlng += [(l['latitude'], l['longitude'])]
        except KeyError:
            raise ValueError(json.dumps({'error': '"%s" is not in a valid format.' % l}))

    return latlng
