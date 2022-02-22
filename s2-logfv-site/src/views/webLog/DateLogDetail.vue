<template>
  <a-card :bordered="false" style="height: 100%" :bodyStyle="{height:'100%',overflow: 'hidden'}">
    <div class="ant-alert ant-alert-info" style="margin-bottom: 16px;">
      <a style="margin-left: 0px">{{deviceName}}：{{date}}</a>
    </div>
    <FilterBar :webLogTypes="webLogTypes" :logType="logType" @search="search"></FilterBar>
    <div class="spin_container" v-if="loading">
      <a-spin tip="努力加载中...">
      </a-spin>
    </div>
    <div class="content_container" v-else>
      <template v-if="dateLogIndexData&&dateLogIndexData.length>0">
        <div class="content">
          <TimeMiniMap :source="dateLogIndexData" :startIndex="highlightStartIndex" :endIndex="highlightEndIndex" @onLocatorMove="locatorMove"></TimeMiniMap>
          <LogList :source="logListData" :pr="pr" :indexSource="dateLogIndexData" @showDetialCard="showDetialCard" :style="{right:logDetail?'50%':0}"></LogList>
          <LogDetailCard v-if="logDetail" :logDetail.sync="logDetail"></LogDetailCard>
        </div>
        <a-pagination class="pagination" :showSizeChanger="pagination.showSizeChanger"
                      :pageSizeOptions="pagination.pageSizeOptions"
                      :pageSize="pagination.pageSize"
                      :current="pagination.pageNo"
                      :total="pagination.total"
                      :size="pagination.size"
                      :showTotal="pagination.showTotal"
                      @change="onChange"
                      @showSizeChange="onChange"/>
      </template>
     <template v-else>
       <div class="noData">
         <a-result title="抱歉，没有任何数据！">
         </a-result>
       </div>
     </template>
    </div>
  </a-card>
</template>

<script>
import FilterBar from './modules/FilterBar'
import TimeMiniMap from "./modules/TimeMiniMap";
import LogList from './modules/LogList'
import {mapState} from 'vuex';
import {getAction} from '../../api/manage'
import {convertToMinimap} from '../../mixins/adapter'
import LogDetailCard from "./modules/LogDetailCard";
import moment from 'moment'
export default {
  name: "DateLogDetial",
  props:["deviceId","deviceName","logDate",'logType'],
  components:{LogDetailCard, FilterBar,TimeMiniMap,LogList},
  data(){
    return {
      dateLogIndexData:null,
      logListData:null,
      webLogTypes:null,
      focusLogId:null,
      loading:true,
      url:{
        dateLogIndex:'/logfv/web/dateLogIndex',
        dateLogDetails:'/logfv/web/dateLogDetails'
      },
      pr:0,
      logDetail:null,
      queryParam:{
        content:"",
        logType:"",
        logOrder:"",
        startTime:"",
        endTime:""
      },
      pagination:{
        pageNo:1,
        pageSize:200,
        pageSizeOptions:['100', '200', '500'],
        showSizeChanger:true,
        size:"normal",
        showTotal: (total, range) => {
          return range[0] + '-' + range[1] + ' 共' + total + '条'
        },
        total:0
      }
    }
  },
  computed:{
    ...mapState({
      highlightStartIndex:state=>state.biz.logfvSite.highlightStartIndex,
      highlightEndIndex:state=>state.biz.logfvSite.highlightEndIndex
    }),
    date(){
      return moment(parseInt(this.logDate)).format('YYYY-MM-DD')
    }
  },
  methods:{
    getDataLogIndexData(params){
      params = Object.assign(params,{
        deviceId:this.deviceId,
        logDate:this.logDate
      },{
        pageNo:this.pagination.pageNo,
        pageSize:this.pagination.pageSize
      })
      this.loading=true
      getAction(this.url.dateLogIndex,params).then(res=>{
        if (res.success) {
          let ctm = convertToMinimap(res.value.pageData)
          this.dateLogIndexData = ctm.ret
          this.webLogTypes= ctm.webLogTypes
          this.logListData = res.value.pageData
          this.pagination.total = res.value.pageInfo.totalCount
        }else{
          this.$message.warning(res.msg)
        }
      }).finally(()=>{
        this.loading = false
      })
    },
    onChange(pageNumber,pageSize) {
      this.pagination.pageNo = pageNumber
      this.pagination.pageSize = pageSize
      this.getDataLogIndexData()
    },
    locatorMove(pr){
      this.pr = pr
    },
    updateFocusLogId(id){
      this.focusLogId=id
    },
    showDetialCard(item){
      this.logDetail = item
    },
    search(queryParam){
      let params = Object.assign(this.queryParam,queryParam)
      if(params.logType=='0'||params.logType.length===0){
        params.logType=''
      }else{
        params.logType=params.logType.toString()
      }
      params.startTime=new Date( `${this.date} ${queryParam.startHour}:00:00`).valueOf()
      params.endTime=new Date( `${this.date} ${queryParam.endHour}:00:00`).valueOf()
      this.getDataLogIndexData(params)
    }
  },
  mounted() {
    this.search({
      logType:this.logType,
      startHour:0,
      endHour:24
    })
  },
}
</script>

<style scoped>
.content_container{
  height: 630px;
  width: 100%;
  display: flex;
  flex: 1;
  flex-direction: column;
  align-items: flex-end;
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
.content{
  height: 100%;
  width: 100%;
  position: relative;
}
.noData{
  width: 100%;
  text-align: center;
}
.pagination {
  margin-bottom: 20px;
  display: flex;
  justify-content: flex-end;
}
.title{
  margin-bottom: 16px;
}
</style>
