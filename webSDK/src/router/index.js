import Router from 'vue-router'
import index from '../components/Index'
import demo from '../components/Demo'
import test from '../components/Test'
import Vue from "vue";
import Load from "../components/Load";

Vue.use(Router)

const router = new Router({
    mode: 'hash',
    routes: [
        {
            path:'/',
            redirect:'/index'
        },
        {
            path:'/index',
            name:'index',
            component:index
        },
        {
            path:'/demo',
            name:'demo',
            component:demo
        },
        {
            path:'/test',
            name:'test',
            component:test
        },
        {
            path:'/load',
            name:'test',
            component:Load
        }
    ]
})
export default router
