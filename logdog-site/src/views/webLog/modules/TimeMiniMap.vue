<template>
  <div class="timeMiniMap">
    <div ref="timeline_container" id="timeline-container"></div>
    <LogTooltip
        :hoveredLog="hoveredLog"
        :showing="showToolTip"
        :x="toolTipX"
        :y="toolTipY"
    />
  </div>
</template>

<script>
import LogTooltip from './LogTooltip'
import Konva from "konva";
import moment from "moment";
import {portal} from "@dpark/s2-utils";
export default {
  name: "TimeMiniMap",
  components:{LogTooltip},
  props:["source","startIndex","endIndex"],
  data(){
    return {
      showToolTip:false,
      hoveredLog:null,
      toolTipX:0,
      toolTipY:0,
      timelineMarginTop:20,
      timelineMarginBottom:20,
      timelineWidth:30,
      timelineLeftOffset:8,
      initialPrepareHeight:0
    }
  },
  watch:{
    source:{
      handler:function (nv){
        if(nv&&nv.length>0){
          this.initComponents();
        }
      }
    },
    startIndex(nv){
      this.prepareLocator(false)
    }
  },
  methods:{
    // 绘制日志导航条
    initComponents(){
        if (!this.$container) {
          this.prepareContainer();
        }
        this.stage = new Konva.Stage({
          container: "#timeline-container",
          width: this.$container.offsetWidth,
          height: this.$container.offsetHeight
        });
        this.timeline = new Konva.Layer({
          clearBeforeDraw: true
        });
        this.stage.add(this.timeline);
        this.timelineHeight = this.timeline.getHeight() - this.timelineMarginTop - this.timelineMarginBottom;
        this.renderOutline();
        if (this.source && this.source.length > 0) {
          this.renderBeginEndTimeStamp();
          this.renderLogLines();
        }
        this.prepareHoverMark();
        this.prepareLocator(true);
        this.initMouseEvent();
        this.stage.draw();
    },
    prepareContainer(){
      this.$container = this.$refs.timeline_container;
      this.clientHeight = this.$container.clientHeight;
      this.clientWidth = this.$container.clientWidth;
    },
    renderOutline(){
      const timelineLeftBorder = new Konva.Line({
        points: [
          this.timelineLeftOffset,
          this.timelineMarginTop,
          this.timelineLeftOffset,
          this.timelineMarginTop + this.timelineHeight
        ],
        stroke: "grey",
        strokeWidth: 1
      });
      const timelineRightBorder = timelineLeftBorder.clone().move({ x: this.timelineWidth, y: 0 });
      this.timeline.add(timelineLeftBorder);
      this.timeline.add(timelineRightBorder);
    },
    renderBeginEndTimeStamp(){
      const startTime = new Konva.Text({
        fontFamily: "serif",
        fontSize: 11,
        text: moment(this.source[0].time).format("HH:mm:ss"),
        x: 5,
        y: 5
      });
      const endTime = new Konva.Text({
        fontFamily: "serif",
        fontSize: 11,
        text: moment(this.source[this.source.length - 1].time).format("HH:mm:ss"),
        x: 5,
        y: 5 + this.timelineMarginTop + this.timelineHeight
      });

      this.timeline.add(startTime);
      this.timeline.add(endTime);
    },
    renderLogLines(){
      const lineCanvasHeightSpan = this.timelineHeight / (this.source.length - 1);
      for (let i = 0; i < this.source.length; i++) {
        const logLine = new Konva.Line({
          points: [
            this.timelineLeftOffset,
            lineCanvasHeightSpan * i + this.timelineMarginTop,
            this.timelineLeftOffset + this.timelineWidth,
            lineCanvasHeightSpan * i + this.timelineMarginTop
          ],
          strokeWidth: 1,
          stroke: this.source[i].logType.displayColor
        });
        this.timeline.add(logLine);
      }
    },
    prepareHoverMark(){
      this.hoverMark = new Konva.Line({
        points: [4, 0, this.timelineLeftOffset + this.timelineWidth + 4, 0],
        stroke: "#8c8c8c",
        strokeWidth: 2
      });
      this.timeline.add(this.hoverMark);
      this.hoverMark.hide();
    },
    prepareLocator(isCreate){
      if (this.startIndex >= 0 && this.endIndex >= 0) {
        const [startX, startY] = this.calculateCoordinateFromLogIndex(this.startIndex);
        const [endX, endY] = this.calculateCoordinateFromLogIndex(this.endIndex);
        if(this.locator&&!isCreate){
          this.locator.y(startY)
          this.locator.height(endY - startY)
        }else{
          this.initialPrepareHeight=this.calcPrepareLocatorHeight(this.startIndex,this.endIndex)
          let that = this
          this.locator = new Konva.Rect({
            x: startX,
            y: startY,
            width: this.timelineWidth,
            height: this.initialPrepareHeight,
            stroke: "#000000",
            strokeWidth: 3,
            opacity: 0.5,
            fill: "#8c8c8c",
            draggable: true,
            dragBoundFunc: function(pos) {
              let newY = pos.y < that.timelineMarginTop  ? that.timelineMarginTop : pos.y;
              newY = newY>that.clientHeight-(endY - startY)-that.timelineMarginBottom?that.clientHeight-(endY - startY)-that.timelineMarginBottom:newY
              return {
                x: startX,
                y: newY,
              };
            }
          });
          this.locator.on('dragend', function() {
            let pr =  (that.locator.y()-that.timelineMarginTop)/that.timelineHeight
            that.$emit('onLocatorMove',pr)
          });
          this.timeline.add(this.locator);
        }
      }
    },
    calcPrepareLocatorHeight(startIndex, endIndex){
      const lineCssHeightSpan = this.timelineHeight / (this.source.length - 1);
      return lineCssHeightSpan*(endIndex-startIndex)
    },
    calculateCoordinateFromLogIndex(index){
      const lineCssHeightSpan = this.timelineHeight / (this.source.length - 1);
      return [this.timelineLeftOffset, lineCssHeightSpan * index + this.timelineMarginTop];
    },
    reversecalculateCoordinateFromLogIndex(y1, y2){
      const lineCssHeightSpan = this.timelineHeight / (this.source.length - 1);
       y1 = y1-this.timelineMarginTop
       y2 = y2-this.timelineMarginTop
      if(y1<0){
        y1 =0
      }
      if(y2>this.timelineHeight){
        y2 = this.timelineHeight
      }
      if(y2-y1<this.initialPrepareHeight){
        y1=y2-this.initialPrepareHeight
      }
      return [y1/lineCssHeightSpan,y2/lineCssHeightSpan]
    },
    initMouseEvent(){
      document.addEventListener("mousemove", this.onMouseMove);
      document.addEventListener("click", this.onClick);

    },
    isInTimeline(x, y){
      const isHorizontalInner = x > this.timelineLeftOffset && x < this.timelineLeftOffset + this.timelineWidth;
      const isVerticalInner = y > this.timelineMarginTop && y < this.timelineMarginTop + this.timelineHeight;
      return isHorizontalInner && isVerticalInner;
    },
    calculateLogIndexFromCoordinate(x, y){
      const MOUSE_TOLERENCE = 1; // 上下像素容错范围
      const lineCssHeightSpan = this.timelineHeight / (this.source.length - 1);
      const outOfLineRange = y % lineCssHeightSpan; // 鼠标hover处距离某条line多少高度
      if (outOfLineRange < MOUSE_TOLERENCE) {
        return parseInt(y / lineCssHeightSpan);
      } else if (outOfLineRange > lineCssHeightSpan - MOUSE_TOLERENCE) {
        return parseInt(y / lineCssHeightSpan) + 1;
      } else {
        return null;
      }
    },
    onMouseMove(event) {
      if (this.isInTimeline(event.offsetX, event.offsetY)) {
        const logIndex = this.calculateLogIndexFromCoordinate(event.offsetX, event.offsetY - this.timelineMarginTop);
        if (logIndex !== null && event.target.localName === "canvas") {
          this.showToolTip= true
          this.hoveredLog= this.source[logIndex]
          this.toolTipX= this.$container.clientWidth + this.$container.offsetLeft
          if(event.offsetY+400>window.outerHeight){
            this.toolTipY= event.offsetY-40
          }else{
            this.toolTipY= event.offsetY
          }
        }
        this.hoverMark.y(event.offsetY);
        if (!this.hoverMark.isVisible()) {
          this.hoverMark.show();
        }
      } else {
        this.showToolTip=false
        if (this.hoverMark.isVisible()) {
          this.hoverMark.hide();
        }
      }
      if (event.target.localName === "canvas") {
        this.stage.draw();
      }
    },
    onClick(event){
      if (this.isInTimeline(event.offsetX, event.offsetY) && event.target.localName === "canvas") {
        if (this.hoveredLog !== null) {
          let y1 =event.offsetY-this.locator.height()/2
          let y2 = event.offsetY+this.locator.height()/2
          let [highlightStartIndex,highlightEndIndex] = this.reversecalculateCoordinateFromLogIndex(y1,y2)
          portal.globalStore.commit("setHighlightStartIndex",highlightStartIndex)
          portal.globalStore.commit("setHighlightEndIndex", highlightEndIndex)
          let pr =  (y1-this.timelineMarginTop)/(this.timelineHeight)
          this.$emit('onLocatorMove',pr)
        }
      }
    }
  },
  beforeDestroy() {
    document.removeEventListener("mousemove", this.onMouseMove);
    document.removeEventListener("click", this.onClick);
  },
  mounted() {
    if(this.source&&this.source.length>0){
      this.initComponents();
    }
  }
}
</script>

<style scoped>
.timeMiniMap{
  position: absolute;
  left: 0;
  width: 50px;
  top: 0;
  bottom: 0;
}
#timeline-container{
  width: 50px;
  height: calc(100% - 24px);
  background: #fff;
}
</style>
