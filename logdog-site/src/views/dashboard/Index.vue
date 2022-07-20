<template>
  <div class="con">
    <a-row :gutter="24">
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '24px' }">
        <a-card :loading="loading" :body-style="{ padding: '20px 24px 8px' }" :bordered="false">
          <a-row >
            <a-col :span="20">
              <div class="chart-card-header">
                <div class="meta"><span class="chart-card-title">接入系统数</span></div>
                <div class="total">
                  <span v-if="querySystems!==null">{{querySystems}}</span>
                  <a-spin v-else></a-spin>
                </div>
              </div>
            </a-col>
            <a-col :span="4">
              <a-icon type="block" class="heard-icon"/>
            </a-col>
          </a-row>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '24px' }">
        <a-card :loading="loading" :body-style="{ padding: '20px 24px 8px' }" :bordered="false">
          <a-row >
            <a-col :span="20">
              <div class="chart-card-header">
                <div class="meta"><span class="chart-card-title">运行时长</span></div>
                <div class="total">
                  <span v-if="runtime!==null">{{runtime||0}}天</span>
                  <a-spin v-else></a-spin>
                </div>
              </div>
            </a-col>
            <a-col :span="4">
              <a-icon type="clock-circle" class="heard-icon head-icon-days"/>
            </a-col>
          </a-row>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '24px' }">
        <a-card :loading="loading" :body-style="{ padding: '20px 24px 8px' }" :bordered="false">
          <a-row >
            <a-col :span="20">
              <div class="chart-card-header">
                <div class="meta"><span class="chart-card-title">日志总数</span></div>
                <div class="total">
                  <span v-if="queryTotalPage!==null">{{queryTotalPage}}</span>
                  <a-spin v-else></a-spin>
                </div>
              </div>
            </a-col>
            <a-col :span="4">
              <a-icon type="copy" class="heard-icon head-icon-page"/>
            </a-col>
          </a-row>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6" :style="{ marginBottom: '24px' }">
        <a-card :loading="loading" :body-style="{ padding: '20px 24px 8px' }" :bordered="false">
          <a-row >
            <a-col :span="20">
              <div class="chart-card-header">
                <div class="meta"><span class="chart-card-title" >总日志大小</span></div>
                <div class="total">
                  <span v-if="queryLogSize!==null">{{queryLogSize}}M</span>
                  <a-spin v-else></a-spin>
                </div>
              </div>
            </a-col>
            <a-col :span="4">
              <a-icon type="database" class="heard-icon head-icon-size"/>
            </a-col>
          </a-row>
        </a-card>
      </a-col>
    </a-row>
    <a-row :gutter="24">
      <a-col :sm="24" :md="12" :xl="18">
        <a-card :loading="loading" :bordered="false" :body-style="{padding: '0'}">
          <div class="salesCard">
            <a-tabs default-active-key="1" size="large" :tab-bar-style="{marginBottom: '24px', paddingLeft: '16px'}">
              <a-tab-pane loading="true" tab="日志类型汇总" key="1">
                <a-row>
                  <div class="example_bar" v-show="!areaStackLoaded">
                    <a-spin size="large"/>
                  </div>
                    <MyAreaStackGradient @loaded="()=>{this.areaStackLoaded=true}"></MyAreaStackGradient>
                </a-row>
              </a-tab-pane>
            </a-tabs>
          </div>
        </a-card>
      </a-col>
      <a-col :sm="24" :md="12" :xl="6">
        <a-card :loading="loading" :bordered="false" :body-style="{padding: '0'}">
          <div class="salesCard">
            <a-tabs default-active-key="1" size="large" :tab-bar-style="{marginBottom: '24px', paddingLeft: '16px'}">
              <a-tab-pane loading="true" tab="应用日志排行榜" key="1">
                <a-row>
                  <div class="example_bar" v-show="!barYCategoryShow">
                    <a-spin size="large"/>
                  </div>
                    <MyBarYCategory @loaded="()=>{this.barYCategoryShow=true}"></MyBarYCategory>
                </a-row>
              </a-tab-pane>
            </a-tabs>
          </div>
        </a-card>
      </a-col>
    </a-row>
  </div>
</template>
<script>
import MyAreaStackGradient from './modules/MyAreaStackGradient'
import MyBarYCategory from './modules/MyBarYCategory'
import {getAction} from "../../api/manage";
export default {
  name: 'Dashboard',
  components: {MyAreaStackGradient,MyBarYCategory},
  data(){
    return{
      url:{
        querySystems:"/logdog/web/querySystems",
        runtime:"/logdog/web/runtime",
        queryTotalPage:"/logdog/web/queryTotalPage",
        queryLogSize:"/logdog/web/queryLogSize"
      },
      areaStackLoaded:false,
      barYCategoryShow:false,
      loading:false,
      querySystems:null,
      runtime:null,
      queryTotalPage:null,
      queryLogSize:null
    }
  },
  methods:{
    getQuerySystems() {
      getAction(this.url.querySystems).then((res) => {
        if (res.success) {
          this.querySystems = res.value
        }else{
          this.$message.warning(res.message)
        }
      })
    },
    getRuntime() {
      getAction(this.url.runtime).then((res) => {
        if (res.success) {
          this.runtime = res.value
        }else{
          this.$message.warning(res.message)
        }
      })
    },
    getQueryTotalPage() {
      getAction(this.url.queryTotalPage).then((res) => {
        if (res.success) {
          this.queryTotalPage = res.value
        }else{
          this.$message.warning(res.message)
        }
      })
    },
    getQueryLogSize() {
      getAction(this.url.queryLogSize).then((res) => {
        if (res.success) {
          this.queryLogSize = res.value
        }else{
          this.$message.warning(res.message)
        }
      })
    }
  },
  created() {
    this.getQuerySystems()
    this.getRuntime()
    this.getQueryTotalPage()
    this.getQueryLogSize()
  }
}
</script>
<style scoped lang="less">
.con-p{
  text-align: center;
  font-size: 16px;
  padding: 10px 0;
}
.con-ul{
  list-style: none;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0;
  margin: 0;
}
.con-ul li{
  padding: 0 10px;
}
.chart-card-header {
  position: relative;
  overflow: hidden;
  width: 100%;
.meta {
  position: relative;
  overflow: hidden;
  width: 100%;
  color: rgba(0, 0, 0, .45);
  font-size: 14px;
  line-height: 22px;
}
}
.total {
  overflow: hidden;
  text-overflow: ellipsis;
  word-break: break-all;
  white-space: nowrap;
  color: #000;
  margin-top: 4px;
  margin-bottom: 0;
  font-size: 30px;
  line-height: 38px;
  height: 38px;
}
.heard-icon {
  color: #58A9FA;
  font-size: 64px;
}
.head-icon-days{
  color: #F7A15E;
}
.head-icon-page{
  color:#74C569;
}
.head-icon-size{
  color:#FD3030;
}
.example_bar{
  text-align: center;
  background: rgba(0, 0, 0, 0.05);
  border-radius: 4px;
  padding: 180px 50px;
  margin: 20px 14px;
  height:500px
}
</style>
