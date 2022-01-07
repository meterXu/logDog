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
        <a-collapse-panel key="1">
          <div slot="header">
            <progress class="process-action" max="100" value="70"></progress>
          </div>
          <p>info</p>
        </a-collapse-panel>
        <a-collapse-panel key="2">
          <div slot="header">
            <progress class="process-page" max="100" value="70"></progress>
          </div>
          <p>warning</p>
        </a-collapse-panel>
        <a-collapse-panel key="3">
          <div slot="header">
            <progress class="process-network" max="100" value="70"></progress>
          </div>
          <p>error</p>
        </a-collapse-panel>
      </a-collapse>
    </div>
  </a-card>
</template>

<script>
export default {
  name: "SysRanking",
  props:["year","month","date"],
  data(){
    return {
      loading:false,
      text:'xxx',

    }
  },
  computed:{
    myDate(){
      let _month=this.month.toString()
      let _date=this.date.toString()
      if(this.month<10){
         _month='0'+_month
       }
       if(this.date<10){
         _date='0'+_date
       }
       return this.year+'-'+_month+'-'+_date
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
