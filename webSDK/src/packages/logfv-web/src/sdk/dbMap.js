import LoganDB from './lib/logan-db';
import { ResultMsg } from './interface';
export var loganDBMap = new Map();
export var getDbInstance = function (config) {
    if (!LoganDB.idbIsSupported()) {
        throw new Error(ResultMsg.DB_NOT_SUPPORT);
    }
    else {
        var dbName = config.get('dbName');
        if (loganDBMap.has(dbName)) {
            return loganDBMap.get(dbName);
        }
        else {
            var LoganDBInstance = new LoganDB(dbName);
            loganDBMap.set(dbName, LoganDBInstance);
            return LoganDBInstance;
        }
    }
};
