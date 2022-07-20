const logfvSite = {
    state: {
        content:'hello',
        highlightStartIndex:-1,
        highlightEndIndex:-1,
        logMoveDistance:66,
        lastLoadMinSpan:1500
    },
    mutations:{
        setHighlightStartIndex(state,startLogIndex){
            state.highlightStartIndex = startLogIndex

        },
        setHighlightEndIndex(state,endLogIndex){
            state.highlightEndIndex=endLogIndex
        }
    },
    actions:{
    }
}

export default logfvSite
