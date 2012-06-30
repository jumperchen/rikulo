//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, May 9, 2012  10:09:12 AM
// Author: henrichen

/**
 * A Cordova camera implementation.
 */
class CordovaCamera implements Camera {
  static final String _GET_PICTURE = "camera.getPicture";
  CordovaCamera() {
    _initJSFunctions();
  }
  
  void getPicture(CameraSuccessCallback success, CameraErrorCallback error, [CameraOptions options]) {
    jsCall(_GET_PICTURE, [success, error, toJSMap(_toMap(options))]);
  }
  
  Map _toMap(CameraOptions opts) {
    Map map = new Map();
    if (opts !== null) {
      if (opts.quality !== null) map["quality"] = opts.quality; //The picture quality(0 ~ 100)
      if (opts.destinationType !== null) map["destinationType"] = opts.destinationType; //The picture format(DestinationType)
      if (opts.sourceType !== null) map["sourceType"] = opts.sourceType; //The picture source(PictureSourceType).
      if (opts.allowEdit !== null) map["allowEdit"] = opts.allowEdit; //Whether allows simple editing before selection
      if (opts.encodingType !== null) map["encodingType"] = opts.encodingType; //The encoding format(EncodingType)
      if (opts.targetWidth !== null) map["targetWidth"] = opts.targetWidth; //Width in pixels (retain scale ratio)
      if (opts.targetHeight !== null) map["targetHeight"] = opts.targetHeight; //Height in pixels (retain scale ratio)
      if (opts.mediaType !== null) map["mediaType"] = opts.mediaType; //Media type(MediaType). Only when sourceType is PHOTOLIBRARY or SAVEDPHOTOALBUM 
      if (opts.correctOrientation !== null) map["correctOrientation"] = opts.correctOrientation; //Whether rotate the image to correct the orientation
      if (opts.saveToPhotoAlbum !== null) map["saveToPhotoAlbum"] = opts.saveToPhotoAlbum; //Whether save the image to photo album after capture
    }
    return map;
  }
  
  void _initJSFunctions() {
    newJSFunction(_GET_PICTURE, ["onSuccess", "onError", "opts"], '''
      var fnSuccess = function(data) {onSuccess.\$call\$1(data);},
          fnError = function(meg) {onError.\$call\$1(msg);};
      navigator.camera.getPicture(fnSuccess, fnError, opts);
    ''');
  }
}
