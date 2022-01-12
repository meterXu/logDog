<template>
  <a-card :bordered="false">
    <!-- 查询区域 -->
    <div class="table-page-search-wrapper">
      <a-form layout="inline" @keyup.enter.native="searchQuery">
        <a-row :gutter="24">
          <a-col :md="6" :sm="8">
            <a-form-item label="应用名称">
              <a-input allowClear placeholder="请输入应用名称" v-model="queryParam.deviceName"></a-input>
            </a-form-item>
          </a-col>
          <a-col :md="6" :sm="8">
            <a-form-item label="应用类别">
              <a-select placeholder="请输入应用类别" v-model="queryParam.objType">
                <a-select-option value="">
                  <span style="background:#555" class="type-icon"></span> 全部
                </a-select-option>
                <a-select-option value="1">
                  <span style="background:#1890ff" class="type-icon"></span> 系统
                </a-select-option>
                <a-select-option value="2">
                  <span style="background:#52c41a" class="type-icon"></span> 组件
                </a-select-option>
              </a-select>
            </a-form-item>
          </a-col>
          <a-col :md="6" :sm="8">
            <a-form-item label="日期范围">
              <a-range-picker :placeholder="['日期范围','日期范围']" v-model="dateRange" format="YYYY-MM-DD" />
            </a-form-item>
          </a-col>
          <a-col :md="6" :sm="8">
            <span
                style="float: left;overflow: hidden;"
                class="table-page-search-submitButtons"
            >
              <a-button type="primary" @click="searchQuery" icon="search">查询</a-button>
              <a-button
                  type="primary"
                  @click="searchReset"
                  icon="reload"
                  style="margin-left: 8px"
              >重置</a-button>
            </span>
          </a-col>
        </a-row>
      </a-form>
    </div>
    <!-- 查询区域-END -->
    <div>
      <div class="ant-alert ant-alert-info" style="margin-bottom: 16px;">
        <a style="margin-left: 0px" @click="onClearSelected">
          <a-icon type="info-circle"/>
          展开查看系统日志，按日期分类汇总！</a>
      </div>

      <a-table
          ref="table"
          size="middle"
          bordered
          rowKey="device_id"
          :columns="columns"
          :dataSource="dataSource"
          :pagination="ipagination"
          :loading="loading"
          :expandRowByClick="true"
          :expandedRowKeys.sync="expandedRowKeys"
          @change="handleTableChange"
      >
        <p slot="expandedRowRender" slot-scope="record" style="margin: 0">
          <ExpandTable  :record="record" :dateRange="dateRangeStrs"/>
        </p>
        <span slot="tags" slot-scope="type">
          <a-tag v-if="type===2"  color="green">组件</a-tag>
          <a-tag v-else  color="blue">系统</a-tag>
        </span>
      </a-table>
    </div>
  </a-card>
</template>

<script>
import {JeecgListMixin} from '../../mixins/JeecgListMixin'
import {getAction} from "../../api/manage";
import moment from 'moment'
import ExpandTable from "./modules/ExpandTable";
export default {
  name: 'webLog',
  mixins: [JeecgListMixin],
  components: {
    ExpandTable
  },
  data() {
    return {
      description: '日志列表页面',
      modelVisible: false,
      formObj: {},
      queryParam: {
        deviceId:"",
        deviceName:"",
        startDate:"",
        endDate:"",
        objType:""
      },
      dateRange:[],
      dateRangeStrs:[],
      columns: [
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
          title: '最新日志日期',
          align: 'center',
          dataIndex: 'last_log_date',
          customRender: (text, record, index) => {
            return {
              children: moment(text).format('YYYY-MM-DD'),
              attrs: {}
            }
          }
        },
        {
          title: '日志分片总数',
          align: 'center',
          width: 200,
          dataIndex: 'log_page_num'
        }
      ],
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
      url: {
        list: '/logfv/web/query',
        deleteBatch: '',
        exportXlsUrl: '',
        importExcelUrl: '',
        minioUpload: ''

      },
      dictOptions: {},
      expandTables:{},
      expandedRowKeys:[]
    }
  },
  computed: {
  },
  methods: {
    loadData(arg) {
      if (!this.url.list) {
        this.$message.error('请设置url.list属性!')
        return
      }
      if (arg === 1) {
        this.ipagination.current = 1
      }
      this.fmtDateRang()
      this.expandedRowKeys=[]
      let params = Object.assign(this.queryParam,{
        pageNo: this.ipagination.current,
        pageSize: this.ipagination.pageSize
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
    },
    searchQuery() {
      this.loadData(1)
    },
    searchReset() {
      this.queryParam={
        deviceId:"",
        deviceName:"",
        objType:"",
        startDate:"",
        endDate:""
      }
      this.dateRange=[]
      this.loadData()
    },
    fmtDateRang(){
      if(this.dateRange.length>=2){
        this.queryParam.startDate = new Date(this.dateRange[0].format("yyyy-MM-DD 00:00:00")).valueOf()
        this.queryParam.endDate = new Date(this.dateRange[1].format("yyyy-MM-DD 23:59:59")).valueOf()
      }else{
        this.queryParam.startDate=""
        this.queryParam.endDate=""
      }
      this.dateRangeStrs = [this.queryParam.startDate,this.queryParam.endDate]
    }
  }
}
</script>
<style scoped>
@import "../../assets/less/common.less";
.type-icon{
  width: 10px;
  height: 10px;
  display: inline-block;
  border-radius: 5px;
}
</style>
<style>
.child-table .ant-pagination{
  float: left;
  margin-left: 15px;
}
</style>
