import Dashboard from './dashboard/Index.vue'
import WebLog from './webLog/Index'
import DateLogDetail from './webLog/DateLogDetail'
import CalendarView from "./calendar/CalendarView"
import SysRanking from "./calendar/SysRanking"
import {util} from "@dpark/s2-utils";
export default util.parseRoutes([
  // 带头部和菜单的布局存放此处
  {
    path: '/logfvSite/dashboard/index',
    name: '@getRoutesName(path)',
    component: Dashboard
  },
  {
    path: '/logfvSite/calendar/index',
    name: '@getRoutesName(path)',
    component: CalendarView
  },
  {
    path: '/logfvSite/calendar/sysRanking',
    name: 'logfvSite_calendar_sysRanking',
    component: SysRanking,
    meta:{
      title: '当日详情',
      keepAlive:true
    }
  },
  {
    path: '/logfvSite/webLog/index',
    name: '@getRoutesName(path)',
    component: WebLog,
  },
  {
    path: '/logfvSite/webLog/dateLogDetail/:deviceId/:deviceName/:logDate/:logType',
    name: '@getRoutesName(path)',
    component: DateLogDetail,
    meta:{
      title:'查看详细'
    },
    props:true
  }
])
