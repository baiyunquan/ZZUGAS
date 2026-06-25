function getPathObjectId(path) {
    if(!path || path.length === 0){
        return "";
    }
    var arr = path.split("/");
    if(arr.length < 1){
        return "";
    }
    var objectId;
    if(path.indexOf("star4") > -1 && arr.length > 1){
        objectId = arr[arr.length - 2];
    }else {
        objectId = arr[arr.length - 1];
        if (objectId.indexOf(".") > -1) {
            objectId = objectId.split(".")[0];
        }
    }
    if(isValidObjectId(objectId)){
        return objectId;
    }else {
        return "";
    }
}

function isValidObjectId(objectId) {
    return typeof objectId != 'undefined' && (objectId.length === 32 || objectId.length === 24);
}