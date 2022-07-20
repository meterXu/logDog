const config = require('./config.json')
const provider = require('./common/provider');
const fs = require('fs');
const dataProvider = provider.mysqlProvider
const lastVersion = 'v1.0'
let files = {
    schema: ["./dbsql/schema.sql"],
    data: ["./dbsql/data.sql"],
    update: ["./dbsql/update.sql"]
}

async function readSql(files) {
    return new Promise(async (resolve, reject) => {
        try {
            let sqls = [];
            for (let i = 0; i < files.length; i++) {
                let data = await fs.readFileSync(files[i])
                sqls.push(data.toString())
            }
            resolve(sqls)
        } catch (err) {
            reject(err)
        }
    })
}

async function execSchema() {
    try {
        let rows = await dataProvider.query(config, 'SHOW TABLES')
        if (rows.length === 0) {
            let sqlArray = await readSql(files.schema)
            for (let i = 0; i < sqlArray.length; i++) {
                await dataProvider.query(config, sqlArray[i])
                console.log("表结构初始化成功")
            }
        }else{
            console.log("表结构已初始化")
        }
    } catch (err) {
        console.error(err)
        console.log("表结构初始化失败")
    }
}

async function execData() {
    try {
        let sqlArray = await readSql(files.data)
        for (let i = 0; i < sqlArray.length; i++) {
            await dataProvider.query(config, sqlArray[i])
            console.log("数据初始化成功")
        }
    } catch (err) {
        console.error(err)
        console.log("数据初始化失败")
    }
}

async function checkUpdate() {
    try{
        let rows = await dataProvider.query(config, 'select * from logdog_version order by create_time desc')
        if(rows.length==0||rows[0]['version']!=lastVersion){
            let sqlArray = await readSql(files.update)
            for (let i = 0; i < sqlArray.length; i++) {
                await dataProvider.query(config, sqlArray[i])
                console.log("数据库更新成功")
            }
        }else{
            console.log("数据库无更新项")
        }
    }catch (err){
        console.error(err)
        console.log("数据库更新失败")
    }
}

async function main() {
    await execSchema()
    await execData()
    await checkUpdate()
}

main()
