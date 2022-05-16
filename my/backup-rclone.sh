#需要备份的目录，多个空格隔开
datas="/opt /out/mysql /out/mysql7 /out/mysql8"
#备份文件生成路径
outdir="/opt/minio/data/backup"

#记录当前时间
nowTime=$(date "+%Y-%m %d-%H:%M:%S")
# 创建目录
mkdir -p $outdir

#遍历目录进行压缩备份
for i in $datas;
do
	fileName=${i##*/}
	outfilePath=$outdir/$fileName.zip
	zip -r $outfilePath $i
	echo "打包$fileName到$outfilePath完成..."
done
rclone sync -v cch1: ali:backup --log-file=/out/backup-rclone.log
rm -rf $outdir
echo "$nowTime: $outdir备份完成..."