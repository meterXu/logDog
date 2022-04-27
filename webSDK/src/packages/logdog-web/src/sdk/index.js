var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
import { LogEncryptMode } from './interface';
import saveLogModule from './save-log';
import reportLogModule from './report-log';
import Config from './global-config';
import { isValidDay } from './lib/utils';
import { ResultMsg } from './interface';
import LogManager from './log-manager';
var ES6Promise = require('es6-promise');
if (!window.Promise) {
    window.Promise = ES6Promise;
}
var logQueueBeforeLoad = new Map();
function logContentWrapper(content, logType, config) {
    var environment, customInfo, webSource;
    var reportConfig = config.get('reportConfig');
    if (reportConfig) {
        environment = reportConfig.environment ? reportConfig.environment() : '';
        customInfo = reportConfig.customInfo ? reportConfig.customInfo() : '';
        webSource = reportConfig.webSource ? reportConfig.webSource() : '';
    }
    var logOb = {
        t: logType,
        c: "" + encodeURIComponent(content),
        d: "" + Date.now(),
        e: "" + environment,
        i: "" + customInfo,
        s: "" + webSource
    };
    return JSON.stringify(logOb);
}
function reportParamChecker(reportConfig) {
    if (!reportConfig) {
        throw new Error('reportConfig needs to be an object');
    }
    var dayFormatDesc = 'is not valid, needs to be YYYY-MM-DD format';
    if (!isValidDay(reportConfig.fromDayString)) {
        throw new Error("fromDayString " + dayFormatDesc);
    }
    if (!isValidDay(reportConfig.toDayString)) {
        throw new Error("toDayString " + dayFormatDesc);
    }
    if (reportConfig.fromDayString > reportConfig.toDayString) {
        throw new Error('fromDayString needs to be no bigger than toDayString');
    }
}
function logParamChecker(logType, encryptVersion) {
    if (typeof logType !== 'string') {
        throw new Error('logType needs to be set');
    }
    if (encryptVersion === LogEncryptMode.RSA) {
        var config = new Config();
        if (!config.get('publicKey')) {
            throw new Error('publicKey needs to be set before logWithEncryption');
        }
    }
}
var Logan = /** @class */ (function () {
    function Logan() {
    }
    Logan.prototype.initConfig = function (globalConfig) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                this.config = new Config();
                this.config.set(globalConfig);
                this.logManager = new LogManager(this.config);
                logQueueBeforeLoad.forEach(function (value, key) {
                    value.logan.logAsync(value.logItem);
                });
                logQueueBeforeLoad.clear();
                return [2 /*return*/];
            });
        });
    };
    Logan.prototype.log = function (content, logType) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.standardLog(content, logType, LogEncryptMode.PLAIN)];
                    case 1:
                        _a.sent();
                        return [2 /*return*/];
                }
            });
        });
    };
    Logan.prototype.logWithEncryption = function (content, logType) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.standardLog(content, logType, LogEncryptMode.RSA)];
                    case 1:
                        _a.sent();
                        return [2 /*return*/];
                }
            });
        });
    };
    Logan.prototype.standardLog = function (content, logType, encryptVersion) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        try {
                            logParamChecker(logType, LogEncryptMode.PLAIN);
                        }
                        catch (e) {
                            this.config.get('errorHandler')(e);
                        }
                        return [4 /*yield*/, this.logIfLoaded({
                                logContent: logContentWrapper(content, logType, this.config),
                                encryptVersion: encryptVersion
                            })];
                    case 1:
                        _a.sent();
                        return [2 /*return*/];
                }
            });
        });
    };
    Logan.prototype.logIfLoaded = function (logItem) {
        return __awaiter(this, void 0, void 0, function () {
            var reportConfig;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (!(!document.readyState ||
                            (document.readyState && document.readyState === 'complete'))) return [3 /*break*/, 2];
                        return [4 /*yield*/, this.logAsync(logItem)];
                    case 1:
                        _a.sent();
                        return [3 /*break*/, 3];
                    case 2:
                        reportConfig = this.config.get('reportConfig');
                        logQueueBeforeLoad.set(reportConfig.deviceId, {
                            logan: this,
                            logItem: logItem
                        });
                        _a.label = 3;
                    case 3: return [2 /*return*/];
                }
            });
        });
    };
    Logan.prototype.logAsync = function (logItem) {
        return __awaiter(this, void 0, void 0, function () {
            var e_1;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (!this.logManager.canSave()) return [3 /*break*/, 6];
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, 3, , 5]);
                        return [4 /*yield*/, saveLogModule(logItem, this.config, this.logManager)];
                    case 2:
                        _a.sent();
                        return [3 /*break*/, 5];
                    case 3:
                        e_1 = _a.sent();
                        this.logManager.errorTrigger();
                        return [4 /*yield*/, this.config.get('errorHandler')(e_1)];
                    case 4:
                        _a.sent();
                        return [3 /*break*/, 5];
                    case 5: return [3 /*break*/, 8];
                    case 6: return [4 /*yield*/, this.config.get('errorHandler')(new Error(ResultMsg.EXCEED_TRY_TIMES))];
                    case 7:
                        _a.sent();
                        _a.label = 8;
                    case 8: return [2 /*return*/];
                }
            });
        });
    };
    Logan.prototype.report = function (reportConfig) {
        reportParamChecker(reportConfig);
        return reportLogModule(reportConfig, this.config);
    };
    Logan.prototype.customLog = function (logConfig) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.logIfLoaded({
                            logContent: logConfig.logContent,
                            encryptVersion: logConfig.encryptVersion
                        })];
                    case 1:
                        _a.sent();
                        return [2 /*return*/];
                }
            });
        });
    };
    return Logan;
}());
export default Logan;
