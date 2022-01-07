import {timeFormat2Day, validateInit, generateDates, checkParams} from '../../src/packages/logfv-web-vue/src/index'

describe('logfv-web-vue', () => {
  it('checkParams', () => {
    expect(checkParams({
      reportUrl:'aa',
      appId:'aa'
    })).toBe(true)
  })
  it('checkParams2', () => {
    expect(checkParams({
      reportUrl:'',
    })).toBe(false)
  })
  it('checkParams3', () => {
    expect(checkParams({})).toBe(false)
  })
  it('validateInit', () => {
    expect(validateInit(true)).toBe(true)
  })
  it('timeFormat2Day', () => {
    expect(timeFormat2Day(new Date())).toBe('2021-08-02')
  })
  it('generateDates', () => {
    expect(generateDates(2)).toEqual({
      fromDayString:'2021-08-01',
      toDayString:'2021-08-02'
    })
  })
})
