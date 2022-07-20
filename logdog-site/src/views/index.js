import Dashboard from './dashboard/Index.vue'
import WebLog from './webLog/Index'
import DateLogDetail from './webLog/DateLogDetail'
import CalendarView from "./calendar/CalendarView"
import SysRanking from "./calendar/SysRanking"
import {util} from "@dpark/s2-utils";
export default util.parseRoutes([
  // 带头部和菜单的布局存放此处
  {
    path: '/logdogSite/dashboard/index',
    name: '@getRoutesName(path)',
    component: Dashboard
  },
  {
    path: '/logdogSite/calendar/index',
    name: '@getRoutesName(path)',
    component: CalendarView
  },
  {
    path: '/logdogSite/calendar/sysRanking/:timestamp',
    name: 'logdogSite_calendar_sysRanking',
    component: SysRanking,
    meta:{
      title: '当日详情',
      keepAlive:false
    },
    props: true
  },
  {
    path: '/logdogSite/webLog/index',
    name: '@getRoutesName(path)',
    component: WebLog,
  },
  {
    path: '/logdogSite/webLog/dateLogDetail/:deviceId/:deviceName/:logDate/:logType',
    name: 'logdogSite_webLog_dateLogDetail',
    component: DateLogDetail,
    meta:{
      title:'查看详情',
      keepAlive:false
    },
    props:true
  }
])
