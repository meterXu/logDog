<template>
  <a-card class="detail-information-container" :headStyle="myantcardhead">
    <div class="metadata">
      <div v-for="prop in Object.keys(this.titleByKey)" class="metadata-item" :key="prop">
        <template
          v-if="prop === 'logType'"
        >{{ titleByKey[prop] }} : {{ logDetail.expand.logTypeName }}</template>
        <a-tooltip placement="top" :arrowPointAtCenter="true" v-else>
          <template slot="title">
            <span>{{ titleByKey[prop] }} : {{ logDetail[prop] }}</span>
          </template>
          {{ titleByKey[prop] }} : {{ logDetail[prop] }}
        </a-tooltip>
      </div>
    </div>
    <div v-if="logDetail" class="log-content">
      日志信息:
      <br />
      <div id="logfv-code">
        <codemirror style="height: 500px" :options="cmOptions" :value="realContent"></codemirror>
      </div>
    </div>
    <template slot="title">
      <header>
        <h1 class="card-head-title">日志条目详情</h1>
      </header>
    </template>
    <template slot="extra">
      <a-button icon="close" shape="circle" size="small" @click="handleCloseButtonClicked"></a-button>
    </template>
  </a-card>
</template>

<script>
import 'codemirror/lib/codemirror.css'
import 'codemirror/addon/fold/foldgutter.css'
import 'codemirror/theme/panda-syntax.css'
import 'codemirror/mode/javascript/javascript.js'
import 'codemirror/addon/fold/foldcode.js'
import 'codemirror/addon/fold/foldgutter.js'
import 'codemirror/addon/fold/brace-fold.js'
import 'codemirror/addon/fold/comment-fold.js'
import 'codemirror/addon/selection/active-line.js'
import 'codemirror/addon/edit/matchbrackets.js'
import { codemirror } from 'vue-codemirror'
export default {
  name: "LogDetailCard",
  props: ["logDetail"],
  components: { codemirror },
  data() {
    return {
      titleByKey: {
        "id": "日志编号",
        "task_id": "系统编号",
        "log_type": "日志类型",
        "canReadTime": "日志记录时间",
        "web_source": "日志来源",
        "environment": "环境信息",
        "custom_report_info": "自定义信息"
      },
      myantcardhead: {
        "min-height": '48px',
        "margin-bottom": "-1px",
        padding: '0 24px',
        color: 'rgba(0,0,0,.85)',
        'font-weight': '500',
        'font-size': '16px',
        background: 'transparent',
        'border-bottom': '1px solid #e8e8e8',
        'border-radius': '2px 2px 0 0',
        zoom: 1
      },
      cmOptions: {
        tabSize: 4,
        mode: 'text/javascript',
        theme: "panda-syntax",
        lineNumbers: true,
        lineWrapping: true,
        matchBrackets: true,
        styleActiveLine: true,
        line: true,
        foldGutter: true,
        gutters: ['CodeMirror-linenumbers', 'CodeMirror-foldgutter'],
      }
    }
  },
  computed: {
    realContent() {
      if (this.logDetail.content&&this.logDetail.content.indexOf('{') === 0) {
        return JSON.stringify(JSON.parse(this.logDetail.content), null, 2)
      } else {
        return this.logDetail.content
      }

    }
  },
  methods: {
    handleCloseButtonClicked() {
      this.$emit("update:logDetail", null)
    }
  }
}
</script>

<style scoped>
.detail-information-container {
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  position: absolute;
  right: 0;
  left: 50%;
  top: 0;
  bottom: 24px;
  margin-left: 10px;
  overflow-y: auto;
  overflow-x: hidden;
  color: rgba(0, 0, 0, 0.65);
}
.card-head-title {
  line-height: 1rem;
  font-size: 1rem;
  margin: 0;
}
.metadata {
  padding-bottom: 12px;
  border-bottom: 1px solid #e8e8e8;
}
.metadata-item {
  margin: 4px 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.log-content {
  padding-top: 12px;
  word-break: break-all;
}
.log-content pre {
  word-break: break-all;
}
</style>
<style>
#logfv-code {
  overflow-y: auto;
  overflow-x: hidden;
  right: 12px;
  left: 12px;
  border: 1px solid #ddd;
}
#logfv-code .CodeMirror {
  height: 100% !important;
}
</style>
