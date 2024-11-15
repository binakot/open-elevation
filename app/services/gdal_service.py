from utils.gdal_utils import GDALTileInterface

interface = GDALTileInterface("/app/data/", "/app/data/summary.json", 8)

if interface.has_summary_json():
    print('Re-using existing summary JSON')
    interface.read_summary_json()
else:
    print('Creating summary JSON ...')
    interface.create_summary_json()


def get_elevation(lat, lng):
    try:
        elevation = interface.lookup(lat, lng)
    except:
        return {
            'latitude': lat,
            'longitude': lng,
            'error': 'No such coordinate (%s, %s)' % (lat, lng)
        }

    return {
        'latitude': lat,
        'longitude': lng,
        'elevation': elevation
    }


def lat_lng_from_location(location_with_comma):
    try:
        lat, lng = [float(i) for i in location_with_comma.split(',')]
        return lat, lng
    except:
        raise ValueError(json.dumps({'error': 'Bad parameter format "%s".' % location_with_comma}))
