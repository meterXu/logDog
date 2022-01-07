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
      :pagination="pagination"
      @change="handleTableChange"
  >
          <span slot="action" slot-scope="text, record">
            <a @click="logDetail(record)">查看详细</a>
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
          title: '日志分片数',
          align: 'center',
          dataIndex: 'log_page_num'
        },
        {
          title: '操作',
          align: 'center',
          dataIndex: 'action',
          scopedSlots: {customRender: 'action'}
        }
      ],
      innerData:[],
      pagination:{
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
        pageNo: this.pagination.current,
        pageSize: this.pagination.pageSize
      }))
      this.loading = false
      if (res.success) {
        this.innerData = res.value.pageData
        this.pagination.total = res.value.pageInfo.totalCount
      }else {
        this.$message.warning(res.msg)
      }
    },
    handleTableChange(pagination){
      this.pagination.current = pagination.current
      this.pagination.pageSize = pagination.pageSize
      this.loadData()
    },
    logDetail(rowData){
      this.$router.push({ path: `/logfvSite/webLog/dateLogDetail/${rowData.device_id}/${this.record.device_name}/${rowData.log_date}`})
    }
  },
  mounted() {
    this.loadData()
  }
}
</script>

<style scoped>

</style>
