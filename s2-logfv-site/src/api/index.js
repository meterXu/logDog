import { getActionSSO } from './manage'
import {util} from "@dpark/s2-utils"

export function staticPermission() {
    return {
        menu: util.parseRoutes([
            {
                path: '/logfvSite/dashboard/index',
                name: '@getRoutesName(path)',
                meta: {
                    icon:'dashboard',
                    title: '仪表盘'
                }
            },
            {
                path: '/logfvSite/calendar/index',
                name: '@getRoutesName(path)',
                meta: {
                    icon:'DoCalendar',
                    title: '日历视图'
                }
            },
            {
                path: '/logfvSite/webLog/index',
                name: '@getRoutesName(path)',
                meta: {
                    icon:'search',
                    title: '日志查询',
                    keepAlive:true
                }
            }
        ])
    }
}

// 字典标签专用（通过code获取字典数组）
export const ajaxGetDictItems = (code, params) => getActionSSO(`/sys/dict/getDictItems/${code}`, params)
