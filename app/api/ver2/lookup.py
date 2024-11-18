from domain.gdal_interfaces import interface
from flask import Blueprint, request, jsonify

blueprint = Blueprint("lookup_v2", __name__)


@blueprint.errorhandler(Exception)
def unhandled_exception(ex):
    print(ex)
    return jsonify(error=str(ex)), 400


@blueprint.route("/lookup", methods=["GET", "POST"])
def lookup():
    if request.method == "GET":
        result = do_lookup(query_to_locations)
    elif request.method == "POST":
        result = do_lookup(body_to_locations)
    else:
        raise Exception("Method is not supported")
    return jsonify(result)


def do_lookup(get_locations_func):
    locations = get_locations_func()
    return {"results": [get_elevation(lat, lng) for (lat, lng) in locations]}


def query_to_locations():
    locations = request.args.get("locations")
    if not locations:
        raise Exception("Locations is required in the query parameters")

    return [lat_lng_from_location(coords) for coords in locations.split("|")]


def lat_lng_from_location(coords_with_comma):
    try:
        lat, lng = [float(coords) for coords in coords_with_comma.split(",")]
        return lat, lng
    except:
        raise Exception("Bad parameter format '%s'" % coords_with_comma)


def body_to_locations():
    try:
        locations = request.get_json()
    except Exception:
        raise Exception("Invalid JSON")
    if not locations:
        raise Exception("Locations is required in the body")

    latlng = []
    for l in locations:
        try:
            latlng += [(l["latitude"], l["longitude"])]
        except KeyError:
            raise Exception("'%s' is not in a valid format" % l)

    return latlng


def get_elevation(lat, lng):
    try:
        elevation = interface.lookup(lat, lng)
    except:
        return {
            "latitude": lat,
            "longitude": lng,
            "error": "No such coordinate (%s, %s)" % (lat, lng)
        }

    return {
        "latitude": lat,
        "longitude": lng,
        "elevation": elevation
    }
