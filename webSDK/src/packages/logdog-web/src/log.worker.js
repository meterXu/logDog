// eslint-disable-next-line no-undef
self.onmessage = function (e) {
    switch (e.data.command){
        case 'exec':{
            notifyReport(e.data.id,e.data.interval*1000)
        }break;
        default:break;
    }
};


function notifyReport(id,interval){
    // eslint-disable-next-line no-undef
    self.postMessage({ command: "report", id:id });
    setTimeout(function (){
        notifyReport(id,interval)
    },interval)
}
