var default_1 = /** @class */ (function () {
    function default_1(config) {
        this.logTryQuota = config.get('logTryTimes');
        this.config = config;
    }
    default_1.prototype.errorTrigger = function () {
        if (this.logTryQuota > 0) {
            this.logTryQuota--;
        }
    };
    default_1.prototype.canSave = function () {
        return this.logTryQuota > 0;
    };
    default_1.prototype.resetQuota = function () {
        this.logTryQuota = this.config.get('logTryTimes');
    };
    return default_1;
}());
export default default_1;
