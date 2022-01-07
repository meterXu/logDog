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
            <div class="progress-bar">
              <div class="progress-value" :style="getProgressStyle(item)"></div>
              <div class="progress-text" :style="getTitleStyle(item)">
                <span>{{item.logTitle}}：</span>
                <span>{{item.num}}</span>
              </div>
            </div>
          </div>
          <p>info</p>
        </a-collapse-panel>
      </a-collapse>
    </div>
  </a-card>
</template>

<script>
import {webLogTypeConfigs} from '../../mixins/logtypes'
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
        let webLogType = webLogTypeConfigs.find(t=>t.logType===c)
        return {
          logTitle:webLogType?webLogType.logTypeName:'-',
          logColor:webLogType?webLogType.displayColor:null,
          logType:c,
          num:this.$route.params.typeData[c]
        }
      }).sort((a,b)=>{return b.num-a.num}).filter(c=>c.num)
    }
  },
  methods:{
    getProgressStyle(item) {
      let max = this.typeData[0].num
      let width = (item.num/max)*100
      return {backgroundColor:item.logColor,width:`${width}%`}
    },
    getTitleStyle(item){
      let max = this.typeData[0].num
      let width = (item.num/max)
      if(width<0.1){
        return {color:'#5c5c5c'}
      }else{
        return  {color:'#fff'}
      }
    }
  }
}
</script>
<style>
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
.progress-bar{
  height: 28px;
  width: 100%;
  margin: 0;
  padding: 0;
  display: block;
  border: 0;
}
.progress-value{
  width: 70%;
  height: 100%;
  border-radius: 4px;
}
.progress-text{
  top: -28px;
  position: relative;
  color: #fff;
  line-height: 28px;
  text-indent: 12px;
}
</style>
