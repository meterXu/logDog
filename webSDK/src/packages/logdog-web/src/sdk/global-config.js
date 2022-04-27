var DEFAULT_TRY_TIMES = 3;
var Noop = function () { };
function validOrBackup(param, type, backup) {
    return typeof param === type ? param : backup;
}
var default_1 = /** @class */ (function () {
    function default_1() {
        this.globalConfig = {
            logTryTimes: DEFAULT_TRY_TIMES,
            errorHandler: Noop,
            succHandler: Noop
        };
    }
    default_1.prototype.set = function (configOb) {
        this.globalConfig = {
            publicKey: validOrBackup(configOb.publicKey, 'string', undefined),
            logTryTimes: validOrBackup(configOb.logTryTimes, 'number', DEFAULT_TRY_TIMES),
            reportUrl: validOrBackup(configOb.reportUrl, 'string', undefined),
            dbName: validOrBackup(configOb.dbName, 'string', undefined),
            errorHandler: validOrBackup(configOb.errorHandler, 'function', Noop),
            succHandler: validOrBackup(configOb.succHandler, 'function', Noop),
            reportConfig: validOrBackup(configOb.reportConfig, 'object', null)
        };
    };
    default_1.prototype.get = function (propertyKey) {
        return this.globalConfig[propertyKey];
    };
    return default_1;
}());
export default default_1;
