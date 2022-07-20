<template>
  <a-card :bordered="false" style="height: 100%" :bodyStyle="{height:'100%',display:'flex',flex:1,'flex-direction':'column','padding-bottom':0}">
    <div class="ant-alert ant-alert-info" style="margin-bottom: 16px;">
      <a style="margin-left: 0px">日期：{{myDate}}</a>
    </div>
    <div class="spin_container" v-if="loading">
      <a-spin tip="努力加载中...">
      </a-spin>
    </div>
    <div class="content_container" v-else>
      <a-collapse class="a-collapse" accordion>
        <a-collapse-panel v-for="item in dayData" :key="item.log_type">
          <div slot="header">
            <div class="progress-bar">
              <div class="progress-value" :style="getProgressStyle(item)"></div>
              <div class="progress-text">
                <span>{{item.log_typeName}}：</span>
                <span>{{item.num}}条</span>
              </div>
            </div>
          </div>
          <p>
            <SysDayTypeTable :dateTime="dateTime" :logType="item.log_type"></SysDayTypeTable>
          </p>
        </a-collapse-panel>
      </a-collapse>
    </div>
  </a-card>
</template>

<script>
import {webLogTypeConfigs} from '../../mixins/logtypes'
import SysDayTypeTable from "./modules/SysDayTypeTable";
import moment from "moment";
import {getAction} from "../../api/manage";
export default {
  name: "SysRanking",
  components: {SysDayTypeTable},
  props:["timestamp"],
  data(){
    return {
      loading:false,
      dateTime:null,
      dayData:[],
      url:{
        getDayLogType:"/logdog/web/getDayLogType",
        getCountByGroupByLogType:"/logdog/web/getCountByGroupByLogType"
      }
    }
  },
  computed:{
    myDate(){
      if(this.dateTime){
        return this.dateTime.format('YYYY-MM-DD')
      }
      else{
        return '-'
      }
    }
  },
  methods:{
    getProgressStyle(item) {
      let max = this.dayData[0].num
      let width = (item.num/max)*100
      return {backgroundColor:item.display_color,width:`${width}%`}
    },
    setTitleStyle(){
      let els = document.getElementsByClassName('progress-value')
      for(let i=0;i<els.length;i++){
        if(els[i].offsetWidth<150){
          document.getElementsByClassName('progress-text')[i].setAttribute('style','color:#5c5c5c')
        }
      }
    },
    getDayData(){
      if(this.dateTime){
        getAction(this.url.getDayLogType,{
          year:this.dateTime.get('year'),
          month:this.dateTime.get('month')+1,
          day:this.dateTime.get('date')
        }).then(res=>{
          this.dayData = res.value.map(c=>{
            let logType = webLogTypeConfigs.find(w=>w.logType===c.log_type)
            let otherType = webLogTypeConfigs.find(w=>w.logType==='other')
            if(logType){
              return {
                log_type:c.log_type,
                log_typeName:logType.logTypeName,
                display_color:logType.displayColor,
                num:c.num
              }
            }else{
              return {
                log_type:c.log_type,
                log_typeName:c.log_type,
                display_color:otherType.displayColor,
                num:c.num
              }
            }
          })
          this.$nextTick(()=>{
            this.setTitleStyle()
          })
        })
      }
    }
  },
  created() {
    if(this.timestamp){
      this.dateTime = new moment(parseInt(this.timestamp))
    }
    this.getDayData()
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
