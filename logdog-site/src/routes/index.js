import routes from '../views/'
import Login from '../views/Login'
import {util} from "@dpark/s2-utils"
export const frameRoutes = util.parseRoutes([
    // 空白布局存放此处
    {
        path: '/logdogSite/login',
        name: '@getRoutesName(path)',
        component: Login
    },
    {
        path: '/logdogSite/blank',
        name: '@getRoutesName(path)',
        component: 'layouts/BlankLayout',
        children: []
    }
])
export default util.parseRoutes([
    {
        'path': '/logdogSite',
        'name': '@getRoutesName(path)',
        'component': 'layouts/RouteView',
        'children': [
            ...routes
        ]
    }
])
