<template>
  <a-table
      class="child-table"
      slot="expandedRowRender"
      slot-scope="text,record"
      :bordered="false"
      rowKey="log_date"
      :loading="loading"
      :columns="innerColumns"
      :data-source="innerData"
      :pagination="ipagination"
      @change="handleTableChange"
  >
          <span slot="action" slot-scope="text, record">
            <a @click="logDetail(record)">查看详情</a>
          </span>
  </a-table>
</template>

<script>
import moment from "moment";
import {getAction} from "../../../api/manage";

export default {
  name: "ExpandTable",
  props:["record","dateRange"],
  data(){
    return {
      innerColumns: [
        {
          title: '记录日期',
          align: 'left',
          width: 300,
          dataIndex: 'log_date',
          customRender: (text, record, index) => {
            return {
              children: moment(text).format('YYYY-MM-DD'),
              attrs: {}
            }
          }
        },
        {
          title: '日志数',
          align: 'center',
          dataIndex: 'log_count'
        },
        {
          title: '操作',
          align: 'center',
          dataIndex: 'action',
          scopedSlots: {customRender: 'action'}
        }
      ],
      innerData:[],
      ipagination:{
        current:1,
        pageSize:10,
        position:"top",
        showLessItems:true,
        showSizeChanger: true,
        size:"small",
        total:0,
        pageSizeOptions: ['10', '30', '60'],
        showTotal: (total, range) => {
          return range[0] + '-' + range[1] + ' 共' + total + '条'
        }
      },
      url:{
        queryTaskByDate: '/logfv/web/queryTaskByDate',
      },
      loading:true,
      queryParam:{
        deviceId:"",
        startDate:"",
        endDate:""
      }
    }
  },
  watch:{
    dateRange(){
      this.loadData()
    }
  },
  methods:{
    fmtDateRang(){
      if(this.dateRange.length>=2){
        this.queryParam.startDate = this.dateRange[0]
        this.queryParam.endDate = this.dateRange[1]
      }else{
        this.queryParam.startDate=""
        this.queryParam.endDate=""
      }
    },
    async loadData() {
      this.loading = true
      this.fmtDateRang()
      this.queryParam.deviceId=this.record.device_id
      let res = await getAction(this.url.queryTaskByDate, Object.assign(this.queryParam,{
        pageNo: this.ipagination.current,
        pageSize: this.ipagination.pageSize
      }))
      this.loading = false
      if (res.success) {
        this.innerData = res.value.pageData
        this.ipagination.total = res.value.pageInfo.totalCount
      }else {
        this.$message.warning(res.msg)
      }
    },
    handleTableChange(ipagination){
      this.ipagination.current = ipagination.current
      this.ipagination.pageSize = ipagination.pageSize
      this.loadData()
    },
    logDetail(rowData){
      this.$router.push({
        name:'logfvSite_webLog_dateLogDetail',
        params:{
          deviceId:rowData.device_id,
          deviceName:this.record.device_name,
          logDate:rowData.log_date,
          logType:0
        },
        query:{
          meta:{
            title:`详情_${this.record.device_name}_${moment(parseInt(rowData.log_date)).format('YYYY-MM-DD')}`
          }
        }
      })
    }
  },
  mounted() {
    this.loadData()
  }
}
</script>

<style scoped>

</style>
