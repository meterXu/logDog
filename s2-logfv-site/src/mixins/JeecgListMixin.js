/**
 * 新增修改完成调用 modalFormOk方法 编辑弹框组件ref定义为modalForm
 * 高级查询按钮调用 superQuery方法  高级查询组件ref定义为superQueryModal
 * data中url定义 list为查询列表  delete为删除单条记录  deleteBatch为批量删除
 */
import { util } from '@dpark/s2-utils'
import { deleteAction, getAction, downFile } from '../api/manage'

export const JeecgListMixin = {
    data() {
        return {
            // token header
            tokenHeader: {  },
            /* 查询条件-请不要在queryParam中声明非字符串值的属性 */
            queryParam: {},
            /* 数据源 */
            dataSource: [],
            /* 分页参数 */
            ipagination: {
                current: 1,
                pageSize: 10,
                size:"normal",
                pageSizeOptions: ['10', '20', '30'],
                showTotal: (total, range) => {
                    return range[0] + '-' + range[1] + ' 共' + total + '条'
                },
                showSizeChanger: true,
                total: 0
            },
            /* 排序参数 */
            isorter: {
                column: 'createTime',
                order: 'desc'
            },
            /* 筛选参数 */
            filters: {},
            /* table加载状态 */
            loading: false,
            /* table选中keys */
            selectedRowKeys: [],
            /* table选中records */
            selectionRows: [],
            /* 查询折叠 */
            toggleSearchStatus: false,
            /* 高级查询条件生效状态 */
            superQueryFlag: false,
            /* 高级查询条件 */
            superQueryParams: ''
        }
    },
    created() {
        if (!this.disableMixinCreated) {
            this.loadData()
            // 初始化字典配置 在自己页面定义
            this.initDictConfig()
        }
    },
    methods: {
        loadData(arg) {
            if (!this.url.list) {
                this.$message.error('请设置url.list属性!')
                return
            }
            // 加载数据 若传入参数1则加载第一页的内容
            if (arg === 1) {
                this.ipagination.current = 1
            }
            var params = this.getQueryParams()// 查询条件
            this.loading = true
            getAction(this.url.list, params).then((res) => {
                if (res.success) {
                    this.dataSource = res.result.records
                    this.ipagination.total = res.result.total
                }
                if (res.code === 510) {
                    this.$message.warning(res.message)
                }
                this.loading = false
            })
        },
        initDictConfig() {},
        handleSuperQuery(arg) {
            // 高级查询方法
            if (!arg) {
                this.superQueryParams = ''
                this.superQueryFlag = false
            } else {
                this.superQueryFlag = true
                this.superQueryParams = JSON.stringify(arg)
            }
            this.loadData()
        },
        getQueryParams() {
            // 获取查询条件
            let sqp = {}
            if (this.superQueryParams) {
                sqp['superQueryParams'] = encodeURI(this.superQueryParams)
            }
            var param = Object.assign(sqp, this.queryParam, this.isorter, this.filters)
            param.field = this.getQueryField()
            param.pageNo = this.ipagination.current
            param.pageSize = this.ipagination.pageSize
            return util.filterObj(param)
        },
        getQueryField() {
            var str = 'id,'
            this.columns.forEach(function (value) {
                str += ',' + value.dataIndex
            })
            return str
        },
        onSelectChange(selectedRowKeys, selectionRows) {
            this.selectedRowKeys = selectedRowKeys
            this.selectionRows = selectionRows
        },
        onClearSelected() {
            this.selectedRowKeys = []
            this.selectionRows = []
        },
        searchQuery() {
            this.loadData(1)
        },
        superQuery() {
            this.$refs.superQueryModal.show()
        },
        searchReset() {
            this.queryParam = {}
            this.loadData(1)
        },
        batchDel: function () {
            this.$message.success('删除成功')
        },
        handleDelete: function (id) {
            console.log(id);
            this.$message.success('删除成功')
        },
        handleDeleteByFormCode(formCode) {
            if (!this.url.deleteByFormCode) {
                this.$message.error('请设置url.deleteByFormCode属性!')
                return
            }
            const that = this
            deleteAction(that.url.deleteByFormCode, { formCode: formCode }).then((res) => {
                if (res.success) {
                    that.$message.success(res.message)
                    that.loadData()
                } else {
                    that.$message.warning(res.message)
                }
            })
        },
        handleEdit: function (record) {
            this.$refs.modalForm.edit(record)
            this.$refs.modalForm.title = '编辑'
            this.$refs.modalForm.disableSubmit = false
        },
        handleAdd: function () {
            this.$refs.modalForm.add()
            this.$refs.modalForm.title = '新增'
            this.$refs.modalForm.disableSubmit = false
        },
        handleTableChange(pagination, filters, sorter) {
            // 分页、排序、筛选变化时触发
            if (Object.keys(sorter).length > 0) {
                this.isorter.column = sorter.field
                this.isorter.order = sorter.order == 'ascend' ? 'asc' : 'desc'
            }
            this.ipagination = pagination
            this.loadData()
        },
        handleToggleSearch() {
            this.toggleSearchStatus = !this.toggleSearchStatus
        },
        modalFormOk() {
            // 新增/修改 成功时，重载列表
            this.loadData()
        },
        handleDetail: function(record) {
            this.$refs.modalForm.edit(record)
            this.$refs.modalForm.title = '详情'
            this.$refs.modalForm.disableSubmit = true
        },
        /* 导出 */
        handleExportXls2() {
            let paramsStr = encodeURI(JSON.stringify(this.getQueryParams()))
            let url = null
            window.location.href = url
        },
        handleExportXls(fileName) {
            if (!fileName || typeof fileName !== 'string') {
                fileName = '导出文件'
            }
            let param = { ...this.queryParam }
            if (this.selectedRowKeys && this.selectedRowKeys.length > 0) {
                param['selections'] = this.selectedRowKeys.join(',')
            }
            console.log('导出参数', param)
            downFile(this.url.exportXlsUrl, param).then((data) => {
                if (!data) {
                    this.$message.warning('文件下载失败')
                    return
                }
                if (typeof window.navigator.msSaveBlob !== 'undefined') {
                    window.navigator.msSaveBlob(new Blob([data], { type: 'application/vnd.ms-excel' }), fileName + '.xls')
                } else {
                    let url = window.URL.createObjectURL(new Blob([data], { type: 'application/vnd.ms-excel' }))
                    let link = document.createElement('a')
                    link.style.display = 'none'
                    link.href = url
                    link.setAttribute('download', fileName + '.xls')
                    document.body.appendChild(link)
                    link.click()
                    document.body.removeChild(link) // 下载完成移除元素
                    window.URL.revokeObjectURL(url) // 释放掉blob对象
                }
            })
        },
        /* 导入 */
        handleImportExcel(info) {
            if (info.file.status !== 'uploading') {
                console.log(info.file, info.fileList)
            }
            if (info.file.status === 'done') {
                if (info.file.response.success) {
                    if (info.file.response.code === 201) {
                        let { message, result: { msg, fileUrl, fileName } } = info.file.response
                        let href = null
                        this.$warning({
                            title: message,
                            content: (
                                <div>
                                    <span>{msg}</span><br/>
                                    <span>具体详情请 <a href={href} target="_blank" download={fileName}>点击下载</a> </span>
                                </div>
                            )
                        })
                    } else {
                        this.$message.success(info.file.response.message || `${info.file.name} 文件上传成功`)
                    }
                    this.loadData()
                } else {
                    this.$message.error(`${info.file.name} ${info.file.response.message}.`)
                }
            } else if (info.file.status === 'error') {
                this.$message.error(`文件上传失败: ${info.file.msg} `)
            }
        },
        /* 图片预览 */
        getImgView(text) {
            if (text && text.indexOf(',') > 0) {
                text = text.substring(0, text.indexOf(','))
            }
            return null
        },
        /* 文件下载 */
        uploadFile(text) {
            if (!text) {
                this.$message.warning('未知的文件')
                return
            }
            if (text.indexOf(',') > 0) {
                text = text.substring(0, text.indexOf(','))
            }
            window.open(null)
        },
        fmtCon(value, field, isHtml) {
            const noValue = '-'
            switch (field.fieldType) {
                case 'switch':
                case 'radio':
                case 'select': {
                    const dicData = field.dictData ? JSON.parse(field.dictData) : []
                    const props = field.props ? JSON.parse(field.props) : { 'label': 'label', 'value': 'value' }
                    const item = dicData.find(f => f[props.value] == value)
                    if (item) {
                        return item[props.label]
                    } else {
                        return value || noValue
                    }
                }
                case 'rate': {
                    const texts = ['极差', '失望', '一般', '满意', '惊喜']
                    if (value <= 0) {
                        return noValue
                    } else {
                        return `${value}-${texts[value - 1]}`
                    }
                }
                case 'url':
                case 'img': {
                    if (isHtml) {
                        return (<a target="_blank" href={value ? JSON.parse(value)[0] : 'javascript:;'}>{value ? JSON.parse(value)[0] : noValue}</a>)
                    } else {
                        return value ? JSON.parse(value)[0] : noValue
                    }
                }
                case 'array': {
                    if (isHtml) {
                        return JSON.parse(value).map(c => {
                            return (<a-tag>c</a-tag>)
                        })
                    } else {
                        return value || noValue
                    }
                }
                default: {
                    return value || noValue
                }
            }
        }
    }

}
