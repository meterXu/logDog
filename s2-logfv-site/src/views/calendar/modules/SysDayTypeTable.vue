<template>
  <a-table class="child-table"
           slot="expandedRowRender"
           slot-scope="text,record"
           :bordered="false"
           rowKey="device_id"
           :loading="loading"
           :columns="columns"
           :data-source="dataSource"
           :pagination="ipagination"
           @change="handleTableChange">
            <span slot="tags" slot-scope="type">
              <a-tag v-if="type===2"  color="green">组件</a-tag>
              <a-tag v-else  color="blue">系统</a-tag>
            </span>
          <span slot="action" slot-scope="text, record">
            <a @click="logDetail(record)">查看详细</a>
          </span>
  </a-table>
</template>

<script>
import {JeecgListMixin} from '../../../mixins/JeecgListMixin'
import {getAction} from "../../../api/manage";
import moment from "moment";
export default {
  name: "SysDayTypeTable",
  mixins:[JeecgListMixin],
  props:["datetime","logType"],
  data(){
    return {
      columns:[
        {
          title: '应用标识',
          align: 'left',
          width: 300,
          dataIndex: 'device_id'
        },
        {
          title: '应用名称',
          align: 'center',
          dataIndex: 'device_name'
        },
        {
          title: '应用类别',
          align: 'center',
          dataIndex: 'obj_type',
          scopedSlots: { customRender: 'tags' },
        },
        {
          title: '日志条数',
          align: 'center',
          dataIndex: 'num',
        },
        {
          title: '操作',
          align: 'center',
          dataIndex: 'action',
          scopedSlots: {customRender: 'action'}
        }
      ],
      dataSource:[],
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
        list:"/logfv/web/getCount"
      }
    }
  },
  methods:{
    logDetail(record){
      this.$router.push(
          {
            name:'logfvSite_webLog_dateLogDetail',
            params:{
              deviceId:record.device_id,
              deviceName:record.device_name,
              logDate:record.log_date,
              logType:this.logType
            },
            query:{
              meta:{
                title:`详情_${record.device_name}_${moment(parseInt(record.log_date)).format('YYYY-MM-DD')}`
              }
            }
          }
      )
    },
    loadData(arg){
      if (!this.url.list) {
        this.$message.error('请设置url.list属性!')
        return
      }
      if (arg === 1) {
        this.ipagination.current = 1
      }
      this.expandedRowKeys=[]
      let year = this.datetime.get('year')
      let month = this.datetime.get('month')+1
      let day = this.datetime.get('date')
      let params = Object.assign(this.queryParam,{
        pageNo: this.ipagination.current,
        pageSize: this.ipagination.pageSize,
        year,
        month,
        day,
        logType:this.logType
      })
      this.loading = true
      getAction(this.url.list, params).then((res) => {
        if (res.success) {
          this.dataSource = res.value.pageData
          this.ipagination.total = res.value.pageInfo.totalCount
        }else{
          this.$message.warning(res.msg)
        }
        this.loading = false
      })
    }
  }
}
</script>

<style scoped>
</style>
