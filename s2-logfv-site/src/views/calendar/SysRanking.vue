<template>
  <a-card :bordered="false" style="height: 100%" :bodyStyle="{height:'100%',display:'flex',flex:1,'flex-direction':'column','padding-bottom':0}">
    <div class="ant-alert ant-alert-info" style="margin-bottom: 16px;">
      <a style="margin-left: 0px">{{myDate}}</a>
    </div>
    <div class="spin_container" v-if="loading">
      <a-spin tip="努力加载中...">
      </a-spin>
    </div>
    <div class="content_container" v-else>
      <a-collapse class="a-collapse" accordion>
        <a-collapse-panel v-for="item in typeData" :key="item.logType">
          <div slot="header">
            <progress class="process-action" max="100" value="70"></progress>
            <div><span>{{item.logType}}：</span><span>{{item.num}}</span></div>
          </div>
          <p>info</p>
        </a-collapse-panel>
      </a-collapse>
    </div>
  </a-card>
</template>

<script>
export default {
  name: "SysRanking",
  data(){
    return {
      loading:false,
      typeData:[],
      url:{
        getCountByGroupByLogType:"/logfv/web/getCountByGroupByLogType"
      }
    }
  },
  computed:{
    myDate(){
      let date = this.$route.params.date
      if(date){
        return date.format('YYYY-MM-DD')
      }else{
        return '-'
      }
    }
  },
  created() {
    if(this.$route.params.typeData){
      this.typeData = Object.keys(this.$route.params.typeData).map(c=>{
        return {
          logType:c,
          num:this.$route.params.typeData[c]
        }
      }).sort((a,b)=>{return b.num-a.num}).filter(c=>c.num)
    }
  }
}
</script>
<style>
:root{
  --process-action-bg: #5193ff;
  --process-page-bg: #5193ff;
  --process-network-bg: #5193ff;
  --process-exception-bg: #5193ff;
  --process-info-bg: #5193ff;
  --process-warn-bg: #5193ff;
  --process-debug-bg: #5193ff;
  --process-error-bg: #5193ff;
  --process-other-bg: #5193ff;
}
</style>
<style scoped>
.content_container{
  height: 100%;
  width: 100%;
  display: flex;
  flex: 1;
  flex-direction: row;
  align-items: start;
  justify-content: center;
}
.spin_container{
  height: 100%;
  width: 100%;
  display: flex;
  flex: 1;
  flex-direction: row;
  align-items: center;
  justify-content: center;
}
.a-collapse{
  width: 100%;
}
progress{
  height: 22px;
  width: 100%;
  margin: 0;
  padding: 0;
  display: block;
  border: 0;
}
progress::-webkit-progress-value{
  border-radius: 4px;
}
progress::-webkit-progress-bar{
  background-color: transparent;
}
.process-action::-webkit-progress-value { background-color: var(--process-action-bg); }
.process-page::-webkit-progress-value { background-color: var(--process-page-bg); }
.process-network::-webkit-progress-value { background-color: var(--process-network-bg); }
.process-exception::-webkit-progress-value { background-color: var(--process-exception-bg); }
.process-info::-webkit-progress-value { background-color: var(--process-info-bg); }
.process-warn::-webkit-progress-value { background-color: var(--process-warn-bg); }
.process-debug::-webkit-progress-value { background-color: var(--process-debug-bg); }
.process-error::-webkit-progress-value { background-color: var(--process-error-bg); }
.process-other::-webkit-progress-value { background-color: var(--process-other-bg); }
</style>
