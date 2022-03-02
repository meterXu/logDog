<template>
  <div class="logList" id="logList">
    <div>
      <a-timeline>
        <a-timeline-item v-for="item in realSource"  :color="item.expand.displayColor" :key="item.id" @click="showDetial(item)">
          <div :style="{ backgroundColor: item.backgroundColor}">
          <div class="log-time-title">
            <div class="log-time-title-left">
              <div class="log-type" :style="{color: item.expand.displayColor}">
                {{item.expand.logTypeName}}
              </div>
              <div class="log-time">{{item.canReadTime}}</div>
            </div>
            <div class="log-time-title-right">
              <div class="log-id">日志ID：{{item.id}}</div>
            </div>
          </div>
          <div class="log-time-content">
            <div class="log-abbr">{{item.simpleContent || item.content}}</div>
          </div>
         </div>
        </a-timeline-item>
      </a-timeline>
    </div>
  </div>
</template>

<script>
import moment from 'moment'
import {mapState} from "vuex";
import {portal} from '@dpark/s2-utils'
import {getDisplay} from "../../../mixins/adapter";
export default {
  name: "LogList",
  props:["source",'indexSource','pr'],
  data(){
    return {
      busy:false,
      count:0,
      res:[
          1,2,3,4,5,6,7,8,9
      ],
      mouseUpRolling:false,
      passiveSupported:false,
      focusLogId:null
    }
  },
  computed:{
    realSource(){
       if(this.source){
         let xx = this.source.filter(c=>getDisplay(c.log_type)).map(c=>{
           if(c.id === this.focusLogId){
             c.backgroundColor = '#e6f7ff'
           }else{
             c.backgroundColor='transparent'
           }
           c.expand = getDisplay(c.log_type)
           if(c.log_time){
             c.canReadTime = moment(c.log_time).format("HH:mm:ss.SSS")
           }else {
             c.canReadTime = ""
           }
           return c
         })
         return  xx;
       }else {
         return []
       }
    },
    ...mapState({
      logMoveDistance:state=>state.biz.logfvSite.logMoveDistance,
      lastLoadMinSpan:state=>state.biz.logfvSite.lastLoadMinSpan
    })
  },
  watch:{
    pr(nv){
      const $listScroll = document.querySelector("#logList");
      let y = $listScroll.scrollHeight * nv;
      $listScroll.scrollTo(0, y);
    },
    source:{
      handler:function(){
        this.rollingListManually(0)
        this.updateHighLightIndex();
      }
    }
  },
  methods:{
    loadMore(){
      this.busy = true;
    },
    rollingListManually(logIndex){
      const $listScroll = document.querySelector("#logList");
      if ($listScroll) {
        let nextScrollTop = logIndex * this.logMoveDistance;
        $listScroll.scrollTo(0, nextScrollTop);
      }
    },
    updateHighLightIndex(){
      if(this.source&&this.indexSource){
        let logHeadAndBottomInView = this.getLogHeadAndBottomInView(this.source, this.indexSource);
        if(logHeadAndBottomInView){
          portal.globalStore.commit("setHighlightStartIndex",logHeadAndBottomInView.startLogIndex)
          portal.globalStore.commit("setHighlightEndIndex",logHeadAndBottomInView.endLogIndex)
        }
      }
    },
    getLogHeadAndBottomInView (logList, logIndexList){
      if(document.querySelector("#logList")){
        let scrollTopOfLogList = document.querySelector("#logList").scrollTop;
        let heightOfView = document.querySelector("#logList").clientHeight;

        let numberOfLogBeforeHead = Math.max(Math.round(scrollTopOfLogList / this.logMoveDistance), 0);//当前第几个
        let numberOfLogInView = Math.round(heightOfView / this.logMoveDistance);//视线里多少个

        if (logList.length > 0 && logIndexList.length > 0) {
          let logHead = logList[Math.min(numberOfLogBeforeHead, logList.length - 1)].id;
          let logBottom = logList[Math.min(numberOfLogBeforeHead + numberOfLogInView, logList.length - 1)].id;

          return {
            startLogIndex: logIndexList.findIndex(logIndexItem => {
              return logIndexItem.id === logHead;
            }),
            endLogIndex: logIndexList.findIndex(logIndexItem => {
              return logIndexItem.id === logBottom;
            })
          };
        } else {
          return {
            startLogIndex: -1,
            endLogIndex: -1
          };
        }
      }

    },
    showDetial(item){
      this.focusLogId = item.id
      this.$emit('showDetialCard',item)
    }
  },
  mounted() {
    document.addEventListener(
        "mousewheel",
        event => {
          if (event.wheelDelta > 0) {
            // 滚动向上
            if (!this.mouseUpRolling) {
              this.mouseUpRolling = true
            }
          } else {
            // 滚动向下
            if (this.mouseUpRolling) {
              this.mouseUpRolling = false
            }
          }
          this.updateHighLightIndex();
        },
        this.passiveSupported ? {passive: true} : false
    );
    if(this.source&&this.source.length>0){
      this.rollingListManually(0)
      this.updateHighLightIndex();
    }
  }
}
</script>

<style scoped lang="less">
.logList{
  overflow-y: auto;
  margin: 0 8px;
  padding: 20px 0px 20px 20px;
  border: 1px solid #d9d9d9;
  border-radius: 5px;
  position: absolute;
  left: 50px;
  top: 0;
  bottom: 24px;
  right: 0;
}
.log-time-title{
  display: flex;
  margin-bottom: 3px;
  justify-content: space-between;
}
.log-time-title-left{
  display: flex;
  position: relative;
  .log-type{
    min-width: 120px;
  }
  .log-time{
    color: #d9d9d9;
    margin-right: 10px;
  }
}
.log-time-title-right{
  display: flex;
  .log-id{
    color: #d9d9d9;
    white-space: nowrap;
    margin-right: 10px;
  }
}
.log-time-content{
  display: flex;
  height: 22px;
  width: 100%;
  .log-abbr{
    flex: 1 1;
    overflow: hidden;
    word-break: break-all;
    margin-right: 10px;
    color: rgba(0,0,0,0.65);
  }
}
</style>
