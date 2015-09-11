var diction = {};
var mainWindow;  // id window from main.qml
var fileIO;      // id FileIO from main.qml
var settings = {};    // all settings from setting.txt
var key='trnsl.1.1.20150828T130816Z.de9dcefdd8a0bc15.29b13505bdc8368ae86d607f50a6db43a78a84aa'

//просто не просто мля
String.prototype.format = String.prototype.f = function(){
    var args = arguments;
    return this.replace(/\{(\d+)\}/g, function(m,n){
        return args[n] ? args[n] : m;
    });
};

function getLangs(){
    var xhr = new XMLHttpRequest();
    xhr.open('POST','https://translate.yandex.net/api/v1.5/tr.json/getLangs?key=' + key)
    xhr.onreadystatechange = function(){
        console.log(key)
        console.log(xhr.status, " ", xhr.responseText);
        if(Object.keys(diction).length === 0)
            parseToDict(xhr.responseText);
    }
    xhr.send();
}

function getString(){
    return string;
}

function parseToDict(string){
    var inic = JSON.parse(readFile("/home/ssr/Документы/iso_country.txt"));
    JSON.parse(string).dirs.forEach(function(directionTransl, index, array){
        var stringContend = directionTransl.split("-");
        if(diction[stringContend[0]] === undefined){
            diction[stringContend[0]] = {name: inic[stringContend[0]], directions: []};
            diction[stringContend[0]].directions.push(stringContend[1]);
        } else {
            diction[stringContend[0]].directions.push(stringContend[1]);
        }
    });
    mainWindow.setComboxModel(diction);
}
function getDict(){
    return diction;
}

function synchronization(idMainWindow, idFileIO){
    mainWindow = idMainWindow;
    fileIO = idFileIO;
    loadSettings();
    getLangs();
}

function tranlate(toTranslate, directionTranslate){
    console.log(toTranslate);
    var xhr = new XMLHttpRequest();
    var req = 'https://translate.yandex.net/api/v1.5/tr.json/translate?' +
            'key={0}&text={1}&lang={2}&[format={3}]&[option={4}]'.f(
                key,
                toTranslate,
                directionTranslate,
                "plain",
                "1")
    console.log(req);
    xhr.open('POST', req)
    xhr.onreadystatechange = function(){
        console.log(xhr.status, " - ", xhr.responseText);
        var text = JSON.parse(xhr.responseText);
        console.log(text.text)
        mainWindow.setTranslateText(text.text[0]);
    }
    xhr.send();
}

function getByFullName(fullName){
    for(var isoName in diction){
        if(diction[isoName].name === fullName){
            return isoName;
        }
    }
}

function readFile(path){
    file.source = path;
    return file.read();
}

function writeFile(data){
    file.write(data);
}

function loadSettings(){
    var strsSettings = readFile("/home/ssr/Qt_project/Translate/setting.txt").split("\n")
    strsSettings.forEach(function(current){
        console.log(current);
        var string = current.split("=");
        settings[string[0]] = string[1];
        console.log(string[0], ' - ', string[1])
    })
    if(settings.key !== undefined)
        key = settings.key;
}

