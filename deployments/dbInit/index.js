const config = require('./config.json')
const provider = require('./common/provider');
const fs = require('fs');
const dataProvider = provider.mysqlProvider

let files=[
    "./dbsql/initDB.sql"
]
async function initDB(){
    try{
        let sqlStrs = await readSql(files)
        for (let i =0;i<sqlStrs.length;i++){
            await dataProvider.query(config,sqlStrs[i])
            console.log("数据库初始化成功")
        }
    }catch (err){
        console.error(err)
        console.log("数据库初始化失败")
    }

}

async function readSql(files) {
    return new Promise(async (resolve, reject)=>{
        try{
            let sqls = [];
            for(let i=0;i<files.length;i++){
                let data = await fs.readFileSync(files[i])
                sqls.push(data.toString())
            }
            resolve(sqls)
        }catch (err){
            reject(err)
        }
    })
}

async function main(){
    let rows =await dataProvider.query(config,'SHOW TABLES')
    if(rows.length===0){
        await initDB()
    }
}

main()
